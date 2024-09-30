import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  // This function toggles notification and shows the appropriate toast
  void toggleNotification(bool value, BuildContext context) {
    _isNotificationEnabled = value;
    notifyListeners();

    // Show success or error toast depending on the value
    if (_isNotificationEnabled) {
      ToastHelper.showSuccessToast(
        context: context,
        message: 'Notifications enabled!',
      );
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: 'Notifications disabled!',
      );
    }
  }
}
