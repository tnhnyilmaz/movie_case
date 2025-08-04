import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/bloc/auth/auth_bloc.dart';
import 'package:movie_case/components/Login/social_media_row.dart';
import 'package:movie_case/components/TextFieldComp/custom_textfield.dart';
import 'package:movie_case/components/button/custom_elevated_button.dart';
import 'package:movie_case/components/container/login_register_bottom_text.dart';
import 'package:movie_case/components/container/login_register_text.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';
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
                    title: AppLocalizations.of(context)!.welcome,
                    descr:
                        "empus varius a vitae interdum id tortor elementum tristique eleifend at.",
                  ),
                  SizedBox(height: 28),
                  CustomTextfield(
                    hintStr: AppLocalizations.of(context)!.name_surname,
                    obscureBool: false,
                    preIconStr: AppIconAssets.personIcon,
                    textEditingController: _nameController,
                  ),
                  SizedBox(height: 12),
                  CustomTextfield(
                    preIconStr: AppIconAssets.mailIcon,
                    hintStr: AppLocalizations.of(context)!.mail,
                    obscureBool: false,
                    textEditingController: _emailController,
                  ),
                  SizedBox(height: 12),
                  CustomTextfield(
                    preIconStr: AppIconAssets.passwordIcon,
                    hintStr: AppLocalizations.of(context)!.password,
                    obscureBool: true,
                    sufIconStr: AppIconAssets.passwordHideIcon,
                    textEditingController: _passwordController,
                  ),
                  SizedBox(height: 12),
                  CustomTextfield(
                    preIconStr: AppIconAssets.passwordIcon,
                    hintStr: AppLocalizations.of(context)!.password_again,
                    obscureBool: true,
                    textEditingController: _repeatPasswordController,
                  ),
                  SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.kullnici_soz,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.read_ok,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.read_continues,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36),

                  CustomElevatedButton(
                    text: AppLocalizations.of(context)!.sign_up_now,
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

                  SocialMediaRow(),
                  SizedBox(height: 12),

                  LoginRegisterBottomText(
                    lightText: AppLocalizations.of(context)!.exiting_account,
                    underText: AppLocalizations.of(context)!.login,
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
