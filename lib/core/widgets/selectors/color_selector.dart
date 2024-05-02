import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class ColorSelector extends StatefulWidget {
  final String id;
  final int initialIndex;

  const ColorSelector({
    this.id = '',
    this.initialIndex = 0,
    super.key,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  final _colors = [
    const Color(0xff14121D),
    const Color(0xff191919),
    const Color(0xff000000),
    const Color(0xffFFFFFF),
    const Color(0xffE5E5E5),
    const Color(0xff041A35),
  ];

  @override
  Widget build(BuildContext context) {
    return DataFormField(
      id: widget.id,
      value: selectedIndex,
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a background color:',
              style: context.text.labelSmall?.copyWith(
                color: context.theme.hintColor,
              ),
            ),
            const SizedBox(height: 21),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: List.generate(6, (index) {
                  return InkWell(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _colors[index],
                        border: selectedIndex == index
                            ? Border.all(
                                color: context.theme.primaryColor,
                                width: 2,
                              )
                            : null,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
