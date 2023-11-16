import 'dart:math';

import 'package:crowd_afrik/views/widgets/shimmers/search_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';


class CategoryCardShimmer extends StatelessWidget {
  CategoryCardShimmer({
    super.key,

  });


  @override
  Widget build(BuildContext context) {

    Random random = Random();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration:   BoxDecoration(
          border: Border.all(width: 0, color: Colors.grey.withOpacity(0.8)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  color: Colors.grey.withOpacity(0.6),
                  height: 150,
                  width: double.infinity,
                  child:
                  Icon(Remix.image_2_line, size: 50, color: Colors.white.withOpacity(0.5),)
              ),
            ),

            SizedBox(height: 13),

            SingleLineShimmer(shimWidth: random.nextInt(50) + 100,),

            SizedBox(height: 4),

            SingleLineShimmer(height:8, shimWidth: random.nextInt(80) + 290,),

            SizedBox(height: 4),


          ],
        ),
      ),
    );
  }
}

class SingleLineShimmer extends StatelessWidget {
  SingleLineShimmer({
    super.key,
    this.shimWidth = 40,
    this.height = 10,
  });

  double shimWidth, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Container(
        color: Colors.grey,
        height:height,
        width: shimWidth,
      ),
    );
  }
}
