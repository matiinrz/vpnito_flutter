import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';

import '../../utils/custom_theme.dart';
import '../../widgets/server_list_widget.dart';
import '../servers/server_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<String> _durationStream;
  CharonErrorState charonState = CharonErrorState.NO_ERROR;
  Server? server;
  String connectionTime = '00.00.00';

  @override
  void initState() {
    super.initState();
    _durationStream = vpnConnectionDuration();
  }

  Stream<String> vpnConnectionDuration() async* {
    if (server == null) {
      yield 'Please select a server!';
      return;
    }
    debugPrint('called');
    yield 'Connecting...';
    // Connect to VPN service
    await FlutterVpn.connectIkev2EAP(
      server: server!.domain!,
      username: server!.username!,
      password: server!.password!,
      name: server!.name!,
      mtu: server!.mtu!,
      port: server!.port!,
    );

    // Get current time
    DateTime startTime = DateTime.now();

    // Wait for VPN to connect
    FlutterVpn.prepare();

    // Create a timer that emits the duration of the VPN connection every second
    Timer.periodic(const Duration(seconds: 1), (timer) async* {
      // Get current time
      DateTime now = DateTime.now();

      // Calculate duration of VPN connection
      Duration duration = now.difference(startTime);

      // Format duration as 00.00.00
      String formattedDuration =
          "${duration.inHours.toString().padLeft(2, '0')}.${(duration.inMinutes % 60).toString().padLeft(2, '0')}.${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
      debugPrint(formattedDuration);
      // Emit the formatted duration
      yield formattedDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'VPNITO',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        body: StreamBuilder<FlutterVpnState>(
            stream: FlutterVpn.onStateChanged,
            builder: (context, snapshot) {
              final _flutterVpnState = snapshot.data ?? FlutterVpnState.disconnected;
              return Stack(
                children: [
                  Positioned(
                      top: 50,
                      child: Opacity(
                          opacity: .1,
                          child: Image.asset(
                            'assets/background.png',
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height / 1.5,
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        Center(
                            child: Text(
                          '${connectionState(state: _flutterVpnState)}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                        SizedBox(height: 8),
                        FutureBuilder<List<NetworkInterface>>(
                            future: NetworkInterface.list(),
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? [];
                              final ip =
                                  data.isEmpty ? '0.0.0.0' : data.first.addresses.first.address;
                              return Center(
                                  child: Text(
                                ip,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: connectionColorState(state: _flutterVpnState),
                                    fontWeight: FontWeight.w600),
                              ));
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              print("object");
                              vpnConnectionDuration().listen((event) {
                                print(event);
                              });
                            },
                            borderRadius: BorderRadius.circular(90),
                            child: AvatarGlow(
                              glowColor: _flutterVpnState != FlutterVpnState.connected
                                  ? Colors.transparent
                                  : connectionColorState(state: _flutterVpnState),
                              endRadius: 100.0,
                              duration: Duration(milliseconds: 2000),
                              repeat: _flutterVpnState != FlutterVpnState.connected ? false : true,
                              showTwoGlows: true,
                              repeatPauseDuration: Duration(milliseconds: 100),
                              shape: BoxShape.circle,
                              child: Material(
                                elevation: 0,
                                shape: CircleBorder(),
                                color: connectionColorState(state: _flutterVpnState),
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.power_settings_new,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${connectionButtonState(state: _flutterVpnState)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<String>(
                            stream: _durationStream,
                            builder: (context, snapshot) {
                              return Center(
                                  child: Text(
                                snapshot.data ?? '00.00.00',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: customLightTheme(context).secondaryHeaderColor),
                              ));
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        ServerItemWidget(
                          flagAsset: server?.flag ?? 'assets/logo.png',
                          label: server?.name ?? 'No sever selected',
                          icon: Icons.arrow_forward_ios,
                          onTap: () async {
                            final res = await Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ServerListPage();
                            }));

                            if (res != null) {
                              setState(() {
                                server = res;
                              });

                              vpnConnectionDuration().listen((event) {
                                print(event);
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        // FastestServerWidget(label: label, icon: icon, flagAsset: flagAsset, onTap: onTap),
                        Spacer(),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: MediaQuery.of(context).size.width / 4.5),
                            backgroundColor: Color.fromRGBO(37, 112, 252, 1),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Get Premium',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }

  String connectionState({FlutterVpnState? state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return 'You are connected';
      case FlutterVpnState.connecting:
        return 'VPN is connecting';
      case FlutterVpnState.disconnected:
        return 'You are disconnected';
      case FlutterVpnState.disconnecting:
        return 'VPN is disconnecting';
      case FlutterVpnState.error:
        return 'Error getting status';
      default:
        return 'Getting connection status';
    }
  }

  String connectionButtonState({FlutterVpnState? state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return 'Connected';
      case FlutterVpnState.connecting:
        return 'Connecting';
      case FlutterVpnState.disconnected:
        return 'Disconnected';
      case FlutterVpnState.disconnecting:
        return 'Disconnecting';
      case FlutterVpnState.error:
        return 'Error';
      default:
        return 'Disconnected';
    }
  }

  Color connectionColorState({FlutterVpnState? state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return Color.fromRGBO(37, 112, 252, 1);
      case FlutterVpnState.connecting:
        return Color.fromRGBO(87, 141, 240, 1);
      case FlutterVpnState.disconnected:
      case FlutterVpnState.disconnecting:
        return Colors.grey;

      default:
        return Colors.red;
    }
  }
}

/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );
  final config = TextEditingController();
  bool proxyOnly = false;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  final bypassSubnetController = TextEditingController();
  List<String> bypassSubnets = [];
  String? coreVersion;

  String remark = "Default Remark";

  void connect() async {
    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(
        remark: remark,
        config: config.text,
        proxyOnly: proxyOnly,
        bypassSubnets: bypassSubnets,
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission Denied'),
          ),
        );
      }
    }
  }

  void importConfig() async {
    if (await Clipboard.hasStrings()) {
      try {
        final String link =
            (await Clipboard.getData('text/plain'))?.text?.trim() ?? '';
        final V2RayURL v2rayURL = FlutterV2ray.parseFromURL(link);
        remark = v2rayURL.remark;
        config.text = v2rayURL.getFullConfiguration();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Success',
              ),
            ),
          );
        }
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: $error',
              ),
            ),
          );
        }
      }
    }
  }

  void delay() async {
    late int delay;
    if (v2rayStatus.value.state == 'CONNECTED') {
      delay = await flutterV2ray.getConnectedServerDelay();
    } else {
      delay = await flutterV2ray.getServerDelay(config: config.text);
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${delay}ms',
        ),
      ),
    );
  }

  void bypassSubnet() {
    bypassSubnetController.text = bypassSubnets.join("\n");
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Subnets:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: bypassSubnetController,
                maxLines: 5,
                minLines: 5,
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  bypassSubnets =
                      bypassSubnetController.text.trim().split('\n');
                  if (bypassSubnets.first.isEmpty) {
                    bypassSubnets = [];
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    flutterV2ray.initializeV2Ray().then((value) async {
      coreVersion = await flutterV2ray.getCoreVersion();
      setState(() {});
    });
  }

  @override
  void dispose() {
    config.dispose();
    bypassSubnetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text(
              'V2Ray Config (json):',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: config,
              maxLines: 10,
              minLines: 10,
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: v2rayStatus,
              builder: (context, value, child) {
                return Column(
                  children: [
                    Text(value.state),
                    const SizedBox(height: 10),
                    Text(value.duration),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Speed:'),
                        const SizedBox(width: 10),
                        Text(value.uploadSpeed),
                        const Text('↑'),
                        const SizedBox(width: 10),
                        Text(value.downloadSpeed),
                        const Text('↓'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Traffic:'),
                        const SizedBox(width: 10),
                        Text(value.upload),
                        const Text('↑'),
                        const SizedBox(width: 10),
                        Text(value.download),
                        const Text('↓'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Core Version: $coreVersion'),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  ElevatedButton(
                    onPressed: connect,
                    child: const Text('Connect'),
                  ),
                  ElevatedButton(
                    onPressed: () => flutterV2ray.stopV2Ray(),
                    child: const Text('Disconnect'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => proxyOnly = !proxyOnly),
                    child: Text(proxyOnly ? 'Proxy Only' : 'VPN Mode'),
                  ),
                  ElevatedButton(
                    onPressed: importConfig,
                    child: const Text(
                      'Import from v2ray share link (clipboard)',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: delay,
                    child: const Text('Server Delay'),
                  ),
                  ElevatedButton(
                    onPressed: bypassSubnet,
                    child: const Text('Bypass Subnet'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
