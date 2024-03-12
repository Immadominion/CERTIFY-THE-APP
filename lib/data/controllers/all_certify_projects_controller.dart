import 'dart:async';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/model_data/all_certified_projects.dart';
import 'package:certify/data/services/all_certified_service.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allCertifiedProjectsController =
    ChangeNotifierProvider<AllProjectsController>(
        (ref) => AllProjectsController());

class AllProjectsController extends BaseChangeNotifier {
  AllCertifiedServices allCertifiedServices = AllCertifiedServices();
  AllCertifiedProjectsModel allCertifiedProjectsModel =
      AllCertifiedProjectsModel();
  void disposeAllProjectsController() {
    allCertifiedProjectsModel = AllCertifiedProjectsModel();
  }

  Future<bool> toGetAllProjects() async {
    // Check if the entire model has data
    if (allCertifiedProjectsModel.description != null) {
      // loadingState = LoadingState.idle;
      return true;
    }

    try {
      loadingState = LoadingState.loading;
      debugPrint('shh To Get All Manufacturer Projects');
      final res = await allCertifiedServices.getAllCertifiedProjects();
      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer shh ${res.data}");
        allCertifiedProjectsModel = AllCertifiedProjectsModel.fromMap(res.data);
        debugPrint("INFO: Done");
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
