import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/views/widgets/buttons.dart';
import 'package:crowd_afrik/views/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.fontOnSecondary,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
          child: CustomBackButton(onTap: () {}),
        ),
        // leadingWidth: 14,
        backgroundColor: AppColors.primary,
        title: const Text("Send",
            style: TextStyle(
                color: AppColors.fontOnSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 15)),
      ),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              const SizedBox(height: 15),
              EditableCIBox(
                controller: phoneController,
                hint: 'Enter Phone Number And CI ID',
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'Enter Amount',
                style: TextStyle(
                    color: AppColors.fontOnWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d*'),
                    )
                  ],
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIconConstraints: BoxConstraints(maxHeight: 28),
                      prefixIcon: Text("\$",
                          style: TextStyle(
                              color: AppColors.fontOnWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 24)),
                      prefixStyle: TextStyle(
                          color: AppColors.fontOnWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )),
                  cursorColor: AppColors.fontOnWhite,
                  style: const TextStyle(
                      color: AppColors.fontOnWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
              const Spacer(),
              const Text(
                "you have a sending \$2222 tro nithin",
                style: TextStyle(
                    color: AppColors.fontOnWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              SizedBox(
                height: 34,
              ),
              PrimaryButton(
                buttonText: 'Pay Now',
                onTap: () {},
              ),
              SizedBox(
                height: 34,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
