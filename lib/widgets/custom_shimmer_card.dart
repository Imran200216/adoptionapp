import 'package:adoptionapp/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerCard extends StatelessWidget {
  const CustomShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// pet image
              ShimmerWidget.circular(
                size: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(
                    height: 50.0,
                    width: double.infinity,
                  ),
                  ShimmerWidget.rectangular(
                    height: 50.0,
                    width: double.infinity,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
