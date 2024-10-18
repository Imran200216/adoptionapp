import 'package:adoptionapp/helper/debounce_helper.dart';
import 'package:adoptionapp/screens/bottom_nav.dart';
import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestUserDetailsProvider extends ChangeNotifier {
  /// debounce mechanism
  final DebounceHelper debounceHelper = DebounceHelper();

  List<String> _imageUrls = [];
  String? _nickname;
  String? _avatarPhotoURL;
  String? selectedAvatarURL;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Getters for nickname and avatar URL
  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  List<String> get imageUrls => _imageUrls;

  bool _isAvatarUpdated = false;

  bool get isAvatarUpdated => _isAvatarUpdated;

  /// Listen for Firebase Auth state changes and fetch guest details when user is signed in
  void listenForUserChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.isAnonymous) {
        fetchGuestUserDetails(); // Fetch guest details when user is available
      } else {
        // Handle user not available or signed out
        _nickname = null;
        _avatarPhotoURL = null;
        notifyListeners();
      }
    });
  }

  // Fetch avatars from Firebase Storage
  Future<void> fetchAvatars() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('avatars');
      final listResult = await storageRef.listAll();
      final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urls;
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      print('Failed to load avatars: $e');
    }
  }

  // Set selected avatar and update in Firestore
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    notifyListeners(); // Update the UI immediately

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        // Update Firestore with the new avatar URL
        await _firestore.collection('userByGuestAuth').doc(uid).set({
          'avatarPhotoURL': avatarUrl,
        }, SetOptions(merge: true)).then((value) async {
          _isAvatarUpdated = true;

          // Refetch guest details after update to reflect changes
          await fetchGuestUserDetails();

          // Check for debouncing for success toast
          if (!debounceHelper.isDebounced()) {
            debounceHelper.activateDebounce(
                duration: const Duration(seconds: 2));
            ToastHelper.showSuccessToast(
              context: context,
              message: "Avatar updated successfully!",
            );
          }

          notifyListeners(); // Notify UI of update
        });
      } catch (e) {
        // Check for debouncing for error toast
        if (!debounceHelper.isDebounced()) {
          debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
          ToastHelper.showErrorToast(
            context: context,
            message: "Failed to update avatar.",
          );
        }
        print('Error updating avatar: $e');
      }
    } else {
      // Check for debouncing for error toast
      if (!debounceHelper.isDebounced()) {
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
        ToastHelper.showErrorToast(
          context: context,
          message: "No user signed in.",
        );
      }
      print('No user signed in');
    }
  }

  // Controller for nickname TextField
  final TextEditingController nicknameControllerByGuest =
  TextEditingController();

  // Set nickname and update in Firestore
  Future<void> setNickname(BuildContext context) async {
    final nickName = nicknameControllerByGuest.text.trim();

    if (nickName.isEmpty) {
      // Check for debouncing for error toast
      if (!debounceHelper.isDebounced()) {
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
        ToastHelper.showErrorToast(
          context: context,
          message: "Nickname cannot be empty!",
        );
      }
      return;
    }

    _isLoading = true; // Start loading
    notifyListeners(); // Notify UI to show progress indicator

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        // Update Firestore with the new nickname
        await _firestore.collection('userByGuestAuth').doc(uid).set({
          'nickName': nickName,
        }, SetOptions(merge: true)).then((value) async {
          // Check for debouncing for success toast
          if (!debounceHelper.isDebounced()) {
            debounceHelper.activateDebounce(
                duration: const Duration(seconds: 2));
            ToastHelper.showSuccessToast(
              context: context,
              message: "Nickname updated successfully!",
            );
          }

          // Navigate to BottomNavBar
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return BottomNavBar();
              }));
        });
      } catch (e) {
        // Check for debouncing for error toast
        if (!debounceHelper.isDebounced()) {
          debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
          ToastHelper.showErrorToast(
            context: context,
            message: "Failed to update nickname.",
          );
        }
        print('Error updating nickname: $e');
      } finally {
        _isLoading = false; // Stop loading
        notifyListeners(); // Notify UI to hide progress indicator
      }
    } else {
      // Check for debouncing for error toast
      if (!debounceHelper.isDebounced()) {
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
        ToastHelper.showErrorToast(
          context: context,
          message: "No user signed in.",
        );
      }
      print('No user signed in');
    }
  }

  // Add this helper method to save data locally
  Future<void> _saveUserDetailsLocally(
      String nickname, String avatarUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('guestNickname', nickname);
    await prefs.setString('guestAvatarURL', avatarUrl);
  }

  // Add this helper method to load data from local storage
  Future<void> _loadUserDetailsFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _nickname = prefs.getString('guestNickname');
    _avatarPhotoURL = prefs.getString('guestAvatarURL');
    notifyListeners();
  }

  // Modify your constructor to load data from local storage on start
  GuestUserDetailsProvider() {
    _loadUserDetailsFromLocalStorage(); // Load data from local storage
    listenForUserChanges();
  }

  // Update fetchGuestUserDetails to save data locally
  Future<void> fetchGuestUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        DocumentSnapshot userDoc =
        await _firestore.collection('userByGuestAuth').doc(uid).get();

        if (userDoc.exists) {
          String newNickname = userDoc['nickName'] ?? 'No nickname';
          String newAvatarURL = userDoc['avatarPhotoURL'] ??
              'https://example.com/default-avatar.png'; // Fallback URL

          // Only notify listeners if there is a change
          if (newNickname != _nickname || newAvatarURL != _avatarPhotoURL) {
            _nickname = newNickname;
            _avatarPhotoURL = newAvatarURL;

            // Save details locally
            await _saveUserDetailsLocally(_nickname!, _avatarPhotoURL!);

            notifyListeners(); // Notify UI of data change
          }
        } else {
          print('Guest user document does not exist');
        }
      } catch (e) {
        print('Failed to fetch guest user details: $e');
      }
    } else {
      _nickname = null;
      _avatarPhotoURL = null; // Clear avatar URL on sign out
      notifyListeners(); // Notify UI to reflect sign-out status
    }
  }
}
