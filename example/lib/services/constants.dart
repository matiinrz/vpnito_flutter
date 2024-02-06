import 'package:get/get.dart';
class Constants {
  const Constants._();
  static  double widthApp = Get.width>480?480:Get.width;
  static  bool isPhone = Get.width<480;
  static  double heightApp = Get.height>960?960:Get.height;
  static const String baseUrl = 'https://api.odinapp.org';
  // static const String baseUrl = 'http://192.168.3.110:58585';

  static const timeout = Duration(seconds: 5);
  static const String token = 'authToken';

  static const String dummyImageUrl =
      'https://i.picsum.photos/id/1084/536/354.jpg'
      '?grayscale&hmac=Ux7nzg19e1q35mlUVZjhCLxqkR30cC-CarVg-nlIf60';
  static const String placeHolderBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
}
