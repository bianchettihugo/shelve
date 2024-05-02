import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/core/utils/validators.dart';
import 'package:shelve/core/widgets/flow/flow_widget.dart';

import '../../../../core/values/routes.dart';
import '../../../../core/widgets/flow/flow_text_page.dart';

class SignupFlow extends StatefulWidget {
  const SignupFlow({
    super.key,
  });

  @override
  State<SignupFlow> createState() => _SignupFlowState();
}

class _SignupFlowState extends State<SignupFlow> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FlowWidget(
      onCompleted: context.data['onComplete'],
      completer: context.data['completer'],
      disposeCompleter: false,
      pages: [
        FlowTextPage(
          id: 'user',
          title: context.strings.username,
          description: context.strings.usernameHint,
          secondaryButtonText: context.strings.alreadyHaveAccount,
          onSecondaryButtonPressed: () {
            context.pushReplacementNamed(Routes.signin, extra: {
              'onComplete': context.data['onComplete'],
              'completer': context.data['completer'],
            });
          },
        ),
        FlowTextPage(
          id: 'email',
          title: context.strings.email,
          description: context.strings.emailHint,
          condition: (value) => Validators.isEmail(value),
        ),
        FlowTextPage(
          id: 'password',
          title: context.strings.password,
          password: true,
          description: context.strings.passwordHint,
          controller: passwordController,
          condition: (value) => value.length >= 6,
        ),
        FlowTextPage(
          id: 'passwordConfirm',
          title: context.strings.confirmPassword,
          password: true,
          description: context.strings.confirmPasswordHint,
          condition: (value) => value == passwordController.text,
        ),
      ],
    );
  }
}
