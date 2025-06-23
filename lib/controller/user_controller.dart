// lib/controllers/user_data_controller.dart
import 'package:get/get.dart';

class UserDataController extends GetxController {
  var gender = ''.obs;
  var weight = 0.obs;
  var height = 0.obs;

  void setGender(String g) => gender.value = g;
  void setWeight(int w) => weight.value = w;
  void setHeight(int h) => height.value = h;

  double get bmi {
    if (height.value == 0) return 0;
    final heightInMeters = height.value / 100;
    return weight.value / (heightInMeters * heightInMeters);
  }
}
