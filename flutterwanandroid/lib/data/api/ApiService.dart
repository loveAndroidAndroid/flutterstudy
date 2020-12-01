import 'package:dio/dio.dart';
import 'package:flutterwanandroid/data/api/Apis.dart';
import 'package:flutterwanandroid/data/model/UserModel.dart';
import 'package:flutterwanandroid/net/DioManager.dart';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {
  /// 登录
  void login(Function callback, Function errorCallback, String _username,
      String _password) async {
    FormData formData =
        new FormData.fromMap({"username": _username, "password": _password});
    dio.post(Apis.USER_LOGIN, data: formData).then((response) {
      callback(UserModel.fromJson(response.data), response);
    }).catchError((e) {
      errorCallback(e);
    });
  }

  /// 注册
  void register(Function callback, Function errorCallback, String _username,
      String _password) async {
    FormData formData = new FormData.fromMap({
      "username": _username,
      "password": _password,
      "repassword": _password
    });
    dio.post(Apis.USER_REGISTER, data: formData).then((response) {
      callback(UserModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }
}
