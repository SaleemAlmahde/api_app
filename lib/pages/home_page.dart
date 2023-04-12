import 'package:api_app/bloc/cubits/app_cubit.dart';
import 'package:api_app/bloc/cubits/auth_cubit.dart';
import 'package:api_app/bloc/states/app_states.dart';
import 'package:api_app/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Employees'),
            actions: [
              IconButton(
                  onPressed: () async {
                    await AuthCubit.get(context).logout();
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: appCubit.employeesList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(appCubit.employeesList[index].name),
                subtitle: Text(appCubit.employeesList[index].address),
                leading: Icon(
                  appCubit.employeesList[index].isActive
                      ? Icons.done
                      : Icons.close,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await appCubit.deleteEmployees(
                        appCubit.employeesList[index].objectId);
                  },
                  icon: const Icon(Icons.delete),
                ),
                onTap: () {
                  appCubit.fillEmployeesPage(appCubit.employeesList[index]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsPage(),
                      ));
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              appCubit.clearEmployeesPage();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
