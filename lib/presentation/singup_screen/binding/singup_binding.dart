import 'package:apnagodam/presentation/singup_screen/controller/singup_controller.dart';

// import '../controller/lplist_controller.dart';
import 'package:get/get.dart';

class SingupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingupController());

  }
}
