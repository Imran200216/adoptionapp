import 'package:adoptionapp/helper/debounce_helper.dart';
import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class GuestAvatarProvider extends ChangeNotifier {
  /// debounce mechanism
  final DebounceHelper debounceHelper = DebounceHelper();

  List<String> _imageUrls = [];
  String? _nickname;
  String? _avatarPhotoURL;
  String? _selectedAvatarUrl;

  String? get selectedAvatarUrl =>
      _selectedAvatarUrl; // Getter for selected avatar URL

  void setSelectedAvatar(String avatarUrl) {
    _selectedAvatarUrl = avatarUrl; // Set the selected avatar URL
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Getters for nickname and avatar URL
  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  List<String> get imageUrls => _imageUrls;

  bool _isAvatarUpdated = false;

  bool get isAvatarUpdated => _isAvatarUpdated;

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
  Future<void> updateSelectedAvatar(
      String avatarUrl, BuildContext context) async {
    _selectedAvatarUrl = avatarUrl; // Set the selected avatar URL
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

  GuestAvatarProvider() {
    fetchGuestUserDetails();
  }

  // Fetch guest user details from Firestore
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
              'https://imgs.search.brave.com/uLARhH16ug7xgUl3msl3yHs0DCWkofOAnLVeWQ-poy0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/a2luZHBuZy5jb20v/cGljYy9tLzI1Mi0y/NTI0Njk1X2R1bW15/LXByb2ZpbGUtaW1h/Z2UtanBnLWhkLXBu/Zy1kb3dubG9hZC5w/bmc'; // Fallback URL

          // Only notify listeners if there is a change
          if (newNickname != _nickname || newAvatarURL != _avatarPhotoURL) {
            _nickname = newNickname;
            _avatarPhotoURL = newAvatarURL;
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

  // Clear selected avatar
  void clearSelectedAvatar() {
    _selectedAvatarUrl = null; // Use the correct variable name
    _isAvatarUpdated = false;
    notifyListeners();
  }
}
