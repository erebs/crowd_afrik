import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:crowd_afrik/contants/app_colors.dart';
import 'package:crowd_afrik/contants/app_variables.dart';
import 'package:crowd_afrik/models/campaigns_model.dart';
import 'package:crowd_afrik/views/pages/webscreen/web_screen.dart';
import 'package:crowd_afrik/views/widgets/buttons.dart';
import 'package:crowd_afrik/views/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../controllers/campaigns_controller.dart';
import '../../../utils/helpers.dart';
import '../../../utils/snackbar.dart';
import '../../widgets/shimmers/category_card_shimmer.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({
    super.key,
    required this.categoryId,
    required this.title,
    required this.photo,
    required this.description,
  });
  int categoryId;
  String description, title, photo;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final CampaignsController campaignsController = Get.put(CampaignsController());
  RxInt campaignId = RxInt(0);
  RxString campaignName = RxString("");
  RxString campaignPhoto = RxString("");
  RxString campaignFee = RxString("");
  RxString campaignDis = RxString("");
  RxString campaignCon1 = RxString("");
  RxString campaignCon2 = RxString("");
  var campaignDetailSection = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    campaignsController.callApi(widget.categoryId);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(fontSize: 14),),
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                    child: Image.network(AppVariables.baseUrl+widget.photo)),

                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    child: Text(
                      Helpers.parseHtmlString(widget.description),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.fontOnWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                ),

                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Text(
                    "Ongoing Campaigns",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                        color: AppColors.fontOnWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),


                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child:
                    Obx(() => campaignsController.isLoading.value?
                    CampaignShimmer():
            GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: campaignsController.campaignsModel.campaigns!.length,
            itemBuilder: (context, i)
            {
              Campaigns? campaigns = campaignsController.campaignsModel.campaigns![i];
              return TouchableOpacity(
                onTap: () {
                  campaignId.value = campaigns.id!;
                  campaignName.value = campaigns.title!;
                  campaignPhoto.value = campaigns.photo!;
                  campaignFee.value = campaigns.fee.toString()!;
                  campaignDis.value = campaigns.description.toString()!;
                  campaignCon1.value = campaigns.content1.toString()!;
                  campaignCon2.value = campaigns.content2.toString()!;
                  screenNavigation(campaignDetailSection);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration:   BoxDecoration(
                      border: Border.all(width: 0, color: AppColors.primary),
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width:35,
                          child: Image.network(AppVariables.baseUrl+campaigns.icon!, color: Colors.white,)),
                      SizedBox(height: 3,),
                      Text(
                        campaigns.title!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColors.fontOnSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
            ),
          )
                    ),),


                Obx(() => campaignId.value==0?SizedBox():
                Container(
                  margin: EdgeInsets.only(top: 15),
                  key: campaignDetailSection,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        campaignName.value,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColors.fontOnWhite,
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w900
                        ),
                      ),

                      SizedBox(height: 10,),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.grey.withOpacity(0.6),
                            height: 200,
                            width: double.infinity,
                            child: campaignPhoto.value.length>2?Image.network(AppVariables.baseUrl+campaignPhoto.value, fit: BoxFit.cover,):
                            Icon(Remix.image_2_line, size: 50, color: Colors.white.withOpacity(0.5),)
                        ),
                      ),

                      SizedBox(height: 10,),

                      campaignDis.value.length>0?Html(data: campaignDis.value):const SizedBox(),
                      campaignCon1.value.length>4?Html(data: campaignCon1.value):const SizedBox(),
                      campaignCon2.value.length>4?Html(data: campaignCon2.value):const SizedBox(),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Application Processing Fee: ₦${campaignFee.value}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.fontOnWhite,
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      PrimaryButton(
                          buttonText: "Proceed to pay application processing fee",
                        onTap: (){

                          getUserData(context, campaignId.toString());

                        },
                      ),

                      SizedBox(height: 40,),




                    ],
                  ),
                )
                )


              ],
            ),
          ),
        ),
      ),
    );
  }

  screenNavigation (GlobalKey campaignDetailSection) async {
    Future.delayed(const Duration (milliseconds:100),(){
      Scrollable.ensureVisible(campaignDetailSection.currentContext!, duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });

  }

  handlePaymentInitialization(BuildContext context) async {

    //Snack.show("Started");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName   = prefs.getString("user_name")!;
    int userId    = prefs.getInt("user_id")!;
    String userMobile  = prefs.getString("user_mobile")!;
    String userEmail   = prefs.getString("user_email")!;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final Customer customer = Customer(
        name: userName,
        phoneNumber: userMobile,
        email: userEmail
    );
    final Flutterwave flutterwave = Flutterwave(
        context: context, publicKey: "FLWPUBK-3b6e35b6f29f5856ad05d0560c1a97ea-X",
        currency: "NGN",
        redirectUrl: "https://portal.crowdafrik.com/member/app-payment/$userId",
        txRef: "$timestamp-${campaignId.string}",
        amount: campaignFee.value,
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "CrowdAfrik - ${campaignName.value}"),
        isTestMode: false );
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      print("${response.toJson()}");
      if(response.success!)
        {
          Get.off(() => WebScreen(url: "https://portal.crowdafrik.com/member/app-payment/$userId?tx_ref=${response.txRef}"
              "&transaction_id=${response.transactionId}&status=${response.status}",));
        }
    } else {
    }
  }


  getUserData (BuildContext context,String camId) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName   = prefs.getString("user_name")!;
    int userId    = prefs.getInt("user_id")!;
    String userMobile  = prefs.getString("user_mobile")!;
    String userEmail   = prefs.getString("user_email")!;

    showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        builder: (BuildContext context){
          return SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      TouchableOpacity(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration:   BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.primary),
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Icon(Remix.close_fill, size: 25, color: AppColors.fontOnSecondary,),
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 25,),

                  TextBox(text: userName),

                  SizedBox(height: 10,),

                  TextBox(text: userEmail),

                  SizedBox(height: 10,),

                  TextBox(text: userMobile),

                  SizedBox(height: 20,),

                  PrimaryButton(buttonText: "Pay Now", onTap: (){

                    handlePaymentInitialization(context);

                  }),

                ],
              ),
            ),
          );
        }
    );

  }//

}

class CampaignShimmer extends StatelessWidget {
  const CampaignShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, i)
        {
          return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration:   BoxDecoration(
                  border: Border.all(width: 0, color: Colors.grey.withOpacity(0.8)),
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Remix.image_2_line, size: 50, color: Colors.grey,),
                  Container(
                    color: Colors.grey,
                    height:8,
                    width: 60,
                  ),

                ],
              ),
            ),
          );
        },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      crossAxisCount: 3,
    ),
    );



  }





}
