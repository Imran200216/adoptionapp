import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiChatBotIntroProvider extends ChangeNotifier {
  bool _isIntroSeen = false;

  bool get isIntroSeen => _isIntroSeen;

  Future<void> checkIntroStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isIntroSeen = prefs.getBool('isIntroSeen') ?? false;
    notifyListeners();
  }

  Future<void> setIntroSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isIntroSeen', true);
    _isIntroSeen = true;
    notifyListeners();
  }
}
