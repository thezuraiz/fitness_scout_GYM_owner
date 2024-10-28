import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';
import '../../models/gym_model.dart';
import '../../screens/signup_screen/verify_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// ---- Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// --- SIGNUP
  Future<void> signup() async {
    FocusManager.instance.primaryFocus!.unfocus();
    try {
      // Start Loading
      ZFullScreenLoader.openLoadingDialogy(
          'We are processing your information...', ZImages.fileAnimation);

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        ZLoaders.errorSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of use');
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Register user in the Firebase Authentication & Save data in the firebase
      final userCredentials = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = GymOwnerModel(
          id: userCredentials.user!.uid,
          name: '${firstName.text.trim()} ${lastName.text.trim()}',
          username: username.text.trim(),
          email: email.text.trim(),
          contactNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show Successor Message
      ZLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue');

      ZFullScreenLoader.stopLoading();

      // Move To Verify Email Screen
      Get.to(() => VerifyScreen(
            email: email.text.toString(),
          ));
    } catch (e) {
      //  Show some generic error to the user
      ZLoaders.warningSnackBar(title: 'Uh Snap!', message: e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }
}
