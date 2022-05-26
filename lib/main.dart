import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todoapp/Bloc/cubit/todo_cubit.dart';
import 'package:todoapp/screens/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('title');
  await Hive.openBox('description');
  await Hive.openBox('tileColor');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => TodoCubit(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'Material App',
      home: HomePage(),
    );
  }
}
