import 'package:get/get.dart';
import 'package:todolistappp/app/data/providers/task/provider.dart';
import 'package:todolistappp/app/data/services/storage/repository.dart';
import 'package:todolistappp/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
