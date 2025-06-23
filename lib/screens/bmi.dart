import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/controller/user_controller.dart';
import 'package:pizza/main.dart';



class BmiResultScreen extends StatelessWidget {
  BmiResultScreen({super.key});

  final user = Get.find<UserDataController>();

  double calculateBMI(int height, int weight) {
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getStatus(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    final height = user.height.value;
    final weight = user.weight.value;
    final bmi = calculateBMI(height, weight);
    final status = getStatus(bmi);

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Result"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your BMI is:", style: TextStyle(fontSize: 24, color: Colors.grey[700])),
              const SizedBox(height: 10),
              Text(
                bmi.toStringAsFixed(1),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              Text(
                status,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: status == "Normal" ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Get.offAll(OnboardingPageView()),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
