import 'package:flutter/material.dart';
import 'package:shelve/app/auth/presenter/controller/auth_controller.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/dialogs.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/core/values/files.dart';
import 'package:shelve/core/values/routes.dart';
import 'package:shelve/core/widgets/buttons/button.dart';

import '../../../../core/widgets/logo/small_logo.dart';

class AuthPage extends StatelessWidget {
  final AuthController controller;

  const AuthPage({required this.controller, super.key});

  Future<void> _formCompleted(Map<String, dynamic>? result,) async {
    if (result != null) {
      if (result.containsKey('user')) {
        loading(
          future: () async =>
          await controller.signUp(
            email: result['email'],
            password: result['password'],
            name: result['user'],
          ),
        );
      } else {
        loading(
          future: () async =>
          await controller.signIn(
            email: result['email'],
            password: result['password'],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SmallLogo(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.38,
              child: Image.asset(Files.illustrationIntro),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
              ),
              child: Text(
                context.strings.introTitle,
                textAlign: TextAlign.center,
                style: context.text.titleMedium,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                context.strings.introText,
                textAlign: TextAlign.center,
                style: context.text.bodySmall?.copyWith(
                  color: context.theme.disabledColor,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Button(
                secondary: true,
                direction: TextDirection.ltr,
                text: context.strings.enterWithGoogle,
                icon: Image.asset(Files.google, width: 21),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Button(
                secondary: true,
                direction: TextDirection.ltr,
                text: context.strings.enterWithApple,
                icon: Image.asset(Files.apple, width: 21),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Button(
                text: context.strings.enterWithEmail,
                direction: TextDirection.ltr,
                icon: Transform.translate(
                  offset: const Offset(0, -2),
                  child: const Icon(Iconcino.mail),
                ),
                onPressed: () {
                  context.goNamed(
                    Routes.signin,
                    arguments: {
                      'onComplete': _formCompleted,
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
