import 'dart:async';
import 'package:adoptionapp/helper/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class InAppReviewProvider with ChangeNotifier {
  final InAppReview _inAppReview = InAppReview.instance;
  bool _hasReviewed = false;
  String? _email;

  /// Timer for debouncing to prevent multiple toasts
  Timer? _debounceTimer;

  bool get hasReviewed => _hasReviewed;

  String? get email => _email;

  InAppReviewProvider();

  /// Trigger the in-app review if eligible (only for guest users or if not yet reviewed by email users)
  Future<void> triggerInAppReview(BuildContext context) async {
    if (_debounceTimer != null && _debounceTimer!.isActive)
      return; // Debounce logic

    if (_email != null) {
      // Registered user: show review only if they haven't reviewed yet
      if (!_hasReviewed) {
        await _showReview(context);
      } else {
        print("Review already submitted by email-registered user.");
      }
    } else {
      // Guest user: always allow the review since they don't persist
      await _showReview(context);
    }

    // Activate the debounce timer for 2 seconds
    _debounceTimer = Timer(const Duration(seconds: 2), () {});
  }

  /// Show the in-app review and mark it as done
  Future<void> _showReview(BuildContext context) async {
    if (await _inAppReview.isAvailable()) {
      try {
        await _inAppReview.openStoreListing(
            appStoreId: "com.adoption.adoptionapp");

        // After successful review, mark as reviewed
        _hasReviewed = true;
        notifyListeners();

        // Show toast after review
        ToastHelper.showSuccessToast(
          context: context,
          message: "Thanks for your review!",
        );
      } catch (e) {
        print("Error showing In-App Review: $e");
      }
    } else {
      print("In-App Review is not available.");
    }
  }

  /// Reset review status when a guest user signs out
  void resetReviewStatusForGuest() {
    if (_email == null) {
      // If the user is a guest, reset the review status
      _hasReviewed = false;
      notifyListeners();
    }
  }

  /// Set the user type (guest or registered) and handle email storage
  void setUserEmail(String? userEmail) {
    if (userEmail != null) {
      _email = userEmail;
    } else {
      _email = null;
    }
    notifyListeners();
  }
}
