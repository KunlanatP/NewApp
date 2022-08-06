import 'package:carrier_info/carrier_info.dart';
import 'package:flutter/material.dart';

class CarrierInfoPage extends StatefulWidget {
  const CarrierInfoPage({Key? key}) : super(key: key);

  @override
  State<CarrierInfoPage> createState() => _CarrierInfoPageState();
}

class _CarrierInfoPageState extends State<CarrierInfoPage> {
  Map<String, dynamic> _carrierInfo = {};

  @override
  void initState() {
    _getCarrierInfo();
    super.initState();
  }

  void _getCarrierInfo() async {
    final carrierInfo = <String, dynamic>{
      'Name': await CarrierInfo.carrierName,
      'Country Code': await CarrierInfo.isoCountryCode,
      'Mobile Country Code': await CarrierInfo.mobileCountryCode,
      'Mobile Network Operator': await CarrierInfo.mobileNetworkOperator,
      'Mobile Network Code': await CarrierInfo.mobileNetworkCode,
      'Allows VOIP': await CarrierInfo.allowsVOIP,
      'Radio Type': await CarrierInfo.radioType,
      'Network Generation': await CarrierInfo.networkGeneration,
      'Cell Id (CID)': await CarrierInfo.cid,
      'Local Area Code (LAC)': await CarrierInfo.lac,
    };

    setState(() => _carrierInfo = carrierInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _carrierInfo.entries
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
