import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/all_certify_projects_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/company/demo_page.dart';
import 'package:certify/presentation/views/home/components/home_page_card.dart';
import 'package:certify/presentation/views/scan_code/scan_code.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class CertifiedHome extends ConsumerStatefulWidget {
  const CertifiedHome({super.key});

  @override
  CertifiedHomeState createState() => CertifiedHomeState();
}

class CertifiedHomeState extends ConsumerState<CertifiedHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final listProjects = ref.read(allCertifiedProjectsController.notifier);

  List<String> dataList = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    Future.delayed(
      Duration.zero,
      () {
        fetchData();
      },
    );
  }

  Future<void> fetchData() async {
    // final listProjects = ref.read(certifyProjectsController);
    await listProjects.toGetAllCertifyProjects();
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
    debugPrint("All home rebuilt");
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final LoadingState loadingState =
              ref.watch(allCertifiedProjectsController).loadingState;
          final bool isLoading = loadingState == LoadingState.loading;
          return Stack(
            children: [
              /// ListView
              ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  CertifyHeader(
                    heading: 'CERTIFY',
                    headerBody: "Certified Authentic Products",
                    icon: Icons.qr_code_scanner_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CertifiedScanner();
                          },
                        ),
                      );
                    },
                  ),
                  RefreshIndicator(
                    onRefresh: () {
                      listProjects.shouldReload = true;
                      return fetchData();
                    },
                    child: SizedBox(
                      height: 535.h,
                      child: Stack(
                        children: [
                          GridView.builder(
                            padding: EdgeInsets.all(15.w),
                            itemCount: listProjects.allCertifiedProjectsModel
                                    .results?.length ??
                                1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 180.h,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.h,
                              crossAxisSpacing: 10.w,
                            ),
                            itemBuilder: ((context, index) {
                              return listProjects.allCertifiedProjectsModel
                                          .results?.isEmpty ??
                                      false
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
                                  : homePageCard(
                                      listProjects.allCertifiedProjectsModel
                                              .results?[index].image
                                              ?.toString() ??
                                          "",
                                      listProjects.allCertifiedProjectsModel
                                              .results?[index].name
                                              .toString() ??
                                          "",
                                      context,
                                      const DemoPage(),
                                    );
                            }),
                          ),
                          if (isLoading) const TransparentLoadingScreen(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
