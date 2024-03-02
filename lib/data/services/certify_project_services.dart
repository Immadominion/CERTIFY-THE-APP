import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class ProjectServices with DioMixin {
  ///To get the user projects available and their corresponding ID
  Future<Response<dynamic>> getProjects() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/project',
    );
    return response;
  }
}
