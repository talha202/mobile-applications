import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_fb_assignment/services/api/weather-api/services_into.dart';
import 'package:get/get.dart';

import '../../../Assignment_3/home_page.dart';
import '../../../Assignment_3/home_page_o_pass_data.dart';

class GeoFunctionCall extends StatefulWidget {
  const GeoFunctionCall({super.key});

  @override
  State<GeoFunctionCall> createState() => _GeoFunctionCallState();
}

class _GeoFunctionCallState extends State<GeoFunctionCall> {
  String? lat, lon;

  //for permision on in API
  static Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.amber,
            child: ElevatedButton(
              child: Text("Get Location "),
              onPressed: () {
                //this is used for to recive value
                getLoca().then((value) {
                  lat = '${value.latitude}';
                  lon = '${value.longitude}';

                  print("\t^^^^^^^^^^^^^inside lat = ${lat}");

                  print("\t^^^^^^^^^^^^^inside lon = ${lon}");

                  Get.to(HomePageDataPass(
                    lat: lat,
                    lon: lon,
                  ));
                });
              },
            )),
      ),
    );
  }
}

Widget PrintNameOfData(dynamic cityName, dynamic temp) {
  return Scaffold(
    body: Center(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.amber,
            child: Text("${cityName}"),
          ),
          SizedBox(
            height: 100,
            width: 100,
          ),
          Container(
            height: 100,
            width: 100,
            color: Color.fromARGB(255, 185, 25, 179),
            child: Text("${temp}"),
          ),
        ],
      ),
    ),
  );
}

Future<Position?> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    }
  } else {
    throw Exception('Error');
  }
  return await Geolocator.getCurrentPosition();
}

Future<Position> getLoca() async {
  //location enable call for the app
  determinePosition();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  var lat = position.latitude;
  var lan = position.longitude;

  dynamic a = WeatherAPiClinet.getCurrentWeather1(lat, lan);

  print("\tLat = ${lat} and \tLan = ${lan}");
  print("\n\tPOSTION METDOD====   ${position}");

  return position;
}
