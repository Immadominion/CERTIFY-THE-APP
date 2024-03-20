import 'dart:ui';

import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/views/project_details/components/image_icon_on_pd.dart';
import 'package:certify/presentation/views/project_details/components/image_view_on_pd.dart';
import 'package:certify/presentation/views/project_details/components/table_row_on_pd.dart';
import 'package:certify/presentation/views/shared_widgets/status_bar_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectDetails extends ConsumerStatefulWidget {
  const ProjectDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends ConsumerState<ProjectDetails>
    with SingleTickerProviderStateMixin {
  late final ScrollController myScrollController;
  late  final holdVal = ref.read(certifyProjectsController);
  bool _isIconVisible = true;
  @override
  void initState() {
    super.initState();
    // Change the color of the status bar to blue
    setStatusBarColor(const Color(0xff5C71F3));
    myScrollController = ScrollController();
    myScrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () {
      fetchData();
    });
  }

  @override
  void dispose() {
    resetStatusBarColor();
    myScrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final isScrollingDown = myScrollController.position.userScrollDirection ==
        ScrollDirection.forward;
    setState(() {
      _isIconVisible = isScrollingDown;
    });
  }

  Future<void> fetchData() async {
    // final listProjects = ref.read(certifyProjectsController);
    // await listProjects.toGetAllManufacturerProjects();
    // Update the dataList here based on the fetched data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
         
          return Stack(
            children: [
              ListView(
                controller: myScrollController,
                physics: const BouncingScrollPhysics(
                  parent: ClampingScrollPhysics(),
                ),
                children: [
                  imageViewer(ref),
                  Text(
                    holdVal.projectName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).afmPadding(),
                  Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width - 20.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15.r,
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Table(
                      border: TableBorder(
                        verticalInside: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                          style: BorderStyle.solid,
                        ),
                      ),
                      columnWidths: {
                        0: FixedColumnWidth(60.w),
                        1: FixedColumnWidth(90.w)
                      },
                      children: [
                        tableRowOnPd('Symbol', holdVal.symbol, context),
                        tableRowOnPd(
                            'Description', holdVal.description, context),
                        tableRowOnPd(
                          'Mint Address',
                          holdVal.mintAddress,
                          context,
                          copyText: true,
                          onTap: () {},
                        ),
                        tableRowOnPd("Seller Free Basis Points",
                            holdVal.sellerFreeBasisPoints, context),
                      ],
                    ).afmPadding(),
                  ),
                ],
              ),
              AnimatedPositioned(
                top: 35.h,
                left: _isIconVisible ? 10.w : -kToolbarHeight,
                duration: const Duration(milliseconds: 200),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    myScrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    Navigator.pop(context);
                  },
                  child: imageIcon(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
