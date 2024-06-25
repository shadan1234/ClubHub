import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/constants/size_config.dart';
import 'package:clubhub/constants/text_styles.dart';
import 'package:clubhub/features/auth/screens/create_account_screen.dart';
import 'package:clubhub/features/onboarding/components/onbarding_data.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = OnBoardingData();
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [body(), buildDots(),button()],
      ),
    );
  }

  Widget body() {
    return Expanded(
      child: Center(
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[currentIndex].image),
                  const SizedBox(height: 15,),
                  Text(
                    controller.items[currentIndex].title,
                    style: AppTextStyles.onboardingTitle,
                    textAlign: TextAlign.center,
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      controller.items[currentIndex].description,
                      style: AppTextStyles.onboardingDescription,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            controller.items.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 2),
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: currentIndex==index? AppColors.primary:Colors.grey ,
               ),
                width: currentIndex == index ? 30 : 7,
                height: 7,
                duration: const Duration(milliseconds: 700))));
  }
 Widget button(){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20), 
    width: 80*SizeConfig.blockSizeHorizontal ,
    height: 55, 
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.primary
    ),
    child: TextButton(child: Text(currentIndex==controller.items.length-1?'Get Started':'Continue', style: const TextStyle(color: AppColors.background),), onPressed: (){
  setState(() {
    currentIndex!=controller.items.length-1? currentIndex++:Navigator.pushNamed(context, CreateAccountScreen.routeName);

  }); 
    },),
  );
 }
}
