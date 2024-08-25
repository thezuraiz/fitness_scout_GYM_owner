
import 'package:fitness_scout_owner_v1/features/authentication/screens/widgets/login_form.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/widgets/login_screen_header.dart';
import 'package:flutter/material.dart';

import '../../../common/styles/AppbarPadding.dart';
import '../../../common/widgets/formDivider.dart';
import '../../../common/widgets/socialButtons.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding,
          child: Column(
            children: [
              // Todo: Header -> Logo,title, subTitle
              LoginScreenHeader(),

              // Todo: Form
              LoginScreenFormField(),

              // TODO: Divider
              ZFormDivider(
                dividerText: ZText.orSignUpWith,
              ),

              SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // TODO: Footer
              ZSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
