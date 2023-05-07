import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todolistappp/app/core/values/colors.dart';
import 'package:todolistappp/app/data/models/task.dart';
import 'package:todolistappp/app/modules/home/controller.dart';
import 'package:todolistappp/app/core/utils/extenstions.dart';
import 'package:todolistappp/app/modules/home/widgets/add_card.dart';
import 'package:todolistappp/app/modules/home/widgets/add_dialog.dart';
import 'package:todolistappp/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'List Task',
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                AddCard(),
                ...controller.tasks
                    .map(
                      (element) => LongPressDraggable(
                          data: element,
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (velocity, offset) {
                            print(velocity);
                            print(offset);
                            controller.changeDeleting(false);
                          },
                          onDragEnd: (details) {
                            print("hello");
                            controller.changeDeleting(false);
                          },
                          feedback: Opacity(
                              opacity: 0.8, child: TaskCard(task: element)),
                          child: TaskCard(task: element)),
                    )
                    .toList(),
              ],
            ),
          )
        ],
      )),
      floatingActionButton: DragTarget<Task>(
        builder: (_, candidateData, rejectedData) {
          return Obx(() => FloatingActionButton(
              onPressed: () =>
                  Get.to(() => AddDialog(), transition: Transition.downToUp),
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              child:
                  Icon(controller.deleting.value ? Icons.delete : Icons.add)));
        },
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Sucess');
        },
      ),
    );
  }
}
