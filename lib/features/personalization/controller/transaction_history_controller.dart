import 'package:fitness_scout_owner_v1/data/repositories/user/user_repository.dart';
import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/authentication/models/gym_model.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:fitness_scout_owner_v1/utils/popups/loader.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class TransactionHistoryController extends GetxController {
  static TransactionHistoryController get instance => Get.find();

  @override
  void onInit() async {
    super.onInit();
    fetchTransactionHistory();
  }

  RxBool isLoading = false.obs;
  RxList<TransactionHistory> transactions = <TransactionHistory>[].obs;
  RxDouble totalAmount = 0.0.obs;

  void calculateTotalApprovedAmount() {
    totalAmount.value = transactions
        .where((t) => t.transactionStatus == 'Approved')
        .map((t) => t.widthDrawAmount)
        .fold(0.0, (sum, amount) => sum + amount);
  }

  Future<void> fetchTransactionHistory() async {
    try {
      isLoading.value = true;
      final gymUser = GYMUserController.instance.GYMuser.value;
      print(
          'GYM User: ${GYMUserController.instance.GYMuser.value.transactionHistory!.length}');
      transactions.value = gymUser.transactionHistory ?? [];

      ZLogger.info('History: ${transactions.value.toList()}');
      isLoading.value = false;
      calculateTotalApprovedAmount();
    } catch (e) {
      isLoading.value = false;
      ZLogger.error('Error: $e');
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!',
          message: 'Something went wrong while loading transaction history');
    }
  }

  Future<void> reFetchTransactionHistory() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      isLoading.value = true;

      transactions.value =
          await UserRepository.instance.fetchTransactionHistory();

      ZLogger.info('History: ${transactions.value}');

      isLoading.value = false;
      calculateTotalApprovedAmount();
    } catch (e) {
      isLoading.value = false;
      ZLogger.error('Error: $e');
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!',
          message: 'Something went wrong while loading transaction history');
    }
  }

  Future<void> requestWidthDraw() async {
    try {
      final gymOwner = GYMUserController.instance.GYMuser.value;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      isLoading.value = true;
      final transactionObject = TransactionHistory(
        requestedDate: DateTime.now(),
        transactionMethod: gymOwner.ownerBankDetails!.bankName,
        transactionStatus: 'Pending',
        widthDrawAmount: gymOwner.balance.toInt(),
      );

      await UserRepository.instance.addTransactionHistory(transactionObject);

      transactions.add(transactionObject);

      isLoading.value = false;
      calculateTotalApprovedAmount();
      ZLoaders.successSnackBar(
        title: 'Success',
        message:
            'Please wait while we process your transaction. We will complete it shortly!',
      );
    } catch (e) {
      isLoading.value = false;
      ZLogger.error('Error: $e');
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!',
          message: 'Something went wrong while loading transaction history');
    }
  }
}
