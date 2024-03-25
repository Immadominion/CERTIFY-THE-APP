  import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/data/model_data/all_manufacturer_projects_model.dart';
import 'package:certify/presentation/views/manufacturer_home/components/cards.dart';
import 'package:certify/presentation/views/manufacturer_home/components/updateListProjects.dart';
import 'package:certify/presentation/views/project_details/project_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

Widget buildGridView(WidgetRef ref, bool isLoading, 
controller, animation) {
    final List<ProjectModel>? projects = ref
        .watch(certifyProjectsController)
        .allManufacturerProjectsModel
        .projects;

    if (projects == null || projects.isEmpty) {
      return Center(
        child: Lottie.asset(
          "assets/animation/null-animation.json",
          controller: controller,
          onLoaded: (composition) {
            controller
              ..duration = composition.duration
              ..repeat();
          },
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(15.w),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 180.h,
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
      ),
      itemBuilder: (context, index) {
        final  project = ref
            .watch(certifyProjectsController)
            .allManufacturerProjectsModel
            .projects?[index];
        return card(
          project?.name ?? '',
          project?.status ?? '',
          project?.image ?? '',
          const ProjectDetails(),
          context,
          animation,
          () {
            debugPrint("Starting out action $index");
            updateListProjects(ref, project);
          },
        );
      },
    );
  }