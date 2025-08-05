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
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/repositories/profile_repository.dart';
import 'package:movie_case/view/profile_detail_view.dart'; // Yönlendirme için

class AddProfilePhoto extends StatelessWidget {
  const AddProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePhotoBloc(ProfileRepository()),
      child: Scaffold(
        backgroundColor: const Color(0xFF090909),
        appBar: CustomAppbar(
          onPres: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
          isOffer: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),

          child: BlocConsumer<ProfilePhotoBloc, ProfilePhotoState>(
            listener: (context, state) {
              if (state is ProfilePhotoUploaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.ok_photo),
                    backgroundColor: Colors.green,
                  ),
                );
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
            builder: (context, state) {
              return Column(
                children: [
                  LoginRegisterText(
                    title: AppLocalizations.of(context)!.upload_photo,
                    descr:
                        "Resources out incentivize relaxation floor loss cc.",
                  ),
                  const SizedBox(height: 48),

                  GestureDetector(
                    onTap: () {
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
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: _buildPhotoHolder(context, state),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: AppLocalizations.of(context)!.continous,
                      onPressed: () {
                        if (state is ProfilePhotoSelected) {
                          context.read<ProfilePhotoBloc>().add(
                            UploadPhotoRequested(imagePath: state.imagePath),
                          );
                          context.read<AuthBloc>().add(GetProfileRequested());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.select_photo,
                              ),
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

  Widget _buildPhotoHolder(BuildContext context, ProfilePhotoState state) {
    if (state is ProfilePhotoLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    } else if (state is ProfilePhotoSelected) {
      return Image.file(
        File(state.imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      return Center(
        child: SvgPicture.asset(
          AppIconAssets.plusIcon,
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      );
    }
  }
}
