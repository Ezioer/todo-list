import '../../../base/get/getx_controller_inject.dart';

class SplashController extends BaseGetController {
  double opacityLevel = 0.0;

  @override
  void onInit() {
    super.onInit();
    lazyInitAnim();
  }

  lazyInitAnim() {
    Future.delayed(const Duration(milliseconds: 200), () {
      opacityLevel = 1.0;
      update();
    });
  }
}
