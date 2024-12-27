import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../authentication/models/gym_model.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final List<TransactionHistory> transactions = [
    TransactionHistory(
      requestedDate: '2024-12-28T14:30:00Z',
      transactionMethod: 'Credit Card',
      transactionStatus: 'Completed',
    ),
    TransactionHistory(
      requestedDate: '2024-12-27T10:15:00Z',
      transactionMethod: 'PayPal',
      transactionStatus: 'Pending',
    ),
    TransactionHistory(
      requestedDate: '2024-12-26T18:45:00Z',
      transactionMethod: 'Bank Transfer',
      transactionStatus: 'Failed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            color: dark ? ZColor.darkContainer : ZColor.lightContainer,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text('Date: ${transaction.requestedDate}'),
              subtitle: Text(
                'Method: ${transaction.transactionMethod}\nStatus: ${transaction.transactionStatus}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
