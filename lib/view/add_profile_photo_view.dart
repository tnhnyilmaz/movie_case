import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_case/bloc/profile_photo/profile_photo_bloc.dart';
import 'package:movie_case/components/appbar/custom_appbar.dart';
import 'package:movie_case/components/button/custom_elevated_button.dart';
import 'package:movie_case/components/container/login_register_text.dart';
import 'package:movie_case/repositories/profile_repository.dart';
import 'package:movie_case/view/profile_detail_view.dart';

class AddProfilePhoto extends StatelessWidget {
  const AddProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Scaffold(
        backgroundColor: const Color(0xFF090909),
        appBar: CustomAppbar(
          onPres: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileDetailView()),
            );
          },
        ),
        body: BlocProvider(
          create: (_) => ProfilePhotoBloc(ProfileRepository()),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 250,
                          child: LoginRegisterText(
                            title: "Fotoğraflarınızı Yükleyin",
                            descr:
                                "Resources out incentivize relaxation floor loss cc.",
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      BlocConsumer<ProfilePhotoBloc, ProfilePhotoState>(
                        listener: (context, state) {
                          if (state is ProfilePhotoUploaded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Fotoğraf başarıyla yüklendi!"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileDetailView(),
                              ),
                            );
                          } else if (state is ProfilePhotoFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Yükleme hatası: ${state.error}"),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ProfilePhotoBloc>().add(
                                PickPhotoRequested(),
                              );
                            },
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: () {
                                if (state is ProfilePhotoLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is ProfilePhotoSelected) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: Image.file(
                                      File(state.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else if (state is ProfilePhotoFailure) {
                                  return Center(
                                    child: Text(
                                      'Hata: ${state.error}',
                                      style: TextStyle(color: Colors.red),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/plus_icon.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                  );
                                }
                              }(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: "Devam Et",
                      onPressed: () {
                        final bloc = context.read<ProfilePhotoBloc>();
                        final state = bloc.state;

                        if (state is ProfilePhotoSelected) {
                          bloc.add(
                            UploadPhotoRequested(imagePath: state.imagePath),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Lütfen bir fotoğraf seçin!"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
