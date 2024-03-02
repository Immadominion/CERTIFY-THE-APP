import 'dart:ui';

import 'package:certify/presentation/views/home/components/home_page_card.dart';
import 'package:flutter/material.dart';

Widget homePageCardsGroup(
    Color color,
    IconData icon,
    String title,
    BuildContext context,
    Widget route,
    Color color2,
    IconData icon2,
    String title2,
    Widget route2,
    animation,
    animation2,
  ) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(
              color, icon, title, context, route, animation, animation2),
          homePageCard(
              color2, icon2, title2, context, route2, animation, animation2),
        ],
      ),
    );
  }

  Widget blurTheStatusBar(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: w / 18,
          color: Colors.transparent,
        ),
      ),
    );
  }