// LoginView.dart
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
import 'package:movie_case/view/explorer_view.dart';
import 'package:movie_case/view/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090909),
      body: BlocConsumer<AuthBloc, AuthState>(
        // BlocConsumer kullanıyoruz
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ExplorerView()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(39.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 180),
                  LoginRegisterText(
                    title: AppLocalizations.of(context)!.hello,
                    descr:
                        "Tempus varius a vitae interdum id tortor elementum tristique eleifend at.",
                  ),
                  SizedBox(height: 48),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.forgot_pasword,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 1.5,
                            ),
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    text: AppLocalizations.of(context)!.login,
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginRequested(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 48),
                  SocialMediaRow(),
                  SizedBox(height: 48),
                  LoginRegisterBottomText(
                    lightText: AppLocalizations.of(context)!.have_account,
                    underText: AppLocalizations.of(context)!.sign_up,
                    onPresed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterView()),
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
