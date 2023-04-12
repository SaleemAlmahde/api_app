abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppRefreshUIState extends AppStates {}

class AppErrorState extends AppStates {
  AppErrorState(this.msg);
  String msg;
}

class AppSuccessState extends AppStates {
  AppSuccessState(this.msg);
  String msg;
}
