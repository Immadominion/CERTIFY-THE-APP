import 'package:dio/dio.dart' show FormData, Options, Response;
import 'dio_mixin.dart';

class GetProfileService with DioMixin {
  Future<Response<dynamic>> getProfileDetails() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response =
        await connect(customHeaders: customHeaders).get('/user/profile',
            options: Options(
              method: 'GET',
            ));
    //debugPrint('Info: Service has ${response.data}');
    return response;
  }

  Future<Response<dynamic>> getReferralDetails() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response =
        await connect(customHeaders: customHeaders).get('/user/referrals',
            options: Options(
              method: 'GET',
            ));
    //debugPrint('Info: Service has ${response.data}');
    return response;
  }

  Future<Response<dynamic>> setProfilePic({required FormData formData}) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/user/profile-image',
      data: formData,
    );
    //debugPrint('Info: Service has ${response.data}');
    return response;
  }
}
