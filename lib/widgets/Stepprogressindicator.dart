import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(totalSteps, (index) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            decoration: BoxDecoration(
              color: index <= currentStep ? Colors.deepPurple : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
