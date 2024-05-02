import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class AmountController {
  final ValueNotifier<int> amount;

  AmountController({int initialAmount = 1})
      : amount = ValueNotifier<int>(initialAmount);

  void reset() {
    amount.value = 1;
  }

  void dispose() {
    amount.dispose();
  }
}

class AmountInput extends StatelessWidget {
  final AmountController controller;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const AmountInput({
    required this.controller,
    this.onAdd,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.scheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (controller.amount.value > 1) {
                controller.amount.value--;
                onRemove?.call();
              }
            },
            onLongPress: () {
              if (controller.amount.value > 1) {
                controller.amount.value -= 5;
                onRemove?.call();
                onRemove?.call();
                onRemove?.call();
                onRemove?.call();
                onRemove?.call();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              child: Icon(
                Icons.remove,
                color: context.scheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 20),
          ValueListenableBuilder(
              valueListenable: controller.amount,
              builder: (context, state, child) {
                return Text(
                  '$state',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.scheme.onSurface,
                    fontSize: 21,
                  ),
                );
              }),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              controller.amount.value++;
              onAdd?.call();
            },
            onLongPress: () {
              controller.amount.value += 5;
              onAdd?.call();
              onAdd?.call();
              onAdd?.call();
              onAdd?.call();
              onAdd?.call();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              child: Icon(
                Icons.add,
                color: context.scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
