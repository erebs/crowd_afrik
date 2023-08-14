import 'package:get/get.dart';

class SetCountyController extends GetxController {
  // Declare the RxString variable
  RxString countryCode = RxString('00');
  RxString countryName = RxString('');
  RxString countryId = RxString('0');

  // Function to update the RxString variable
  void updateCode(String Code,String Name,String Id) {
    countryCode.value = Code;
    countryName.value = Name;
    countryId.value = Id;
  }
}