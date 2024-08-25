import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           Row(
             children: [
               IconButton(onPressed: (){}, icon: Icon(Iconsax.menu))
             ],
           )
          ],
        ),
      )
    );
  }
}
