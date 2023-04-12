import 'package:api_app/bloc/states/auth_states.dart';
import 'package:api_app/utils/dio_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.sp) : super(AuthInitialState());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  SharedPreferences sp;
  String token = "";

  TextEditingController registerUserNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerPasswordConfirmationController =
      TextEditingController();

  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  void loadTokenFromSP() {
    String t = sp.getString("token") ?? "";
    DioHelper.initialize(token: t);
    token = t;
    emit(AuthRefreshUIState());
  }

  Future<void> saveTokenInSP(String t) async {
    await sp.setString("token", t);
    loadTokenFromSP();
  }

  Future<void> register() async {
    try {
      var data = {
        "username": registerUserNameController.text.trim(),
        "email": registerEmailController.text.trim(),
        "password": registerPasswordController.text,
      };
      var res = await DioHelper.dio!.post("users", data: data);
      if (res.statusCode == 201) {
        saveTokenInSP(res.data["sessionToken"] as String);
        emit(AuthSuccessState());
      }
    } catch (e) {
      emit(AuthErrorState());
    }
  }

  Future<void> login() async {
    try {
      var params = {
        "username": loginUserNameController.text.trim(),
        "password": loginPasswordController.text,
      };
      var res = await DioHelper.dio!.get("login", queryParameters: params);
      if (res.statusCode == 200) {
        saveTokenInSP(res.data["sessionToken"] as String);
        emit(AuthSuccessState());
      }
    } catch (e) {
      emit(AuthErrorState());
    }
  }

  Future<void> logout() async {
    await saveTokenInSP("");
  }
}
