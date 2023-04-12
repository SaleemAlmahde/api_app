import 'package:api_app/bloc/cubits/app_cubit.dart';
import 'package:api_app/bloc/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("DetailsPage"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  controller: appCubit.nameController,
                  decoration: const InputDecoration(
                      label: Text("Name"), border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: appCubit.addressController,
                  decoration: const InputDecoration(
                      label: Text("Address"), border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 8,
                ),
                Checkbox(
                  value: appCubit.isActive,
                  onChanged: (value) =>
                      appCubit.changeIsActiveEvent(value ?? false),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await appCubit.save();
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text("Save")),
              ],
            ),
          ),
        );
      },
    );
  }
}
