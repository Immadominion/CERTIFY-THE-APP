import 'dart:async';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/model_data/all_manufacturer_projects_model.dart';
import 'package:certify/data/services/certify_project_services.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final certifyProjectsController =
    ChangeNotifierProvider<AllManufacturerProjectsController>(
        (ref) => AllManufacturerProjectsController());

class AllManufacturerProjectsController extends BaseChangeNotifier {
  ProjectServices projectServices = ProjectServices();
  AllManufacturerProjectsModel allManufacturerProjectsModel =
      AllManufacturerProjectsModel();
  bool _shouldReload = false;
  bool get shouldReload => _shouldReload;
  String _imageUrl = "";
  String get imageUrl => _imageUrl;
  String _projectName = "";
  String _symbol = "";
  String _description = "";
  String _mintAddress = "";
  String _sellerFreeBasisPoints = "";
  String get projectName => _projectName;
  String get symbol => _projectName;
  String get description => _projectName;
  String get mintAddress => _projectName;
  String get sellerFreeBasisPoints => _projectName;

  set shouldReload(bool reload) {
    _shouldReload = reload;
    notifyListeners();
  }

  set imageUrl(String url) {
    _imageUrl = url;
    debugPrint("Image Url Has Been Saved Successfully");
    notifyListeners();
  }

  set projectName(String url) {
    _projectName = url;
    debugPrint("Project Name Has Been Saved Successfully");
    notifyListeners();
  }

  set symbol(String symbol) {
    _symbol = symbol;
    debugPrint("Symbol Has Been Saved Successfully");
    notifyListeners();
  }

  set description(String desc) {
    _description = desc;
    debugPrint("Desc Has Been Saved Successfully");
    notifyListeners();
  }

  set mintAddress(String mnA) {
    _mintAddress = mnA;
    debugPrint("mint Address Has Been Saved Successfully");
    notifyListeners();
  }

  set sellerFreeBasisPoints(String sfbp) {
    _sellerFreeBasisPoints = sfbp;
    debugPrint("Seller free remaining points Has Been Saved Successfully");
    notifyListeners();
  }

  void disposeAllManufacturerProjectsController() {
    allManufacturerProjectsModel = AllManufacturerProjectsModel();
  }

  Future<bool> toGetAllManufacturerProjects() async {
    debugPrint(
        "Value of model is ==> ${allManufacturerProjectsModel.projects.toString()}");
    if (shouldReload || allManufacturerProjectsModel.projects == null) {
      try {
        loadingState = LoadingState.loading;
        debugPrint('shh To Get All Manufacturer Projects');
        final res = await projectServices.getProjects();
        debugPrint("Starting out operation on data");
        if (res.statusCode == 200) {
          debugPrint("INFO: Bearer shh ${res.data}");
          allManufacturerProjectsModel =
              AllManufacturerProjectsModel.fromJson(res.data);
          debugPrint("INFO: Done converting network data to dart model");
          loadingState = LoadingState.idle;
          shouldReload = false;
          return true;
        } else {
          loadingState = LoadingState.idle;
          debugPrint("Closing out operation");
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
    return true;
  }
}
