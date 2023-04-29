import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todolistappp/app/core/utils/extenstions.dart';
import 'package:todolistappp/app/core/values/colors.dart';
import 'package:todolistappp/app/data/models/task.dart';
import 'package:todolistappp/app/modules/home/controller.dart';
import 'package:todolistappp/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: Center(
          child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              title: 'Task Type',
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              content: Form(
                  key: homeCtrl.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: homeCtrl.editController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      label: e,
                                      selected:
                                          homeCtrl.chipIndex.value == index,
                                      selectedColor: Colors.grey[200],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      onSelected: (selected) {
                                        homeCtrl.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (homeCtrl.formKey.currentState!.validate()) {
                            int icon =
                                icons[homeCtrl.chipIndex.value].icon!.codePoint;
                            String color =
                                icons[homeCtrl.chipIndex.value].color!.toHex();

                            var task = Task(
                                title: homeCtrl.editController.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homeCtrl.addTask(task)
                                ? EasyLoading.showSuccess('Create success')
                                : EasyLoading.showError('Duplicated Task');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(150, 40)),
                        child: const Text('Comfirm'),
                      )
                    ],
                  )));
          homeCtrl.editController.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      )),
    );
  }
}
