import 'package:adoptionapp/helper/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProvider with ChangeNotifier {
  bool _isDebounced = false;

  /// Method to activate debounce
  void activateDebounce({required Duration duration}) {
    _isDebounced = true;
    Future.delayed(duration, () {
      _isDebounced = false;
    });
  }

  /// Check if the debounce is active
  bool isDebounced() {
    return _isDebounced;
  }

  /// Method to share the app link and handle the response
  Future<void> shareAppLink(BuildContext context) async {
    if (isDebounced()) return;

    // Activate debounce for 2 seconds
    activateDebounce(duration: const Duration(seconds: 2));

    try {
      // Call the Share functionality
      final result = await Share.share(
          'https://play.google.com/store/apps/details?id=com.adoption.adoptionapp');

      // Check the result and show appropriate toast
      if (result == ShareResultStatus.success) {
        ToastHelper.showSuccessToast(
            context: context, message: "Thanks for sharing");
      } else {
        ToastHelper.showErrorToast(
            context: context, message: "Something went wrong");
      }
    } catch (e) {
      ToastHelper.showErrorToast(
          context: context, message: "Something went wrong");
    }
  }
}
