import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geolocator/geolocator.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/main_page_rep.dart';

import '../../contants.dart';
import '../Rep.sales_Widgets/custom_rep_home_list_item.dart';
import 'apply_and_report_order_screen.dart';


class TrackLocation extends StatefulWidget {
  const TrackLocation({Key? key, required this.latitude, required this.longtitude, required this.clientName}) : super(key: key);
  final String clientName;
  final title = 'maps';
  final double latitude;
  final double longtitude;


  @override
  State<TrackLocation> createState() => _MapScreenState();
}
Timer? timer;
class _MapScreenState extends State<TrackLocation> {
  // late StreamSubscription _locationSubscription;

  // final Location _locationTracker = Location();

  late final LocationSettings locationSettings ;
  late StreamSubscription<Position> positionStream ;

  Marker marker = const Marker(markerId: MarkerId("start")) ;
  Circle circle = const Circle(circleId: CircleId("start"));
  late GoogleMapController _controller;
  bool isCurrentLocation = false;
  bool isSaving = false;
  List<LatLng> _savedLocations = [];
  List<LatLng> _currentLocations = [];

  late Position trackedLocation;
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(31.037933, 31.381523),
    zoom: 8.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }
  void updateMarkerAndCircle(Position newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
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




  void initialMarkerAndCircle(LatLng latlng) async{
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
  LatLng initialLatlng = LatLng(31.037933, 31.381523);

  @override
  void initState() {
    // timer = Timer.periodic(Duration(seconds: 7), (Timer t) => getCurrentLocation());

    locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 100,
    );
    // positionStream = Geolocator.getPositionStream(locationSettings: locationSettings);
    getCurrentLocation();


    super.initState();
  }



  @override
  void dispose() {
    timer?.cancel();
    positionStream.cancel();
    // _locationSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: EdgeInsets.only(right: 25),
            child:   Visibility(
                visible: isCurrentLocation,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: const [
                      Text("Location Tracker "),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 5,
                      )
                    ],
                  ),)),
          ),
          InkWell(
            child:   Padding(padding: EdgeInsets.all(8.0),
              child: Container(),
            ),
            onTap: (){

            },
          ),



        ],
        title: Text(widget.title),
        backgroundColor: AppColors().defaultColor,
      ),

      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: double.infinity,
                child: GoogleMap(

                  mapType: MapType.hybrid,
                  initialCameraPosition:  initialLocation,
                  markers: Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
              InkWell(
                onTap: () async {



                },
                child: SizedBox(
                  width: 180.w,
                  height: 65.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors().defaultColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.r))),
                    ),
                    onPressed: () async {

                      await showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Deliver"),
                          content: const Text("Are You sure ?"),
                          actions: <Widget>[

                            CupertinoDialogAction(
                                child: const Text("Yes"),
                                onPressed: () async{
                                  print("preaaed yes");
                                  print("tracked location ${trackedLocation.latitude} , ${trackedLocation.longitude} ");
                                  print("widget location ${widget.latitude} , ${widget.longtitude} ");

                                  print("this is wodget lat ${widget.latitude}" );
                                  var distance =  Geolocator.distanceBetween(
                                      trackedLocation.latitude,
                                      trackedLocation.longitude,
                                      widget.latitude
                                      , widget.longtitude);
                                  print("this is the distace ${distance}");
                                  // Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> ApplyAndReportOrderScreen(clientName: widget.clientName,)));

                                  if(distance < 100.00 ){
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Row(
                                        children: const [
                                          Text("Deliverd Succefully",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,),
                                          SizedBox(width: 10,),
                                          Icon(CupertinoIcons.check_mark_circled_solid , color: Colors.green,)
                                        ],
                                      ),
                                      duration: Duration(seconds: 2),
                                    ));
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_)=> ApplyAndReportOrderScreen(clientName: widget.clientName,)));

                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text("Please Reach the Destination",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,),
                                      duration: Duration(seconds: 2),
                                    ));


                                  }


                                  Navigator.of(context).pop(false);
                                }
                            ),
                            CupertinoDialogAction(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop(true);

                      }
                            ),
                          ],
                        ),
                      );

                    },
                    child: Text(
                        "Deliver Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),

              )

            ],
          ),

        ],

      ),

    );
  }
}

