import 'package:flutter/material.dart';

class CircularIconBtn extends StatelessWidget {
  final VoidCallback onTap;
  final IconData btnIcon;

  const CircularIconBtn({
    super.key,
    required this.onTap,
    required this.btnIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.12,
        width: size.width * 0.12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEAEEEE),
        ),
        child: Center(
          child: Icon(
            btnIcon,
            size: size.height * 0.03,
            color: const Color(0xFF5B6265),
          ),
        ),
      ),
    );
  }
}
