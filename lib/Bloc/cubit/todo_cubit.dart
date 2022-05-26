import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());
  int value = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List should = ['Simple', 'Important', 'Very Important'];
  List radioColors = [0xff979797, 0xff019e36, 0xffff5959];

  onPressedAdd() async {
    await Hive.box('title').add(titleController.text);
    await Hive.box('description').add(descriptionController.text);
    await Hive.box('tileColor').add(value == 0
        ? 0xff979797
        : value == 1
            ? 0xff019e36
            : 0xffff5959);
    print(Hive.box('title').getAt(0).toString());
    print(Hive.box('description').getAt(0).toString());
    print(Hive.box('tileColor').getAt(0).toString());
    titleController.clear();
    descriptionController.clear();

    descriptionController.clear();

    emit(TodoInitial());
  }

  onPressedDelete(int index) async {
    await Hive.box('title').deleteAt(index);
    await Hive.box('description').deleteAt(index);
    await Hive.box('tileColor').deleteAt(index);
    emit(TodoInitial());
  }

  void changeValue(int neValue) {
    value = neValue;
    emit(TodoInitial());
  }
}
