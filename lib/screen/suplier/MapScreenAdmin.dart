import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class MapScreenAdmin extends StatefulWidget {
  static final String id="MapScreenAdmin";
  @override
  State<MapScreenAdmin> createState() => _MapScreenAdmin();
}

class _MapScreenAdmin extends State<MapScreenAdmin> {


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  LatLng _newPosition;
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);




  @override
  Widget build(BuildContext context) {
  Coordinates _coordinates=ModalRoute.of(context).settings.arguments;
    print(_coordinates.longitude.toString()+"latuei");
    _newPosition=LatLng(_coordinates.latitude,_coordinates.longitude);
 
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
    target: LatLng(_coordinates !=null?_coordinates.latitude: 37.42796133580664,_coordinates !=null?-_coordinates.longitude :-122.085749655962),
    zoom: 14.4746,
  ),//_kGooglePlex,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: _newPosition,
        zoom: 14.00001  
            
            )
          )

          );
        
        },
        myLocationEnabled: true,
        onCameraMove: (position)  async{
          setState(() {
            // _newPosition=position.target;
          });
        },
        onCameraMoveStarted: (){
          // var localData= await location.getLocation();
          // setState(() {
          //   _locationData =localData;
          // });
        },
        markers:Set.of([
            Marker(
              markerId: MarkerId("ana"),
              position: _newPosition??_coordinates,
              infoWindow: InfoWindow(
                title: "Current Location "
              ),
              // onDragEnd: (value){
              //   setState(() {
              //     _newPosition=value;
              //   });
              // },
              // draggable: true
            )
        ])
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    // getCurrentLocation();
  }



}