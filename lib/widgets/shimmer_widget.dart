import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape shape;

  // Rectangular Shimmer
  const ShimmerWidget.rectangular({
    super.key,
    required this.height,
    required this.width,
  }) : shape = BoxShape.rectangle;

  // Circular Shimmer
  const ShimmerWidget.circular({
    super.key,
    required double size,
  })  : height = size,
        width = size,
        shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white, // Shimmer background color
          shape: shape,
        ),
      ),
    );
  }
}
