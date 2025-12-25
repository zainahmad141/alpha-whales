import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot> getCurrentUserData() async {
    String userId = _auth.currentUser!.uid;
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return userDoc;
    } else {
      throw Exception("User not found,Please signup");
    }
  }

  ///
  /// Get Dob of current user
  ///

  Future<String?> getUserDob(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['dob'] as String?;
      } else {
        log("User not found.");
        return null;
      }
    } catch (e) {
      log("Error fetching user DOB: $e");
      return null;
    }
  }

  static Future<void> saveNotificationAlertStatus({
    required String userId,
    required String alertType,
    required bool isToggle,
    required String token,
  }) async {
    try {
      // Fetch current user ID
      String currentUserId = _auth.currentUser!.uid;

      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await _firestore.collection("users").doc(userId).get();

      Map<String, String> alertNotifiers = {};

      if (documentSnapshot.exists) {
        Map<String, dynamic> userDoc = documentSnapshot.data() as Map<String, dynamic>;
        if (userDoc.containsKey(alertType) && userDoc[alertType] is Map) {
          alertNotifiers = Map<String, String>.from(userDoc[alertType]);
        }
      }

      // If toggle is off and the user ID is in the map, remove it
      if (!isToggle) {
        log("Removing entry for userId: $currentUserId");
        alertNotifiers.remove(currentUserId);
        await _firestore.collection("users").doc(userId).update(
          {
            alertType: alertNotifiers,
          },
        );
      } else {
        alertNotifiers[currentUserId] = token;
        // Update the document with the new map of alert notifiers
        await _firestore.collection("users").doc(userId).set({
          alertType: alertNotifiers,
        }, SetOptions(merge: true));
      }

      // If toggle is on, add or update the user ID with the token

      log("Document updated successfully for userId: $userId and alertType: $alertType");
    } on FirebaseException catch (e) {
      log("Firebase Exception : ${e.toString()}");
    } catch (e) {
      log("Error : ${e.toString()}");
    }
  }

  static Stream<bool> isAlertStatusOn({
    required String userId,
    required String alertType,
  }) {
    bool isToggleOff = false;
    // Fetch current user ID
    String currentUserId = _auth.currentUser!.uid;

    // Listen to document changes in real-time
    return _firestore.collection("users").doc(userId).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> userDoc = documentSnapshot.data() as Map<String, dynamic>;
        if (userDoc.containsKey(alertType) && userDoc[alertType] is Map) {
          Map<String, String> alertNotifiers = Map<String, String>.from(userDoc[alertType]);
          isToggleOff = alertNotifiers.containsKey(currentUserId);
        }
      }
      log("......................Toggle...userId: $userId.....$currentUserId");
      return isToggleOff; // If userId is not found or document doesn't exist
    }).handleError((e) {
      log("Error: ${e.toString()}");
      return isToggleOff; // Handle errors by returning false
    });
  }
}