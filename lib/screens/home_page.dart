import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/Bloc/cubit/todo_cubit.dart';

import '../widgets/floating_action_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  int value = 1;

  List a = [];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          
          return NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                centerTitle: true,
                title: const Text('Home Page'),
                expandedHeight: 50,
                floating: true,
                backgroundColor: Colors.green[900],
              ),
            ],
            body: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) {
                return ExpansionTile(
                  textColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                  collapsedBackgroundColor:
                      Color(Hive.box('tileColor').getAt(__) ?? 0xff979797),
                  backgroundColor:
                      Color(Hive.box('tileColor').getAt(__) ?? 0xff979797),
                  title: Text(
                    Hive.box('title').getAt(__).toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  leading: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<TodoCubit>().onPressedDelete(__);
                      }),
                  children: [
                    Padding(
                      padding:
                        const  EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        Hive.box('description').getAt(__).toString(),
                        style:const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                );
              },
              itemCount: Hive.box('description').length,
            ),
          );
        },
      ),
      floatingActionButton: floatingActionButton(context, value),
    );
  }
}
