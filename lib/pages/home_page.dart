import 'package:flutter/material.dart';
import 'package:new_app/pages/carrier_info_page.dart';
import 'package:new_app/pages/location_info_page.dart';
import 'package:new_app/pages/network_info_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: const DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.phone_android,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.wifi,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.pin_drop,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                CarrierInfoPage(),
                NetworkInfoPage(),
                LocationInfoPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
