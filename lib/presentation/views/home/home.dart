import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_certify_projects_controller.dart';
import 'package:certify/presentation/views/company/demo_page.dart';
import 'package:certify/presentation/views/home/components/home_page_card_group.dart';
import 'package:certify/presentation/views/scan_code/scan_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CertifiedHome extends ConsumerStatefulWidget {
  const CertifiedHome({super.key});

  @override
  CertifiedHomeState createState() => CertifiedHomeState();
}

class CertifiedHomeState extends ConsumerState<CertifiedHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(allCertifiedProjectsController).toGetAllProjects();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return Stack(
            children: [
              /// ListView
              ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CERTIFY',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: "Montesserat",
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Certified Authentic Products",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "Montesserat",
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const CertifiedScanner();
                                },
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.r)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.qr_code_scanner_rounded,
                                    size: 25.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).afmPadding(EdgeInsets.only(left: 15.sp, right: 10.sp)),
                  ),
                  homePageCardsGroup(
                    const Color(0xfff37736),
                    Icons.car_repair_outlined,
                    'Tesla, Inc.',
                    context,
                    const DemoPage(),
                    const Color(0xffFF6D6D),
                    Icons.fastfood_rounded,
                    'MrBeast Burger and Feastables',
                    const DemoPage(),
                    _animation,
                    _animation2,
                  ),
                  homePageCardsGroup(
                    Colors.lightGreen,
                    Icons.local_drink_rounded,
                    'PepsiCo, Inc.',
                    context,
                    const DemoPage(),
                    const Color(0xffffa700),
                    Icons.article,
                    'Nigerian Breweries PLC',
                    const DemoPage(),
                    _animation,
                    _animation2,
                  ),
                  homePageCardsGroup(
                    const Color(0xff63ace5),
                    Icons.computer_rounded,
                    'Hewlett-Packard Company',
                    context,
                    const DemoPage(),
                    const Color(0xfff37736),
                    Icons.apple,
                    'Apple Inc.',
                    const DemoPage(),
                    _animation,
                    _animation2,
                  ),
                  homePageCardsGroup(
                    const Color(0xffFF6D6D),
                    Icons.android,
                    'Alphabet Inc',
                    context,
                    const DemoPage(),
                    Colors.lightGreen,
                    Icons.dataset_rounded,
                    'Dangote Industries Ltd',
                    const DemoPage(),
                    _animation,
                    _animation2,
                  ),
                  homePageCardsGroup(
                    const Color(0xffffa700),
                    Icons.fastfood_rounded,
                    'Nestlé S.A.',
                    context,
                    const DemoPage(),
                    const Color(0xff63ace5),
                    Icons.paragliding_rounded,
                    'PZ Wilmar',
                    const DemoPage(),
                    _animation,
                    _animation2,
                  ),
                  SizedBox(height: 20.sp),
                ],
              ),

              // Blur the Status bar
              blurTheStatusBar(context),
            ],
          );
        },
      ),
    );
  }
}
