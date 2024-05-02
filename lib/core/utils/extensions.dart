// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class Extensions {}

extension BCExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get scheme => Theme.of(this).colorScheme;

  TextTheme get text => Theme.of(this).textTheme;

  AppLocalizations get strings => AppLocalizations.of(this)!;

  Future<T?> cPushNamed<T>(String route, {Object? arguments}) async {
    return Navigator.of(this).pushNamed<T>(route, arguments: arguments);
  }

  Future<T?> cPush<T>(Route<T> route) async {
    return Navigator.of(this).push<T>(route);
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Map<String, dynamic> get data =>
      GoRouterState.of(this).extra! as Map<String, dynamic>;

  void goReplacementNamed(String route, {Object? arguments}) async {
    return this.go(route, extra: arguments);
  }

  Future<T?> goNamed<T>(String route, {Object? arguments}) async {
    return this.pushNamed(route, extra: arguments);
  }
}

extension WAExtension on Widget {
  Widget animate({int position = 0, double offset = 50.0}) {
    return AnimationConfiguration.staggeredList(
      position: position,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        horizontalOffset: offset,
        curve: Curves.easeInOutCubic,
        child: FadeInAnimation(
          child: this,
        ),
      ),
    );
  }
}
