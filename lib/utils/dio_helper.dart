import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static String baseUrl = "https://parseapi.back4app.com/";
  static void initialize({String token = ""}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "accept": "application/json",
          "X-Parse-Application-Id": "LssksCADv8IHaoF0aiR1LvMCYNo8eWABa3CtPXWB",
          "X-Parse-REST-API-Key": "0WjaY9ctjsFaH7wR0znl0sVtkYVO06tbK9EQyQqP",
          "X-Parse-Session-Token": token,
          "X-Parse-Revocable-Session": 1,
        },
        receiveDataWhenStatusError: true,
        validateStatus: (status) => (status ?? 0) <= 500,
      ),
    );
  }
}
