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
  List radioColors = [0xff979797, 0xffb4e1ff, 0xFF001AFF];
  List deleteTitle = [];
  List deleteDescription = [];
  List deleteColor = [];

  onPressedAdd() async {
    await Hive.box('title').add(titleController.text);
    await Hive.box('description').add(descriptionController.text);
    await Hive.box('tileColor').add(value == 0
        ? 0xff979797
        : value == 1
            ? 0xffb4e1ff
            : 0xFF001AFF);
    print(Hive.box('title').getAt(0).toString());
    print(Hive.box('description').getAt(0).toString());
    print(Hive.box('tileColor').getAt(0).toString());
    titleController.clear();
    descriptionController.clear();
    value = 0;
    descriptionController.clear();

    emit(TodoInitial());
  }

  onPressedDelete(int index) async {
    deleteTitle.add(Hive.box('title').getAt(index));
    deleteDescription.add(Hive.box('description').getAt(index));
    deleteColor.add(Hive.box('tileColor').getAt(index));
    await Hive.box('title').deleteAt(index);
    await Hive.box('description').deleteAt(index);
    await Hive.box('tileColor').deleteAt(index);
    emit(TodoInitial());
  }

  onPressedReverse() async {
    if (deleteTitle.isNotEmpty) {
      await Hive.box('title').add(deleteTitle.last);
      await Hive.box('description').add(deleteDescription.last);
      await Hive.box('tileColor').add(deleteColor.last).then((value) => {
            deleteTitle.removeAt(deleteTitle.length - 1),
            deleteDescription.removeAt(deleteDescription.length - 1),
            deleteColor.removeAt(deleteColor.length - 1),
          });
    }

    emit(TodoInitial());
  }

  onPressedClear() async {
    await Hive.box('title').clear();
    await Hive.box('description').clear();
    await Hive.box('tileColor').clear();
    emit(TodoInitial());
  }

  void changeValue(int neValue) {
    value = neValue;
    emit(TodoInitial());
  }
}
