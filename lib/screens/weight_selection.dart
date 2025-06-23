import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/controller/user_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../widgets/Stepprogressindicator.dart';

class WeightSelectionScreen extends StatefulWidget {
  final int currentPage;
  final PageController controller;
  final VoidCallback onNext;
  const WeightSelectionScreen({
    super.key,
    required this.currentPage,
    required this.controller,
    required this.onNext,
  });

  @override
  State<WeightSelectionScreen> createState() => _WeightSelectionScreenState();
}

class _WeightSelectionScreenState extends State<WeightSelectionScreen> {
  int selectedWeight = 95;
  String unit = "Kg";
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
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.deepPurple),
            ),
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
              "What’s your Weight?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Help us to create your personalize plan",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildUnitToggle(),
            const SizedBox(height: 20),
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 80,
                  maximum: 115,
                  interval: 5,
                  showTicks: true,
                  showLabels: true,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.07,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  axisLabelStyle: const GaugeTextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: selectedWeight.toDouble(),
                      enableDragging: true,
                      onValueChanged: (value) {
                        setState(() {
                          selectedWeight = value.round();
                        });
                      },
                      needleColor: Colors.deepPurple,
                      tailStyle: const TailStyle(
                        length: 0.18,
                        width: 8,
                        color: Colors.deepPurple,
                      ),
                      needleLength: 0.6,
                      needleStartWidth: 0,
                      needleEndWidth: 8,
                      knobStyle: const KnobStyle(
                        color: Colors.deepPurple,
                        knobRadius: 0.06,
                      ),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        "$selectedWeight $unit",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.8,
                    ),
                  ],
                ),
              ],
            ),

            Text(
              "$selectedWeight $unit",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                   userController.setWeight(getWeightInKg().round());

                widget.onNext();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                backgroundColor: const Color(0xFF6C4DDA),
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
  double getWeightInKg() {
  return unit == "LBS" ? selectedWeight * 0.453592 : selectedWeight.toDouble();
}

  Widget _buildUnitToggle() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff0f0f0),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children:
            ["Kg", "LBS"].map((e) {
              final isSelected = unit == e;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => unit = e),
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
                      e,
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
}
