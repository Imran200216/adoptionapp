import 'dart:async';
import 'package:flutter/material.dart';

class CarouselProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  Timer? _autoScrollTimer;

  CarouselProvider() {
    // The timer will start after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  // Start auto-scrolling every 3 seconds
  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // Ensure the PageController is not null and has a valid page
      if (pageController.hasClients) {
        int nextPage = pageController.page?.toInt() ?? 0 + 1;
        if (nextPage >= 3) {
          nextPage = 0; // Reset to the first page after the last one
        }
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic, // Smoother curve
        );
      }
    });
  }
}
