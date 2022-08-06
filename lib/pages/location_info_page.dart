import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationInfoPage extends StatefulWidget {
  const LocationInfoPage({Key? key}) : super(key: key);

  @override
  State<LocationInfoPage> createState() => _LocationInfoPageState();
}

class _LocationInfoPageState extends State<LocationInfoPage> {
  var _latitude = 0.0;
  var _longitude = 0.0;
  var _altitude = '';
  var _speed = '';
  var _address = '';

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude;
      _longitude = pos.longitude;
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();
      _address = pm[0].toString();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _updatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_latitude == 0.0 && _longitude == 0.0) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        body: FlutterMap(
      options: MapOptions(
        center: LatLng(_latitude, _longitude),
        zoom: 15.0,
        maxZoom: 18.0,
        minZoom: 3.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          tileProvider: const NonCachingNetworkTileProvider(),
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              point: LatLng(_latitude, _longitude),
              width: 80,
              height: 80,
              builder: (context) => const Icon(
                Icons.pin_drop_sharp,
                color: Colors.red,
                size: 32,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
