import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'model/user_model.dart';

class AuthenticationProvider {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email!);
      } else {
        log("user not get retrive ");
        return UserModel(uid: "uid", email: '');
      }
    });
  }

  Future<UserModel> getCurrentUserDetails() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('users').doc(user.uid).get();
      return UserModel.fromFirestore(userDoc.data() as Map<String, dynamic>);
    } else {
      throw Exception("No user signed in");
    }
  }

  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      // Update display name if provided
      if (user.name != null && user.name!.isNotEmpty) {
        await authResult.user?.updateDisplayName(user.name);
      }

      // Store user data in Firestore
      await _firestore.collection('users').doc(authResult.user!.uid).set(
          user.copyWith(uid: authResult.user!.uid).toFirestore()
      );

      return authResult;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException in signUp: ${e.code} - ${e.message}");
      throw Exception(e.message.toString());
    } catch (e) {
      log("Exception in signUp: $e");
      throw Exception(e.toString());
    }
  }

  Future<UserCredential?> signIn(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email,
          password: user.password!
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message.toString());
    }
  }

  Future<void> verifyEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          log("Email verification sent to: ${user.email}");
        } else {
          log("Email already verified for: ${user.email}");
        }
      } else {
        log("No current user found for email verification");
        throw Exception("No user signed in");
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException in verifyEmail: ${e.code} - ${e.message}");
      throw Exception("Failed to send verification email: ${e.message}");
    } catch (e) {
      log("Exception in verifyEmail: $e");
      throw Exception("Failed to send verification email: $e");
    }
  }

  // Helper method to check email verification status
  Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // Refresh user data
      return user.emailVerified;
    }
    return false;
  }

  // Helper method to resend verification email
  Future<void> resendVerificationEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        log("Verification email resent to: ${user.email}");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw Exception("Too many requests. Please wait before requesting another verification email.");
      }
      throw Exception("Failed to resend verification email: ${e.message}");
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String> uploadImageAndGetUrl(File imageFile) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      String imagePath = 'images/$currentUserId/user_image';

      Reference ref = storage.ref(imagePath);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).update(user.toFirestore());
        return await getCurrentUserDetails();
      } else {
        throw Exception("No user signed in");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> updateUserProfileImage(String imageUrl) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).update({'imageUrl': imageUrl});
        return await getCurrentUserDetails();
      } else {
        throw Exception("No user signed in");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}