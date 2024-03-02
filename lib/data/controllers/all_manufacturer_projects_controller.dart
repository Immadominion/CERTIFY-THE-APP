import 'dart:async';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/model_data/all_projects_model.dart';
import 'package:certify/data/services/certify_project_services.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final certifyProjectsController = ChangeNotifierProvider<AllProjectsController>(
    (ref) => AllProjectsController());

class AllProjectsController extends BaseChangeNotifier {
  ProjectServices projectServices = ProjectServices();
  AllProjectsModel allProjectsModel = AllProjectsModel();

  void disposeAllProjectsController() {
    allProjectsModel = AllProjectsModel();
  }

  Future<bool> toGetAllProjects() async {
    // Check if the entire model has data
    // if (allProjectsModel.projects?.isNotEmpty ?? false) {
    //   // loadingState = LoadingState.idle;
    //   return true;
    // }

    try {
      loadingState = LoadingState.loading;
      debugPrint('shh To Get All Manufacturer Projects');
      final res = await projectServices.getProjects();
      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer shh ${res.data}");
        allProjectsModel = AllProjectsModel.fromJson(res.data);
        debugPrint("INFO: Done converting network data to dart model");
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
