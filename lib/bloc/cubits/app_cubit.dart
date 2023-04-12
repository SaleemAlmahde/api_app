import 'package:api_app/bloc/states/app_states.dart';
import 'package:api_app/models/employee_model.dart';
import 'package:api_app/utils/dio_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isActive = true;
  String? selectedId;
  List<Employee> employeesList = [];

  void clearEmployeesPage() {
    selectedId = null;
    nameController.text = "";
    addressController.text = "";
    isActive = true;
    emit(AppRefreshUIState());
  }

  void fillEmployeesPage(Employee employee) {
    selectedId = employee.objectId;
    nameController.text = employee.name;
    addressController.text = employee.address;
    isActive = employee.isActive;
    emit(AppRefreshUIState());
  }

  void changeIsActiveEvent(bool newVal) {
    isActive = newVal;
    emit(AppRefreshUIState());
  }

  Future<void> getEmployees() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.get("classes/Employees");
      if (res.statusCode == 200) {
        employeesList.clear();
        for (var element in res.data["results"]) {
          employeesList.add(Employee.fromJson(element));
        }
        // print(employeesList.length);
        emit(AppSuccessState("Success"));
      } else {
        emit(AppErrorState("Unknown Error"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> postEmployees() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.post(
        "classes/Employees",
        data: Employee(
          "",
          nameController.text.trim(),
          addressController.text.trim(),
          isActive,
        ).toJson(),
      );
      if (res.statusCode == 201) {
        await getEmployees();
        emit(AppSuccessState("Success"));
      } else {
        emit(AppErrorState("Unknown Error"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> updateEmployees() async {
    try {
      DioHelper.initialize();
      var res = await DioHelper.dio!.put(
        "classes/Employees/$selectedId",
        data: Employee(
          selectedId ?? "",
          nameController.text.trim(),
          addressController.text.trim(),
          isActive,
        ).toJson(),
      );
      if (res.statusCode == 200) {
        await getEmployees();

        emit(AppSuccessState("Success"));
      } else {
        emit(AppErrorState("Unknown Error"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> deleteEmployees(String id) async {
    try {
      DioHelper.initialize();

      var res = await DioHelper.dio!.delete(
        "classes/Employees/$id".toString(),
      );
      if (res.statusCode == 200) {
        await getEmployees();

        emit(AppSuccessState("Success"));
      } else {
        print(res.statusCode);
        emit(AppErrorState("Unknown Error"));
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> save() async {
    if (selectedId == null) {
      await postEmployees();
    } else {
      await updateEmployees();
    }
  }
}
