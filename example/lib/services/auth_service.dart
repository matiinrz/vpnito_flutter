
import 'package:flutter_v2ray_example/services/data/storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/api_helper.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final ApiHelper _apiHelper = Get.find();
  // AuthUser user = AuthUser();

  AuthService() {
    // checkAuthorize();
  }

  final token = "".obs;

  // bool get isLoggedInValue => isAuthorize();


  checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    bool firstRun = prefs.getBool('first_run') ?? true;
    if (firstRun) {
      Storage.clearStorage();
      prefs.setBool('first_run', false);
    }
  }

/*
  Future<void> setToken(String token) async {
    await Storage.saveValue(Constants.token, token);
  }

  String? getToken() {
    return Storage.getValue(Constants.token);
  }

  Future<void> setUser(AuthUser u) async {
    user = u;
    String userString = jsonEncode(u.toJson());
    // print("userString2");
    // print(userString);
    await Storage.updateValue("consultant_user", userString);
  }


  Future<AuthUser> getUser() async {
    if (user.userId == null) {
      var u = await getUserFromLocal();
      if (u == null) {

        logout();
        return AuthUser();
      } else {
        return u;
      }
    } else {
      return user;
    }
  }

  Future<AuthUser?> getUserFromLocal() async {
    String? userString = Storage.getValue("consultant_user");

    print("userString");
    print(userString);
    // if (userString != null) {
    AuthUser user = AuthUser.fromJson(jsonDecode(userString ?? ""));
    setUser(user);
    return user;
    // } else {
    //   return null;
    // }
  }

  updateUser() async {
    // AuthUser? user = await getUserFromLocal();
    var res = await _apiHelper.baseGet(
        '/User/Profile', '?UserId=${user.userId ?? ''}').futureValue(
        retryFunction: () {
          printInfo(info: "retry");
        });

    if (res.status ?? false) {
      user = AuthUser.fromJson(res.data);
      setUser(user);
      return user;
    }
  }

  login(Token token, AuthUser user) async {
    await setToken(token.token!);
    await setUser(user);
    checkAuthorize();
  }

  logout()async {
    var fcmToken = await getFirebaseToken();
    print(fcmToken);
     await DataService.to.logout(user.userId ?? "", fcmToken);
    Storage.removeValue(Constants.token);
    Storage.removeValue("consultant_user");
    user = AuthUser();
    token.value = "";
    Get.offAllNamed(Routes.LOGIN);
    checkAuthorize();


  }

  Future<String> checkAuthorize() async {
    await checkFirstRun();

    print("checked Authorize");

    token.value = getToken() ?? "";
    print(token.value);
    return token.value;
  }

  bool isAuthorize() {
    print("not work");
    return token.value != "";
  }


  bool isProfileCompleted() {
    getUserFromLocal();
    return
      user.firstName?.isNotEmpty == true &&
          user.lastName?.isNotEmpty == true;
  }

  *//*Firebase*//*
  AndroidNotificationChannel? channel;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  int? appRouter;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      if (channel != null && flutterLocalNotificationsPlugin != null) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channelDescription: channel!.description,
                icon: 'launch_background',
              ),
            ));
      } else {
        print("channel or plugin is null");
      }
    }
  }

  Future<String?> fireStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    *//*if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.high,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }*//*
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    return await FirebaseMessaging.instance.getToken();
  }

  firebase() async {
    FirebaseMessaging.instance.getInitialMessage().then((
        RemoteMessage? message) {
      if (message != null) {}
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("fire messsage:");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channelDescription: channel!.description,
                icon: 'launch_background',
              ),
            ));
      } else {
        print("channel or plugin is null or kisweb");
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      appRouter = int.parse(message.data["Type"]);
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((res) {
      print('User granted permission: ${res.authorizationStatus}');

      return res;
    }, onError: (e) {
      print("error in permission");
      print(e);
    });
  }

  Future<String?> getFirebaseToken() async {
    return await FirebaseMessaging.instance.getToken();
  }*/
/*Firebase*/
}
