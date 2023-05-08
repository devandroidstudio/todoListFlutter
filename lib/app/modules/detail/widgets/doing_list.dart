import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistappp/app/core/utils/extenstions.dart';
import 'package:todolistappp/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodo.isEmpty && homeCtrl.doneTodo.isEmpty
        ? Column(
            children: [
              Image.asset(
                'assets/images/image_todo.jpg',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              Text(
                'Add Task',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodo
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                onChanged: (value) {
                                  homeCtrl.doneTodoFunction(element['title']);
                                },
                                value: element['done'],
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                              ),
                            ),
                            SizedBox(width: 3.0.wp),
                            Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ))
                  .toList(),
              if (homeCtrl.doingTodo.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                )
            ],
          ));
  }
}
