import 'package:flutter/material.dart';
import 'package:shelve/core/widgets/loading/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerWidget({
    this.height = 30,
    this.width = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey,
      ),
    );
  }
}
