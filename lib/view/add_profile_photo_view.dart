import 'dart:io'; // Image.file için gerekli

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_case/bloc/auth/auth_bloc.dart';
import 'package:movie_case/bloc/profile_photo/profile_photo_bloc.dart';
// Diğer component importlarınız
import 'package:movie_case/components/appbar/custom_appbar.dart';
import 'package:movie_case/components/button/custom_elevated_button.dart';
import 'package:movie_case/components/container/login_register_text.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/repositories/profile_repository.dart';
import 'package:movie_case/view/profile_detail_view.dart'; // Yönlendirme için

class AddProfilePhoto extends StatelessWidget {
  const AddProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider ile ProfilePhotoBloc'u bu widget ağacına sağlıyoruz.
    return BlocProvider(
      create: (context) => ProfilePhotoBloc(
        // Repository'i BLoC'a enjekte ediyoruz.
        // Eğer Repository'niz zaten üst bir widget'tan sağlanıyorsa
        // context.read<ProfileRepository>() kullanabilirsiniz.
        ProfileRepository(),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF090909),
        appBar: CustomAppbar(
          onPres: () {
            // Geri dönüldüğünde profil sayfasına git
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          // BlocConsumer hem arayüzü günceller hem de state geçişlerini dinler.
          child: BlocConsumer<ProfilePhotoBloc, ProfilePhotoState>(
            // LISTENER: Tek seferlik eylemler için kullanılır (Snackbar, Navigation vb.)
            listener: (context, state) {
              if (state is ProfilePhotoUploaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Fotoğraf başarıyla yüklendi!"),
                    backgroundColor: Colors.green,
                  ),
                );
                // Yükleme başarılı olunca profil detay sayfasına yönlendir.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileDetailView()),
                );
              } else if (state is ProfilePhotoFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Bir hata oluştu: ${state.error}"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            // BUILDER: State'e göre arayüzü yeniden çizmek için kullanılır.
            builder: (context, state) {
              return Column(
                children: [
                  LoginRegisterText(
                    title: AppLocalizations.of(context)!.upload_photo,
                    descr:
                        "Resources out incentivize relaxation floor loss cc.",
                  ),
                  const SizedBox(height: 48),

                  // Fotoğraf seçme alanı
                  GestureDetector(
                    onTap: () {
                      // Eğer yükleme işlemi devam etmiyorsa fotoğraf seçme event'ini tetikle.
                      if (state is! ProfilePhotoLoading) {
                        context.read<ProfilePhotoBloc>().add(
                          PickPhotoRequested(),
                        );
                      }
                    },
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          24,
                        ), // Tam daire için
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        // State'e göre container'ın içini dolduruyoruz
                        child: _buildPhotoHolder(context, state),
                      ),
                    ),
                  ),
                  const Spacer(), // Butonu en alta itmek için
                  // Yükleme Butonu
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: AppLocalizations.of(context)!.continous,
                      onPressed: () {
                        // Sadece fotoğraf seçilmişse yükleme işlemini başlat.
                        if (state is ProfilePhotoSelected) {
                          context.read<ProfilePhotoBloc>().add(
                            UploadPhotoRequested(imagePath: state.imagePath),
                          );
                          context.read<AuthBloc>().add(GetProfileRequested());
                        } else {
                          // Kullanıcı fotoğraf seçmeden butona basarsa uyar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Lütfen önce bir fotoğraf seçin."),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // State'e göre gösterilecek widget'ı belirleyen yardımcı fonksiyon
  Widget _buildPhotoHolder(BuildContext context, ProfilePhotoState state) {
    if (state is ProfilePhotoLoading) {
      // Yükleniyor durumu: Ortada bir progress indicator göster.
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    } else if (state is ProfilePhotoSelected) {
      // Fotoğraf seçildi durumu: Seçilen fotoğrafı göster.
      return Image.file(
        File(state.imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      // Başlangıç veya hata durumu: Artı ikonu göster.
      return Center(
        child: SvgPicture.asset(
          "assets/icons/plus_icon.svg", // SVG dosyanızın yolu
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      );
    }
  }
}
