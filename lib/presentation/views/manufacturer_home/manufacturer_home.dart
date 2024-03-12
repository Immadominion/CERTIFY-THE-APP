import 'dart:ui';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/general_components/general_example_screen.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/create_product/create_product.dart';
import 'package:certify/presentation/views/manufacturer_home/components/group_of_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late final listProjects = ref.read(certifyProjectsController.notifier);
  late final LoadingState loadingState = listProjects.loadingState;
  late final bool isLoading = loadingState == LoadingState.loading;
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {});
    Future.delayed(Duration.zero, () {
      fetchData();
    });
    _controller.forward();
  }

  Future<void> fetchData() async {
    // final listProjects = ref.read(certifyProjectsController);
    await listProjects.toGetAllProjects();
    // Update the dataList here based on the fetched data
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilt object');
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        return Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
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
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "All Your Products",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Montesserat",
                              color: Theme.of(context).colorScheme.onBackground,
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
                                return const CreateProduct();
                              },
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25.r)),
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
                                  Icons.add_business_rounded,
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
                  ).afmPadding(
                    EdgeInsets.only(left: 15.sp, right: 10.sp),
                  ),
                ),
                SizedBox(
                  height: 535.h,
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: listProjects.allManufacturerProjectsModel
                                .projects?.length ??
                            1,
                        itemExtent: 200.h,
                        itemBuilder: ((context, index) {
                          dataList = [
                            listProjects.allManufacturerProjectsModel
                                    .projects?[index].name ??
                                '',
                            listProjects.allManufacturerProjectsModel
                                    .projects?[index].status ??
                                '',
                            listProjects.allManufacturerProjectsModel
                                    .projects?[index].image ??
                                '',
                            listProjects.allManufacturerProjectsModel
                                    .projects?[index].name ??
                                '',
                            listProjects.allManufacturerProjectsModel
                                    .projects?[index].status ??
                                '',
                            listProjects.allManufacturerProjectsModel
                                    .projects?[index].image ??
                                '',
                          ];
                          return dataList[0] == ''
                              ? Center(
                                  child: Lottie.asset(
                                    "assets/animation/null-animation.json",
                                    controller: _controller,
                                    onLoaded: (composition) {
                                      _controller
                                        ..duration = composition.duration
                                        ..repeat();
                                    },
                                  ),
                                )
                              : groupOfCards(
                                  dataList[0],
                                  dataList[1],
                                  dataList[2],
                                  const RouteWhereYouGo(),
                                  dataList[3],
                                  dataList[4],
                                  dataList[5],
                                  const RouteWhereYouGo(),
                                  context,
                                  _animation,
                                );
                          // for (int i = 0; i < dataList.length; i += 6) {
                          //   // Ensure there are at least 6 elements remaining in the list
                          //   if (i + 6 <= dataList.length) {
                          //     return dataList[0] == ''
                          //         ? Center(
                          //             child: Lottie.asset(
                          //               "assets/animation/null-animation.json",
                          //               controller: _controller,
                          //               onLoaded: (composition) {
                          //                 _controller
                          //                   ..duration = composition.duration
                          //                   ..repeat();
                          //               },
                          //             ),
                          //           )
                          //         : groupOfCards(
                          //             dataList[i],
                          //             dataList[i + 1],
                          //             dataList[i + 2],
                          //             const RouteWhereYouGo(),
                          //             dataList[i + 3],
                          //             dataList[i + 4],
                          //             dataList[i + 5],
                          //             const RouteWhereYouGo(),
                          //             context,
                          //             _animation,
                          //           );
                          //   }
                          // }
                          // return const SizedBox();
                        }),
                      ),
                      if (isLoading) const TransparentLoadingScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
