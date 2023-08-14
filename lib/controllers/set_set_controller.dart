import 'package:get/get.dart';

class SetStateController extends GetxController {
  // Declare the RxString variable
  RxString stateName = RxString('');
  RxString stateId = RxString('0');

  // Function to update the RxString variable
  void updateData(String Name,String Id) {
  stateName.value = Name;
  stateId.value = Id;
  }
}