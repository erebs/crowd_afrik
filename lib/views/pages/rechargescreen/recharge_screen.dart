import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_images.dart';
import 'package:crowd_afrik/views/widgets/buttons.dart';
import 'package:crowd_afrik/views/widgets/inputs.dart';
import 'package:flutter/material.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  List<String> buttonText = ["Redeem coupon", "Recharge"];
  final selectedTab = ValueNotifier(0);
  TextEditingController redeemController = TextEditingController();
  TextEditingController rechargeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
          child: CustomBackButton(onTap: () {}),
        ),
        // leadingWidth: 14,
        backgroundColor: AppColors.primary,
        title: const Text("Recharge",
            style: TextStyle(
                color: AppColors.fontOnSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 15)),
      ),
      body: SafeArea(
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ValueListenableBuilder(
                valueListenable: selectedTab,
                builder: (BuildContext context, dynamic, Widget? child) {
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 130,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColors.blueColor,
                        ),
                        child: Image.asset(AppImages.logo),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            2, (index) => tabs(buttonText[index], index)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      selectedTab.value == 0 ? redeemView() : rechargeView()
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  Widget tabs(String label, int index) {
    return Flexible(
      child: InkWell(
        onTap: () {
          selectedTab.value = index;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 11),
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: selectedTab.value == index
                      ? Colors.transparent
                      : AppColors.primary),
              borderRadius: BorderRadius.circular(8),
              color: selectedTab.value == index
                  ? AppColors.primary
                  : AppColors.fontOnSecondary),
          alignment: Alignment.center,
          child: Text(label,
              style: TextStyle(
                  color: selectedTab.value == index
                      ? AppColors.fontOnSecondary
                      : AppColors.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14)),
        ),
      ),
    );
  }

  Widget redeemView() {
    return Column(
      children: [
        EditableCIBox(
          controller: redeemController,
          hint: 'Redeem coupon',
          type: TextInputType.name,
        ),
        const SizedBox(
          height: 30,
        ),
        PrimaryButton(buttonText: 'Redeem', onTap: () {})
      ],
    );
  }

  Widget rechargeView() {
    return Column(
      children: [
        EditableCIBox(
          controller: rechargeController,
          hint: 'Enter amount',
          type: TextInputType.number,
        ),
        const SizedBox(
          height: 30,
        ),
        PrimaryButton(buttonText: 'Pay now', onTap: () {})
      ],
    );
  }
}
