import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class BluredProfileMenue extends StatelessWidget {
  const BluredProfileMenue({super.key, required this.title});

  final title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwItems / 1.5),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: 20,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(
                    7), // Half of the height for a pill shape
              ),
            ),
          ),
        ],
      ),
    );
  }
}
