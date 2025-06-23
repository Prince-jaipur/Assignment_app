import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/controller/user_controller.dart';

import '../widgets/Stepprogressindicator.dart';

class HeightSelectionScreen extends StatefulWidget {
  final int currentPage;
  final PageController controller;
  final VoidCallback onNext;

  const HeightSelectionScreen({
    super.key,
    required this.currentPage,
    required this.controller,
    required this.onNext,
  });

  @override
  State<HeightSelectionScreen> createState() => _HeightSelectionScreenState();
}

class _HeightSelectionScreenState extends State<HeightSelectionScreen> {
  int selectedHeight = 165;
  final userController = Get.find<UserDataController>();


  @override
  Widget build(BuildContext context) {
    final heights = List.generate(46, (index) => 145 + index); // 145 to 190

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Skip", style: TextStyle(color: Colors.deepPurple)),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: 4,
              currentStep: widget.currentPage,
            ),
            const SizedBox(height: 20),
            const Text(
              "What’s your height?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Help us to create your personalize plan",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Human body image
                Image.asset("assets/images/body_icon.png", height: 200),
                const SizedBox(width: 24),
                // Height picker with ruler style
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 32,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedHeight = heights[index];
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: heights.length,
                          builder: (context, index) {
                            final value = heights[index];
                            final isSelected = value == selectedHeight;
                            return Center(
                              child: Text(
                                "$value",
                                style: TextStyle(
                                  fontSize: isSelected ? 18 : 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.deepPurple : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Triangle indicator pointing to selected value
                    const Positioned(
                      left: -10,
                      child: Icon(Icons.play_arrow, color: Colors.deepPurple, size: 24),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "$selectedHeight Cm",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (){
                  userController.setHeight(selectedHeight);
                  widget.onNext();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                backgroundColor: const Color(0xFF6C4DDA),
                elevation: 2,
                shadowColor: Colors.black26,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
