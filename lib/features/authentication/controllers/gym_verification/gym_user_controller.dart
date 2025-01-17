import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/data/repositories/user/user_repository.dart';
import 'package:fitness_scout_owner_v1/features/authentication/models/amenities_model.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_gallery.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_info.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/review.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';
import '../../../personalization/screen/widgets/re_auth_user_login_form.dart';
import '../../models/gym_model.dart';
import '../../screens/gym_verification/gym_registration_waiting_list.dart';
import '../../screens/gym_verification/widgets/bank_info.dart';
import '../../screens/gym_verification/widgets/gym_timmings.dart';
import '../../screens/login_screen.dart';

class GYMUserController extends GetxController {
  static GYMUserController get instance => Get.find();
  Rx<GymOwnerModel> GYMuser = GymOwnerModel.empty().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    checkAndRequestLocation();
    fetchUserRecord();
  }

  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxInt stepperCurrentIndex = 0.obs;
  RxBool profileLoading = false.obs;
  TextEditingController gymName = TextEditingController();
  TextEditingController gymDescription = TextEditingController();
  TextEditingController gymAddress = TextEditingController();
  TextEditingController gymLocation = TextEditingController();
  TextEditingController gymWebsite = TextEditingController();
  TextEditingController gymOwnerBankName = TextEditingController();
  TextEditingController gymOwnerAccountNumber = TextEditingController();
  TextEditingController gymOwnerAccountIBAN = TextEditingController();

  /// For ReAuthenticate GYM Owner
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  RxBool showBankDetails = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  Map<String, Map<String, dynamic>> timings = {};
  RxList<Amenity> amenities = [
    Amenity(name: 'WiFi'),
    Amenity(name: 'Parking'),
    Amenity(name: 'Pool'),
    Amenity(name: 'Gym Equipment'),
    Amenity(name: 'Sauna'),
    Amenity(name: 'Cafe'),
    Amenity(name: 'Shower'),
  ].obs;

  /// Repo
  final userRepository = Get.put(UserRepository());

  final formKey = GlobalKey<FormState>();

  bool get isFirstStep => stepperCurrentIndex.value == 0;

  bool get isLastStep => stepperCurrentIndex.value == steps().length - 1;

  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> gymFrontImage = Rx<XFile?>(null);
  Rx<XFile?> gymLicenseImage = Rx<XFile?>(null);

  RxBool isUploading = false.obs;

  /// Todo:
  // bool validateCurrentStep() {
  //   ZLoaders.warningSnackBar(title: 'Form Key ${formKey.currentState}');
  //   if (formKey.currentState!.validate()) {
  //     ZLogger.info('Form is valid');
  //     return true;
  //   }
  //   return false;
  // }

  List<Step> steps() => [
        Step(
            title: const Text('GYM Info'),
            isActive: stepperCurrentIndex.value >= 0,
            content: const GymInfoScreen()),
        Step(
          title: const Text('GYM Pictures'),
          isActive: stepperCurrentIndex.value >= 1,
          content: const GymGallery(),
        ),
        Step(
            title: const Text('GYM Timings'),
            isActive: stepperCurrentIndex.value >= 2,
            content: const GymTimingsScreen()),
        Step(
            title: const Text('Banking Info'),
            isActive: stepperCurrentIndex.value >= 3,
            content: const BankInfoScreen()),
        Step(
            title: const Text('Review'),
            isActive: stepperCurrentIndex.value >= 4,
            content: const ReviewScreen()),
      ];

  /// Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }
      ZLogger.info('Fetching GYM User Profile');
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      ZLogger.warning('User: ${user.name}');
      this.GYMuser(user);
      ZLogger.info('Fetching GYM User Profile: ${GYMuser.toJson()}');
    } catch (e) {
      ZLogger.error('Error while loading user data ${e}');
      GYMuser(GymOwnerModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Method to pick an image
  Future<void> pickImage(Rx<XFile?> imageController) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedFile != null) {
      imageController.value = pickedFile;
    } else {
      ZLoaders.warningSnackBar(title: 'Warning', message: 'No image selected!');
      ZLogger.info('No image selected');
    }
  }

  uploadGYMPicture() async {
    try {
      imageUploading.value = true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);

      if (image != null) {
        // Upload GYMPicture
        final imageUrl =
            await userRepository.uploadImage('Gyms/Images/', image);

        // Update GYMPicture In firestorex
        Map<String, dynamic> json = {
          'images': [imageUrl],
        };
        await userRepository.updateSingleField(json);

        // Update GYMPicture in User Controller
        // GYMuser.value.images = imageUrl;
        // GYMuser.refresh();
        fetchUserRecord();

        ZLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your gym picture has been updated');
      }
    } catch (e) {
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }

  uploadGYMLicense() async {
    try {
      imageUploading.value = true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);

      if (image != null) {
        // Upload GYM License
        final imageUrl =
            await userRepository.uploadImage('Gyms/license/', image);

        // Update License In firestorex
        Map<String, dynamic> json = {
          'license': imageUrl,
        };
        await userRepository.updateSingleField(json);

        // Update License in User Controller
        // GYMuser.value.images = imageUrl;
        // GYMuser.refresh();

        fetchUserRecord();

        ZLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your GYM License has been updated');
      }
    } catch (e) {
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }

  Future<void> registerGYM() async {
    FocusManager.instance.primaryFocus?.unfocus(); // Use ? to avoid null errors
    try {
      // Start Loading
      ZFullScreenLoader.openLoadingDialogy(
          'We are processing your information...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Ensure gymLicenseImage is not null before using it
      if (gymLicenseImage.value != null && gymFrontImage.value != null) {
        final uploadedGymFrontImage = await UserRepository.instance
            .uploadImage('/gymFrontImage', gymFrontImage.value!);
        final uploadedImage = await UserRepository.instance
            .uploadImage('/gymLicences', gymLicenseImage.value!);

        await fetchUserRecord();

        final _user = GYMuser.value;
        try {
          /// Save GYM data in the Firebase Firestore
          final GYM = await GymOwnerModel(
              id: _user.id ?? '',
              name: _user.name ?? '',
              username: _user.username ?? '',
              email: _user.email ?? '',
              description: gymDescription.text.toString() ?? '',
              gymName: gymName.text.toString() ?? '',
              license: uploadedImage ?? '',
              address: gymAddress.text.toString() ?? '',
              contactNumber: _user.contactNumber ?? '',
              website: gymWebsite.text.toString() ?? '',
              location: Location(
                  latitude: currentPosition.value!.latitude ?? 0.0,
                  longitude: currentPosition.value!.longitude ?? 0.0),
              openingHours: timings,
              images: [uploadedGymFrontImage],
              amenities: amenities.value.map((item) => item.toJson()).toList(),
              ownerBankDetails: OwnerBankDetails(
                  bankName: gymOwnerBankName.text.toString() ?? '',
                  accountNumber: gymOwnerAccountNumber.text.toString() ?? '',
                  iban: gymOwnerAccountIBAN.text.toString() ?? ''),
              gymType: GymType.Basic,
              profilePicture: '');

          // final String id;
          // final String name;
          // final String username;
          // final String email;
          // final String? profilePicture;
          // final String? description;
          // final String? gymName; // New optional field
          // final Location? location;
          // final String? address;
          // final String? contactNumber;
          // final String? website;
          // final String? license;
          // final Map<String, dynamic>? openingHours;
          // final List<String>? images;
          // final List<String>? amenities;
          // final OwnerBankDetails? ownerBankDetails;
          // final double balance;
          // final String isApproved;
          // final List<Visitor>? visitors;
          // final String gymType;

          ZLogger.info(GYM.toJson().toString());

          await UserRepository.instance.updateGYMRecord(GYM);
        } catch (e, t) {
          ZLogger.error('Error $e $t');
        }

        // Show Success Message
        ZLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your account has been created! verify email to continue');

        ZFullScreenLoader.stopLoading();
        Get.offAll(() => const GymRegistrationWaitingList());
      } else {
        ZLoaders.warningSnackBar(
            title: 'Uh Snap!', message: 'Please pick an image first.');
        ZFullScreenLoader.stopLoading();
      }
    } catch (e) {
      // Show some generic error to the user
      ZLoaders.warningSnackBar(title: 'Uh Snap!', message: e.toString());
      ZLogger.error(e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }

  /// Function to check and request location permission
  Future<void> checkAndRequestLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Handle denial
          ZLogger.error('Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Handle permanent denial, possibly redirect to settings
        ZLogger.error('Location permission permanently denied');
        return;
      }

      // Fetch location if permission granted
      await fetchCurrentLocation();
    } catch (e) {
      ZLogger.error('Error requesting location: $e');
    }
  }

  /// Fetches the current location
  Future<void> fetchCurrentLocation() async {
    try {
      currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      ZLogger.info('Position ${currentPosition.value}');
    } catch (e) {
      ZLogger.error('Error fetching location: $e');
    }
  }

  /// Delete Account Loading
  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ZSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be permanently removed',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: ZSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      /// Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      /// First Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        /// Re verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          ZFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          ZFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthUserLoginForm());
        }
      }
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      /// Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      /// Validation on form
      if (!reAuthFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      ZFullScreenLoader.stopLoading();
      Get.to(() => const LoginScreen());
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.warningSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }
}
