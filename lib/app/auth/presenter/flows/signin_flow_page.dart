import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/core/utils/validators.dart';
import 'package:shelve/core/widgets/flow/flow_widget.dart';

import '../../../../core/values/routes.dart';
import '../../../../core/widgets/flow/flow_text_page.dart';

class SigninFlow extends StatelessWidget {

  const SigninFlow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlowWidget(
      onCompleted: context.data['onComplete'],
      completer: context.data['completer'],
      disposeCompleter: false,
      pages: [
        FlowTextPage(
          id: 'email',
          title: context.strings.email,
          description: context.strings.emailHintSimple,
          condition: (value) => Validators.isEmail(value),
          secondaryButtonText: context.strings.createAnAccount,
          onSecondaryButtonPressed: () async {
            context.pushReplacementNamed(Routes.signup, extra: {
              'onComplete': context.data['onComplete'],
              'completer': context.data['completer'],
            });
          },
        ),
        FlowTextPage(
          id: 'password',
          title: context.strings.password,
          password: true,
          description: context.strings.passwordHint,
          condition: (value) => value.length >= 6,
        ),
      ],
    );
  }
}
