import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices extends StatefulWidget {
  const LocationServices({super.key});

  @override
  State<LocationServices> createState() => _LocationServicesState();
}

class _LocationServicesState extends State<LocationServices> {

  getCurrentLocation()async {
      LocationPermission permission = await Geolocator.checkPermission();

      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        log("Location Denied");
        LocationPermission ask = await Geolocator.requestPermission();
      } else {
        Position currentPosition =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        log("Latitude = ${currentPosition.latitude.toString()}");
        log("longitude = ${currentPosition.longitude.toString()}");

        var mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}';
        // Print the constructed URL to the log
        log("Maps URL: $mapsUrl");
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Location"),
        centerTitle: true,
      ),
      body: Center(child: ElevatedButton(onPressed: (){
       getCurrentLocation();
      }, child: Text("Grab Location"),)),
    );
  }
}



