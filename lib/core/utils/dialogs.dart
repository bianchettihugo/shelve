import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/shelve_app.dart';

Future<T> loading<T>({
  required Future<T> Function() future,
  String message = "Loading...",
  bool barrierDismissible = false,
}) async {
  final context = ShelveApp.navigatorKey.currentContext!;
  builder(BuildContext dialogContext, String message) => const Center(
        child: CircularProgressIndicator(),
      );

  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) => builder(dialogContext, message),
  );

  try {
    final result = await future();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    return result;
  } catch (e) {
    if (context.mounted) Navigator.of(context).pop();
    rethrow;
  }
}

Future<T?> showSuccessDialog<T>({
  required String title,
  required String message,
  String buttonText = 'OK',
}) {
  try {
    return showDialog(
      context: ShelveApp.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: context.text.titleMedium),
          content: Text(message, style: context.text.bodyMedium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  } catch (e) {
    return Future.value(null);
  }
}

Future<T?> showErrorDialog<T>({
  required String title,
  required String message,
  String buttonText = 'OK',
}) {
  try {
    return showDialog(
      context: ShelveApp.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: context.text.titleMedium),
          content: Text(message, style: context.text.bodyMedium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  } catch (e) {
    return Future.value(null);
  }
}

Future<bool?> showConfirmDialog({
  required String title,
  required String message,
  String confirmText = 'Continue',
  String cancelText = 'Cancel',
}) {
  try {
    return showDialog(
      context: ShelveApp.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: context.text.titleMedium),
          content: Text(message,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              )),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText, style: context.text.bodyMedium),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.scheme.primary,
                  )),
            ),
          ],
        );
      },
    );
  } catch (e) {
    return Future.value(null);
  }
}
