import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/gym_verification.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_waiting_screen.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/home/home.dart';
import 'package:fitness_scout_owner_v1/navigation_menu.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:fitness_scout_owner_v1/utils/popups/loader.dart';

import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/screens/login_screen.dart';
import '../../../features/authentication/screens/onboardings.dart';
import '../../../features/authentication/screens/signup_screen/verify_screen.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exception.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  /// --- Variables
  final deviceStorage = GetStorage();

  /// --- Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// --- Function to show relevant Screen
  screenRedirect() async {
    // _auth.signOut();
    // _auth.currentUser!.reload();
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.emailVerified) {
        final isApprovedField = await isGYMValid();
        ZLogger.info('Is Approved: $isApprovedField');
        if (isApprovedField == 'Not-Approved') {
          Get.offAll(() => const GymVerificationScreen());
        } else if (isApprovedField == 'Pending') {
          Get.to(() => const GymWaitingScreen());
        } else if (isApprovedField == 'Approved') {
          Get.offAll(() => HomePage());
        } else {
          ZLogger.error(
            'Something went wrong on your Verification Field',
          );
          ZLoaders.errorSnackBar(
              title: 'Uh Snap!',
              message: 'Something went wrong on your verification');
        }
      } else {
        /// Todo: Lazmi Uncomment krna hn due to gym verification screen
        Get.offAll(() => VerifyScreen(
              email: _auth.currentUser!.email.toString(),
            ));
      }
    } else {
      /// Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  Future<String> isGYMValid() async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Gyms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final isApprovedField = data['isApproved'];
        ZLogger.info('Is Approved: $isApprovedField');

        return isApprovedField;
      } else {
        ZLogger.error('Document not found');
        throw Exception('User Document not found');
      }
    } catch (e) {
      ZLogger.error('Error: $e');
      throw Exception(e);
    }
  }

  Future suspendGYM() async {
    try {
      await FirebaseFirestore.instance
          .collection('Gyms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'isApproved': 'Pending'});
      ZLogger.info('GYM Suspended');
      screenRedirect();
    } catch (e) {
      ZLogger.error('Error: $e');
      throw Exception(e);
    }
  }

  /// ------------------ Email & Password Sign-in -----------------------

  ///  [Email Authentication] - Sign-in
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ZLogger.warning(e.toString());
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      ZLogger.warning(e.toString());
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      ZLogger.warning(_.toString());
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again$e';
    }
  }

  ///  [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Email Authentication] - Send Email
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Email Authentication] - Forget Password;
  Future<void> sendPasswordResentEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Social Authentication] - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      /// --- Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      /// --- Obtain the auth detail from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      /// --- Create new credentials
      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      /// --- Once Sign in, return the user credentials
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create a credentials
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // Re Authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Email Authentication] - Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);

      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
