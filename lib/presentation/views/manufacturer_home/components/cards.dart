// ignore_for_file: deprecated_member_use

import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/views/manufacturer_home/components/my_fade_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget card(String title, String subtitle, String imageUrl, Widget route,
    context, animation) {
  double w = MediaQuery.of(context).size.width;
  return Opacity(
    opacity: animation.value,
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(MyFadeRoute(route: route));
      },
      child: Container(
        width: w / 2.36,
        height: w / 1.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 50),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: w / 2.36,
              height: w / 2.6,
              decoration: BoxDecoration(
                color: const Color(0xff5C71F3),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              alignment: Alignment.center,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fitHeight,
                width: w / 2.36,
                height: w / 2.6,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    // Image is fully loaded
                    return child;
                  } else {
                    // Show a loading indicator or placeholder while the image is loading
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // Show a fallback widget when the image fails to load
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
              ).afmBorderRadius(
                BorderRadius.only(
                  topRight: Radius.circular(
                    20.r,
                  ),
                  topLeft: Radius.circular(
                    20.r,
                  ),
                ),
              ),
            ),
            Container(
              height: w / 6,
              width: w / 2.36,
              padding: EdgeInsets.symmetric(horizontal: w / 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textScaleFactor: 1.4,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.8),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montesserat",
                    ),
                  ),
                  Text(
                    subtitle,
                    textScaleFactor: 1,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      fontFamily: "Montesserat",
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
