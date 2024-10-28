import 'package:adoptionapp/helper/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneCallProvider extends ChangeNotifier {
  Future<void> phoneCallToggle(String phoneNumber, BuildContext context) async {
    final Uri url = Uri(
      scheme: "tel",
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: "Something went wrong",
      );
    }
    notifyListeners();
  }
}
