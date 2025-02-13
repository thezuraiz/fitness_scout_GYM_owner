import 'package:fitness_scout_owner_v1/data/repositories/user/user_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/helpers/logger.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loader.dart';

class UpdateGYMLocation extends GetxController {
  static UpdateGYMLocation get instance => Get.find();

  var address = "Fetching location...".obs;
  var errorMessage = "".obs;
  RxBool locationFetched = false.obs;
  var position;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
  }

  Future<void> fetchCurrentLocation() async {
    try {
      // Step 1: Get the current position
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Step 2: Use Geocoding to get address from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        address.value =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
        locationFetched.value = true;
      } else {
        address.value = "No address found!";
      }

      // Log the fetched position
      ZLogger.info('Position ${position.latitude}  ${position.longitude}');
    } catch (e) {
      errorMessage.value = "Failed to fetch location: $e";
      address.value = "Error fetching location!";
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!', message: 'Error fetching location: $e');
      ZLogger.error('Error fetching location: $e');
    }
  }

  Future<void> updateLocation() async {
    try {
      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Logging you in...', ZImages.fileAnimation);

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        ZLogger.error('Internet Connection Failed!');
        return;
      }

      Map<String, dynamic> json = {
        'location': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      };
      await UserRepository.instance.updateSingleField(json);

      // Suspend GYM
      await AuthenticationRepository.instance.suspendGYM();

      // Todo: Remove Loader
      ZFullScreenLoader.stopLoading();

      ZLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your GYM Location has been updated');
    } catch (e) {
      // Todo: Remove Loader
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!', message: 'Error: Something went Wrong');
      throw e;
    }
  }
}
