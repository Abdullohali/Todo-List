import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Bloc/cubit/todo_cubit.dart';

FloatingActionButton floatingActionButton(
  BuildContext context,
  int _value,
) {
  return FloatingActionButton(
    onPressed: () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              contentPadding: EdgeInsets.zero,
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: BlocBuilder<TodoCubit, TodoState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller:
                                context.watch<TodoCubit>().titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Title',
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: TextFormField(
                              controller: context
                                  .watch<TodoCubit>()
                                  .descriptionController,
                              maxLines: 20,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              // Setting this attribute to true does the trick
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          for (int i = 0; i <= 2; i++)
                            SizedBox(
                              width: double.infinity,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  context.read<TodoCubit>().should[i],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(),
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor: Color(
                                    context.read<TodoCubit>().radioColors[i],
                                  ),
                                  radius: 10,
                                ),
                                leading: Radio(
                                    value: i,
                                    groupValue:
                                        context.watch<TodoCubit>().value,
                                    activeColor: Color(
                                      context.read<TodoCubit>().radioColors[i],
                                    ),
                                    onChanged: (e) {
                                      context
                                          .read<TodoCubit>()
                                          .changeValue(int.parse(e.toString()));
                                    }),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: const Text('Cancel'),
                                style:
                                    TextButton.styleFrom(primary: Colors.red),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                  child: const Text('Save'),
                                  style: TextButton.styleFrom(
                                      primary: Colors.blue),
                                  onPressed: () {
                                    context.read<TodoCubit>().onPressedAdd(
                                  );
                                  }),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          });
    },
    child: const Icon(Icons.edit),
    backgroundColor: Colors.green[900],
  );
}
