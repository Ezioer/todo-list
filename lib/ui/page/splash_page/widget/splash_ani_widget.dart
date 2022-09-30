import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../base/get/get_common_view.dart';
import '../../../../res/r.dart';
import '../../../../res/strings.dart';
import '../../../../res/style.dart';
import '../../../../routes/routes.dart';
import '../splash_controller.dart';

class SplashAnimWidget extends GetCommonView<SplashController> {
  const SplashAnimWidget({Key? key}) : super(key: key);

  @override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        onEnd: () {
          Get.offNamed(Routes.homePage);
        },
        opacity: controller.opacityLevel,
        duration: const Duration(milliseconds: 2000),
        child: Container(
          margin: const EdgeInsets.only(top: 120),
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                R.assetsImagesApplication,
                fit: BoxFit.fitWidth,
                width: 110,
                height: 110,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Text(
                  StringStyles.appName.tr,
                  style: Styles.style_white_24,
                ),
              ),
            ],
          ),
        ));
  }
}
