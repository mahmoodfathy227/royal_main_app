import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/contants.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {

  static const CameraPosition initialLocation = CameraPosition(
    target: LatLng(31.037933, 31.381523),
    zoom: 10.4746,
  );
  late Marker marker;
  late Circle circle;
  late GoogleMapController _controller;

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LatLng latlng, Uint8List imageData) {
    // LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          draggable:  false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          zIndex: 1,
          strokeColor: Color(0xffF7B16E),
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
    print("markers updated");
  }
  LatLng initialLatlng = LatLng(31.037933, 31.381523);
  void initialMarkerAndCircle(LatLng latlng) async{
    // LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    Uint8List imageData = await getMarker() ;
    setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          draggable:  false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          zIndex: 1,
          strokeColor: Color(0xffF7B16E),
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
    print("markers updated");
  }

  @override
  void initState() {
    initialMarkerAndCircle(initialLatlng  );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 150,
            child: GoogleMap(

              mapType: MapType.hybrid,
              initialCameraPosition: initialLocation,
              markers:    Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              onTap: (LatLng latLng) async{
                final lat = latLng.latitude;
                final long = latLng.longitude;
                print(latLng);
                print("====================== $lat");
                print("====================== $long");

                Uint8List imageData = await getMarker();

                updateMarkerAndCircle(latLng , imageData);
                Provider.of<TaskOutputs>(context, listen: false).assignClientLocation(latLng);




              },
            ),
          ),
          SizedBox(height: 25,),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(100.w , 60.h)),
              backgroundColor: MaterialStateProperty.all(AppColors().defaultColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33)
              ))
            ),
              onPressed: (){
            Provider.of<TaskOutputs>(context , listen: false).assignLocationState();
            Provider.of<TaskOutputs>(context , listen: false).transformToLocationName();
            Navigator.of(context).pop();

          }, child: Text("Select" , style: TextStyle(fontSize: 22.sp),) ,)
        ],
      ),
    );
  }
}
