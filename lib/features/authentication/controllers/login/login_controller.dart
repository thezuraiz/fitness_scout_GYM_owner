import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  @override
  void onInit() {
    email.text = deviceStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = deviceStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// --- Variables
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final deviceStorage = GetStorage();

  // Todo:
  // final userController = Get.put(UserController());

  /// --- Email & Password Sign In
  Future<void> loginWithEmailAndPassword() async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Logging you in...', ZImages.fileAnimation);

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        print('Internet Connection Failed!');
        return;
      }

      // Todo: Form Validation
      if (!loginKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Save Data if remember me is selected
      if (rememberMe.value) {
        deviceStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        deviceStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Todo: Login user using email & password Authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      final _userId = userCredential.user!.uid;
      ZLogger.warning('User Id: $_userId');

      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_userId)
          .get();

      if (userData.exists || userData.data() != null) {
        ZLogger.error('User already registered with gym app');

        // Todo: Logout User
        await FirebaseAuth.instance.signOut();

        // Todo: Show Message
        ZLoaders.errorSnackBar(
          title: 'Already Registered in Fitness Scout GYM',
          message:
              'This email is already associated with the Fitness Scout Gym App. Please use a different email to register your gym in Fitness Scout.',
        );
        // Todo: Remove Loader
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Welcome Message
      ZLoaders.successSnackBar(title: 'Welcome!', message: 'You are Login.');

      // Todo: Remove Loader
      ZFullScreenLoader.stopLoading();

      // Todo: Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e.toString());
    }
  }

  /// --- Google Sign In
  Future<void> googleSignIn() async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Logging you in...', ZImages.fileAnimation);

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Google Authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      final _userId = userCredential!.user!.uid;
      ZLogger.warning('User Id: $_userId');

      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_userId)
          .get();

      if (userData.exists || userData.data() != null) {
        ZLogger.error('User already registered with gym app');

        // Todo: Logout User
        await FirebaseAuth.instance.signOut();

        // Todo: Show Message
        ZLoaders.errorSnackBar(
          title: 'Already Registered in Fitness Scout GYM',
          message:
              'This email is already associated with the Fitness Scout Gym App. Please use a different email to register your gym in Fitness Scout.',
        );
        // Todo: Remove Loader
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Save the data
      // await userController.saveUserRecord(userCredential);

      // Todo: Remove Loader
      ZFullScreenLoader.stopLoading();

      /// Redirect User
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }
}
