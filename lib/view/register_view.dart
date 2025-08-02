import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/bloc/auth/auth_bloc.dart';
import 'package:movie_case/components/Login/socia_media_container.dart';
import 'package:movie_case/components/TextFieldComp/custom_textfield.dart';
import 'package:movie_case/components/button/custom_elevated_button.dart';
import 'package:movie_case/components/container/login_register_bottom_text.dart';
import 'package:movie_case/components/container/login_register_text.dart';
import 'package:movie_case/view/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090909),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthAuthenticated) {
            // Başarılı kayıt -> Giriş ekranına yönlendir
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginView()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(39.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 130),

                  LoginRegisterText(
                    title: "Hoşgeldiniz",
                    descr:
                        "empus varius a vitae interdum id tortor elementum tristique eleifend at.",
                  ),
                  SizedBox(height: 28),
                  CustomTextfield(
                    hintStr: "Ad Soyad",
                    obscureBool: false,
                    preIconStr: "assets/icons/person_icon.svg",
                    textEditingController: _nameController,
                  ),
                  SizedBox(height: 12),
                  CustomTextfield(
                    preIconStr: "assets/icons/mail_icon.svg",
                    hintStr: 'E-Posta',
                    obscureBool: false,
                    textEditingController: _emailController,
                  ),
                  SizedBox(height: 12),
                  CustomTextfield(
                    preIconStr: "assets/icons/password_icon.svg",
                    hintStr: "Şifre",
                    obscureBool: true,
                    sufIconStr: "assets/icons/password_hide_icon.svg",
                    textEditingController: _passwordController,
                  ),
                  SizedBox(height: 12),
                  CustomTextfield(
                    preIconStr: "assets/icons/password_icon.svg",
                    hintStr: "Şifre Tekrar",
                    obscureBool: true,
                    textEditingController: _repeatPasswordController,
                  ),
                  SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Euclid Circular A',
                        color: Colors.white.withOpacity(0.5),
                      ),
                      children: [
                        TextSpan(text: "Kullanıcı sözleşmesini "),
                        TextSpan(
                          text: "okudum ve kabul ediyorum",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ". Bu Sözleşmeyi okuyarak devam ediniz lütfen.",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36),

                  CustomElevatedButton(
                    text: 'Şimdi Kaydol',
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        RegisterRequested(
                          email: _emailController.text,
                          name: _nameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 48),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SociaMediaContainer(
                        logoStr: 'assets/icons/google_icon.svg',
                      ),
                      SizedBox(width: 16),
                      SociaMediaContainer(
                        logoStr: 'assets/icons/apple_icon.svg',
                      ),
                      SizedBox(width: 16),
                      SociaMediaContainer(
                        logoStr: 'assets/icons/facebook_icon.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  LoginRegisterBottomText(
                    lightText: "Zaten bir hesabın var mı?",
                    underText: "Giriş Yap!",
                    onPresed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
