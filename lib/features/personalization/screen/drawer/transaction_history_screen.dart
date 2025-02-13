import 'package:fitness_scout_owner_v1/common/widgets/custom_cards/rounded_container.dart';
import 'package:fitness_scout_owner_v1/common/widgets/shimmer/shimmer.dart';
import 'package:fitness_scout_owner_v1/features/personalization/controller/transaction_history_controller.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/sizes.dart';

/// Todo:
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    final controller = Get.put(TransactionHistoryController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: ZSizes.lg),
            child: Obx(
              () => Text(
                'Rs ${controller.totalAmount.toInt()}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.reFetchTransactionHistory(),
        child: Obx(
          () => controller.isLoading.value
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ZRoundedContainer(
                      width: double.infinity,
                      backgroundColor: Colors.transparent,
                      showBorder: true,
                      borderColor: dark ? ZColor.darkerGrey : ZColor.grey,
                      margin: const EdgeInsets.all(
                        ZSizes.spaceBtwItems,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: ZSizes.sm,
                      ),
                      child: const ListTile(
                        title: ZShimmerEffect(
                            width: double.infinity / 1.5, height: 20),
                        subtitle: ZShimmerEffect(
                            width: double.infinity / 1.5, height: 20),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  itemCount: controller.transactions.value.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.transactions.value[index];
                    return ZRoundedContainer(
                      width: double.infinity,
                      backgroundColor: Colors.transparent,
                      showBorder: true,
                      borderColor: dark ? ZColor.darkerGrey : ZColor.grey,
                      margin: const EdgeInsets.symmetric(
                          vertical: ZSizes.sm, horizontal: ZSizes.md),
                      padding: const EdgeInsets.symmetric(
                        horizontal: ZSizes.sm,
                      ),
                      child: ListTile(
                        title: Text(
                            'Date: ${DateFormat('dd-MMM-yyy').format(transaction.requestedDate)}'),
                        subtitle: Text(
                          'Method: ${transaction.transactionMethod}\n'
                          'Status: ${transaction.transactionStatus}'
                          '${transaction.message.isNotEmpty ? '\nMessage: ${transaction.message}' : ''}',
                        ),
                        trailing: Text(
                          transaction.transactionStatus == 'Failed'
                              ? ''
                              : 'Rs ${transaction.widthDrawAmount}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        isThreeLine: false,
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return controller.transactions.isNotEmpty &&
                controller.transactions.value.last.transactionStatus ==
                    'Pending'
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ZSizes.md,
                  vertical: ZSizes.md / 2,
                ),
                child: ElevatedButton(
                  onPressed: () => controller.requestWidthDraw(),
                  child: const Text('Request Withdraw'),
                ),
              );
      }),
    );
  }
}
