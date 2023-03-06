import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/contants.dart';

import '../../Controller/user_outputs.dart';
class MapUserScreen extends StatefulWidget {
  const MapUserScreen({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapUserScreen> {

  static const CameraPosition initialLocation = CameraPosition(
    target: LatLng(31.037933, 31.381523),
    zoom: 10.4746,
  );
  late Marker marker = Marker(
      markerId: MarkerId("home"),
      position: LatLng(initialLocation.target.latitude , initialLocation.target.longitude),
      draggable:  false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5, 0.5),

  );
  StreamSubscription? _locationSubscription ;
  late Circle circle = Circle(
      circleId: CircleId("car"),
      zIndex: 1,
      strokeColor: Color(0xffF7B16E),
      center:  LatLng(initialLocation.target.latitude , initialLocation.target.longitude),
      fillColor: Colors.blue.withAlpha(70));
  late Position trackedLocation;
  late GoogleMapController _controller;
  LatLng? currentLocationLatLng;
  bool isLive = false;
  // Position _locationTracker = Location();
  var positionStream ;
  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }
  Future<void> getCurrentLocation() async {
    print("getting current location ....");
    try {
      Uint8List imageData = await getMarker();
      // var location = await _locationTracker.getLocation();
      positionStream = Geolocator.getPositionStream().
      listen(
              (Position? position) {
            print("new location");
            print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
            trackedLocation = position!;
            _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(position.latitude, position.longitude),
                tilt: 0,
                zoom: 18.00)));

            updateMarkerAndCircle(position, imageData);
            print(trackedLocation);
            setState(() {

            });
          });




      // if (_locationSubscription != null) {
      //   _locationSubscription.cancel();
      // }



    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        return  debugPrint("Permission Denied");
      }
    }

  }
  void updateMarkerAndCircle(Position position, Uint8List imageData) {
    // LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
  if(mounted) {
    setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: LatLng(position.latitude , position.longitude),
          draggable:  false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          zIndex: 1,
          strokeColor: Color(0xffF7B16E),
          center: LatLng(position.latitude , position.longitude),
          fillColor: Colors.blue.withAlpha(70));
    });
  }
    print("markers updated");
  }
  LatLng initialLatlng = LatLng(31.037933, 31.381523);
  void initialMarkerAndCircle(LatLng latlng) async{
    // LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    Uint8List imageData = await getMarker() ;
 if(mounted) {
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
 }
 setState(() {

 });
    print("markers updated");
  }
    LatLng? currentPostion ;

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      initialMarkerAndCircle(currentPostion!  );
    });

  }
  @override
  void initState() {

    // getCurrentLocation();
    _getUserLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 150,
                child: currentPostion == null || currentPostion == "" ? Text ("Loading") :GoogleMap(

                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: currentPostion! ,
                    zoom: 10,
                  ),
                  markers:    Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  onTap: (LatLng latLng) async{
                    // isLive = false;
                    // if(_locationSubscription != null){
                    //   _locationSubscription!.cancel();
                    // }

                    final lat = latLng.latitude;
                    final long = latLng.longitude;
                    print(latLng);
                    print("====================== $lat");
                    print("====================== $long");

                    Uint8List imageData = await getMarker();

                    updateMarkerAndCircle(
                        Position(
                            longitude: latLng.longitude,
                            latitude: latLng.latitude,
                            timestamp: DateTime.now(),
                            accuracy: 1.0,
                            altitude: 1.0,
                            heading: 1.0,
                            speed: 1.0,
                            speedAccuracy: 1.0
                        ) , imageData);
                    if(isLive){
                      print("yes is live $isLive");
                      Provider.of<UserOutputs>(context, listen: false).assignClientLocation(currentLocationLatLng!);
                    } else {
                      Provider.of<UserOutputs>(context, listen: false).assignClientLocation(latLng);

                    }




                  },
                ),
              ),
//               IconButton(
//                 color: Colors.red,
// iconSize: 66.0,
//                 onPressed: (){
//                  getCurrentLocation();
//               }, icon: CircleAvatar(
//                 radius: 66,
//
//                 child: Icon(Icons.location_on , color: Colors.white, size: 33,),
//                 backgroundColor: Colors.red,
//               ))
            ],
          ),
          SizedBox(height: 25,),
          Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(100.w , 60.h)),
                    backgroundColor: MaterialStateProperty.all(AppColors().defaultColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33)
                    ))
                ),
                onPressed: (){
                  if(isLive){
                    Provider.of<UserOutputs>(context, listen: false).assignClientLocation(currentLocationLatLng!);
                    Provider.of<UserOutputs>(context , listen: false).assignLocationState();
                    Provider.of<UserOutputs>(context , listen: false).transformToLocationName();
                    Navigator.of(context).pop();
                  } else {

                    Provider.of<UserOutputs>(context , listen: false).assignLocationState();
                    Provider.of<UserOutputs>(context , listen: false).transformToLocationName();
                    Navigator.of(context).pop();
                  }


                }, child: Text("Select Your Location" , style: TextStyle(fontSize: 22.sp),) ,),
              SizedBox(height: 5,),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(60.w , 40.h)),
                    backgroundColor: MaterialStateProperty.all(Colors.grey[500]),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33)
                    ))
                ),
                onPressed: (){
                  TextEditingController latController = TextEditingController();
                  TextEditingController lngController = TextEditingController();

                  showDialog(context: context, builder: (_)=> Material(
                    child: Container(
                      width: 250.w,
                      height: 250.h,
                      child: Column(
                        children: [
                          SizedBox(height: 55.h,),
                          Row(children: [
                            Text("Lat :" , style: TextStyle(fontSize: 15.sp),),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextFormField(
                                controller: latController,
                              ),
                            )
                          ],),
                          SizedBox(height: 25,),

                          Row(children: [
                            Text("Lng : " , style: TextStyle(fontSize: 15.sp),),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextFormField(
                                controller: lngController,
                              ),
                            )
                          ],),
                          SizedBox(height: 35,),
                          ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(100.w , 60.h)),
                                backgroundColor: MaterialStateProperty.all(AppColors().defaultColor),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(33)
                                ))
                            ),
                            onPressed: (){

                              if(latController.text.isNotEmpty && lngController.text.isNotEmpty){
                                double lat = double.parse(latController.text);
                                double lng = double.parse(lngController.text);
                                LatLng latLng = LatLng(lat, lng);
                                Provider.of<UserOutputs>(context, listen: false).assignClientLocation(latLng);
                                Provider.of<UserOutputs>(context , listen: false).assignLocationState();
                                Provider.of<UserOutputs>(context , listen: false).transformToLocationName();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              } else {
                                const sanckBar =  SnackBar(content: Text("Please Fill Lat and Lng First"),
                                duration: Duration(seconds: 2),);
                                ScaffoldMessenger.of(context).showSnackBar(sanckBar);
                              }


                            }, child: Text("Ok" , style: TextStyle(fontSize: 22.sp),) ,),
                        ],
                      ),
                    ),
                  ));
                  // Provider.of<UserOutputs>(context , listen: false).assignLocationState();
                  // Provider.of<UserOutputs>(context , listen: false).transformToLocationName();
                  // Navigator.of(context).pop();

                }, child: Text("Enter Manually" , style: TextStyle(fontSize: 22.sp),) ,),
            ],
          )
        ],
      ),

    );
  }
  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }

    super.dispose();
  }
}
