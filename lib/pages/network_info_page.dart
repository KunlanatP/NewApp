import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkInfoPage extends StatefulWidget {
  const NetworkInfoPage({Key? key}) : super(key: key);

  @override
  State<NetworkInfoPage> createState() => _NetworkInfoPageState();
}

class _NetworkInfoPageState extends State<NetworkInfoPage> {
  Map<String, dynamic> _networkInfo = {};

  @override
  void initState() {
    _getNetworkInfo();
    super.initState();
  }

  void _getNetworkInfo() async {
    final info = NetworkInfo();
    final networkInfo = <String, dynamic>{
      'Name': await info.getWifiName(),
      'BSSID': await info.getWifiBSSID(),
      'IP': await info.getWifiIP(),
      'IPv6': await info.getWifiIPv6(),
      'Submask': await info.getWifiSubmask(),
      'Broadcast': await info.getWifiBroadcast(),
      'Gateway': await info.getWifiGatewayIP(),
    };

    setState(() => _networkInfo = networkInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: _networkInfo.entries
              .map((element) => ListTile(
                    title: Text(element.key),
                    trailing: Text(element.value.toString()),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
