import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistappp/app/modules/home/controller.dart';
import 'package:todolistappp/app/core/utils/extenstions.dart';
import 'package:todolistappp/app/modules/home/widgets/add_card.dart';

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
              'asdas',
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [AddCard()],
          )
        ],
      )),
    );
  }
}
