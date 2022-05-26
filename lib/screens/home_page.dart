import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/Bloc/cubit/todo_cubit.dart';

import '../widgets/floating_action_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  int value = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  centerTitle: true,
                  title: const Text('Home Page'),
                  expandedHeight: 50,
                  floating: true,
                  backgroundColor: Colors.green[900],
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      alerDialog(context,
                          title: "Barcha listni o'chirishni istaysizmi?",
                          isClear: true);
                    },
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.read<TodoCubit>().onPressedReverse();
                        },
                        icon: Icon(Icons.repeat)),
                  ],
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
                          alerDialog(context,
                              index: __,
                              title: "Bu Listni o'chirishni istaysizmi?",
                              isClear: false);
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          Hive.box('description').getAt(__).toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Hive.box('description').length,
              ),
            ),
            floatingActionButton: floatingActionButton(context, value));
      },
    );
  }

  alerDialog(BuildContext context,
      {int? index, String? title, bool? isClear}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.bottomCenter,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            title: Text(title!),
            actions: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.blue),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Yo'q",
                          textAlign: TextAlign.center,
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.red),
                        onPressed: () async {
                          isClear!
                              ? await context.read<TodoCubit>().onPressedClear()
                              : await context
                                  .read<TodoCubit>()
                                  .onPressedDelete(index!);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Ha",
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              )
            ],
          );
        });
  }
}
