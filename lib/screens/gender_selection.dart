import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import '../widgets/Stepprogressindicator.dart';

class GenderSelectionScreen extends StatefulWidget {
  final int currentPage;
  final PageController controller;
  final VoidCallback onNext;
  const GenderSelectionScreen({
    super.key,
    required this.currentPage,
    required this.controller, required this.onNext,
  });

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String selectedGender = "Male";
  final userController = Get.find<UserDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap:
              () => widget.controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),

        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Skip", style: TextStyle(color: Colors.blue)),
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
              "Select your Gender",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Help us to create your personalize plan",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAvatar("Female", "assets/images/female.png"),
                _buildAvatar("Male", "assets/images/male.png"),
              ],
            ),
            const SizedBox(height: 16),
            _buildOtherBox("Others"),
            const SizedBox(height: 20),
            _buildGenderToggle(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                userController.setGender(selectedGender); 
                widget.onNext();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                backgroundColor: const Color(
                  0xFF6C4DDA
                ), 
                elevation: 2, 
                shadowColor: Colors.black26,
                side: BorderSide.none, 
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherBox(String label) {
    final isSelected = selectedGender == label;
    return GestureDetector(
      onTap: () => setState(() {
 selectedGender = label;
  userController.setGender(label);
      }),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : const Color(0xfff0f0f0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGenderToggle() {
    final genders = ["Female", "Male", "Others"];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff0f0f0),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children:
            genders.map((gender) {
              final isSelected = selectedGender == gender;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
selectedGender = gender;
 userController.setGender(gender);
                  } ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? Colors.deepPurple : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      gender,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildAvatar(String label, String imagePath) {
    final isSelected = selectedGender == label;
    return GestureDetector(
      onTap: () => setState(() {
selectedGender = label;
 userController.setGender(label); 
      } ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border:
                  isSelected
                      ? Border.all(color: Colors.deepPurple, width: 3)
                      : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(imagePath, height: 100),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
