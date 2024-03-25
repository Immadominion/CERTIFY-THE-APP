import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/create/create_project.dart';
import 'package:certify/presentation/views/manufacturer_home/components/cards.dart';
import 'package:certify/presentation/views/project_details/project_details_page.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';
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
    await listProjects.toGetAllManufacturerProjects();
    // Update the dataList here based on the fetched data
    // setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuilt object");
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final LoadingState loadingState =
            ref.watch(certifyProjectsController).loadingState;
        final bool isLoading = loadingState == LoadingState.loading;
        return Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                CertifyHeader(
                  heading: "CERTIFY",
                  headerBody: "All Your Products",
                  icon: Icons.add_business_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CreateNewProject();
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
                          itemCount: listProjects.allManufacturerProjectsModel
                                  .projects?.length ??
                              1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 180.h,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.w,
                          ),
                          itemBuilder: ((context, index) {
                            return listProjects.allManufacturerProjectsModel
                                        .projects?.isEmpty ??
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
                                : card(
                                    listProjects.allManufacturerProjectsModel
                                            .projects?[index].name ??
                                        '',
                                    listProjects.allManufacturerProjectsModel
                                            .projects?[index].status ??
                                        '',
                                    listProjects.allManufacturerProjectsModel
                                            .projects?[index].image ??
                                        '',
                                    const ProjectDetails(),
                                    context,
                                    _animation, () {
                                    debugPrint("Starting out action $index");
                                    listProjects.imageUrl = listProjects
                                            .allManufacturerProjectsModel
                                            .projects?[index]
                                            .image ??
                                        "";
                                    listProjects.projectName = listProjects
                                            .allManufacturerProjectsModel
                                            .projects?[index]
                                            .name ??
                                        "";
                                    listProjects.projectId = listProjects
                                            .allManufacturerProjectsModel
                                            .projects?[index]
                                            .id
                                            .toString() ??
                                        "";
                                    listProjects.symbol = listProjects
                                            .allManufacturerProjectsModel
                                            .projects?[index]
                                            .symbol ??
                                        '';
                                    listProjects.description = listProjects
                                            .allManufacturerProjectsModel
                                            .projects?[index]
                                            .description ??
                                        '';
                                    listProjects.mintAddress = listProjects
                                            .allManufacturerProjectsModel
                                            .projects?[index]
                                            .mintAddress ??
                                        '';
                                    listProjects.sellerFreeBasisPoints =
                                        listProjects
                                                .allManufacturerProjectsModel
                                                .projects?[index]
                                                .sellerFeeBasisPoints
                                                .toString() ??
                                            '';
                                  });
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
      }),
    );
  }
}
