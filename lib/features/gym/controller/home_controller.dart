import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/features/authentication/models/gym_model.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/logger.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/loader.dart';
import '../../personalization/model/user_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  @override
  void onInit() {
    loadUserAttendance();
  }

  RxBool isLoading = false.obs;
  final _userId = FirebaseAuth.instance.currentUser!.uid.toString();
  RxList<GymUserAttendance> userGYMAttendance = <GymUserAttendance>[].obs;

  Future<void> loadUserAttendance() async {
    try {
      isLoading.value = true;
      ZLogger.info('Loading User Attendance');

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZLoaders.errorSnackBar(
            title: 'Internet Connection Failed',
            message:
                'Error while connecting internet. Please check and try again!');
        ZLogger.error('Internet Connection Failed!');
        return;
      }

      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Gyms')
          .doc(_userId)
          .get();

      if (!userData.exists || userData.data() == null) {
        ZLogger.error('User Data does not exist or is null!');
        return;
      }

      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
      List<dynamic> userAttendanceList = data['visitors'];

      userGYMAttendance.value = userAttendanceList
          .map((item) => GymUserAttendance.fromMap(item))
          .toList();

      ZLogger.info('UserData: ${userGYMAttendance.value}');
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      ZLogger.info('Is Loading ${isLoading.value}');
    } catch (e) {
      isLoading.value = false;
      ZLogger.error('Errors: $e');
    }
  }
}
