import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/device/deviceUtilities.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controllers/onboard/onBoardController.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardController controller = Get.put(OnBoardController());

    return Scaffold(
      body: Stack(
        children: [
          // Todo: Horizental Scollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: ZImages.onBoardingImage1,
                title: ZText.onBoardingTitle1,
                subtitle: ZText.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                  image: ZImages.onBoardingImage2,
                  title: ZText.onBoardingTitle2,
                  subtitle: ZText.onBoardingSubTitle2),
              OnBoardingPage(
                image: ZImages.onBoardingImage3,
                title: ZText.onBoardingTitle3,
                subtitle: ZText.onBoardingSubTitle3,
              ),
            ],
          ),

          // TODO: Skip Button
          const SkipButton(),

          // TODO: Dot Navigation SmoothPageIndicator
          const DottedWidget(),

          // Todo: Circular Button
          const NextButtonWidget()
        ],
      ),
    );
  }
}

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Positioned(
      right: ZSizes.defaultSpace,
      bottom: ZDeviceUtils.getKeyboardHeight() + 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? ZColor.primary : ZColor.dark),
        onPressed: () => OnBoardController.instance.nextPage(),
        child: const Icon(
          Iconsax.arrow_right_3,
        ),
      ),
    );
  }
}

class DottedWidget extends StatelessWidget {
  const DottedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    final controller = OnBoardController.instance;

    return Positioned(
      bottom: ZDeviceUtils.getKeyboardHeight() + 65,
      left: ZSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? ZColor.light : ZColor.dark,
          dotHeight: 6,
        ),
        onDotClicked: (index) {
          controller.dotNavigationClick(index);
        },
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardController.instance;
    return Positioned(
      top: ZDeviceUtils.getAppBarHeight(),
      right: ZSizes.defaultSpace,
      child: TextButton(
        onPressed: () => controller.skipPage(),
        child: Text(
          "Skip",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ZSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            height: Get.height * 0.6,
            width: Get.width * 0.8,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwItems,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
