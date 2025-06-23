import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/screens/bmi.dart';
import 'package:pizza/screens/gender_selection.dart';
import 'package:pizza/screens/height_selection.dart';
import 'package:pizza/screens/weight_selection.dart';

import 'controller/user_controller.dart';

void main() {
  Get.put(UserDataController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const OnboardingPageView(),
  ));
}

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _controller = PageController();
  int currentPage = 0;

  void nextPage() {
  if (currentPage < 2) {
    setState(() {
      currentPage++; 
    });
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  } else {
    // Navigate to HomeScreen
    Get.offAll(() =>  BmiResultScreen());
  }
}


  @override
  Widget build(BuildContext context) {
    final screens = [
      GenderSelectionScreen(
        currentPage: 0,
        controller: _controller,
        onNext: nextPage,
      ),
      WeightSelectionScreen(
        currentPage: 1,
        controller: _controller,
        onNext: nextPage,
      ),
      HeightSelectionScreen(
        currentPage: 2,
        controller: _controller,
        onNext: nextPage,
      ),
    ];

    return PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) => setState(() => currentPage = index),
      itemCount: screens.length,
      itemBuilder: (context, index) => screens[index],
    );
  }
}



