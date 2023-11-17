import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/widgets/buttons.dart';
import 'package:crowd_afrik/views/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class FundingFormInputBottomSheet {
  FundingFormInputBottomSheet(
      {required this.nameController,
      required this.emailController,
      required this.phoneController,
      required this.parentContext});
  final BuildContext parentContext;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  List<String> payType = ["Crowd africa credits", "Online Payment"];
  final selectedType = ValueNotifier(0);
  show() {
    return showModalBottomSheet(
        context: parentContext,
        backgroundColor: AppColors.fundingFormBgColor,
        isScrollControlled: true,
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        builder: (parentContext) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(parentContext);
                    },
                    child: Container(
                      height: 37,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Remix.close_line,
                          color: Colors.white, size: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Make sure your\ndetails are correct?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.fontOnSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 26)),
                const SizedBox(
                  height: 20,
                ),
                FundingFormBox(
                    controller: nameController,
                    hint: 'Confirm your name',
                    type: TextInputType.name),
                const SizedBox(
                  height: 10,
                ),
                FundingFormBox(
                    controller: emailController,
                    hint: 'Confirm your email',
                    type: TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                FundingFormBox(
                    controller: phoneController,
                    hint: 'Confirm your phone',
                    type: TextInputType.phone),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                  valueListenable: selectedType,
                  builder: (BuildContext context, dynamic, Widget? child) {
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Pay using",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11)),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    payType.length,
                                    (index) =>
                                        radioButton(payType[index], index)),
                              )
                            ]));
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                PrimaryButton(buttonText: 'Proceed to pay', onTap: () {})
              ],
            ),
          );
        });
  }

  Widget radioButton(String label, int index) {
    return InkWell(
      onTap: () {
        selectedType.value = index;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 14,
            alignment: Alignment.center,
            width: 14,
            decoration: BoxDecoration(
                border: Border.all(
                    color: selectedType.value == index
                        ? Colors.blue
                        : Colors.grey),
                shape: BoxShape.circle),
            child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                    color: selectedType.value == index
                        ? Colors.blue
                        : Colors.transparent,
                    shape: BoxShape.circle)),
          ),
          const SizedBox(width: 10),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 11))
        ],
      ),
    );
  }
}
