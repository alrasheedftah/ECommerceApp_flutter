import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class MapScreen extends StatefulWidget {
  static final String id="MapScreen";
  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);



getConfig() async{
  _serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}
_locationData = await location.getLocation();

// setState((){
//   _locationData=_locationData;
// });
    print("Location Data "+_locationData.toString());


     var localData= await location.getLocation();
          setState(() {
            _locationData =localData;
          });

}

getLocation() async {
  await getConfig();
}
  @override
  Widget build(BuildContext context) {
    location.onLocationChanged.listen((LocationData currentLocation) {
  // Use current location
  // _locationData=currentLocation;
  print(currentLocation.latitude);
});
getConfig();
// List<Marker> markers=[
//   Marker(markerId: null,
//     position: _locationData==null?null: LatLng(_locationData.latitude,_locationData.longitude),  
//   ),
// ];

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
    target: LatLng(_locationData!=null?_locationData.latitude: 37.42796133580664,_locationData!=null?_locationData.longitude:-122.085749655962),
    zoom: 14.4746,
  ),//_kGooglePlex,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          var localData= await location.getLocation();
          setState(() {
            _locationData =localData;
          });          
      //     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      // zoom: 19.151926040649414,          
      //      target: LatLng(_locationData.latitude, _locationData.longitude)
          
      //     )));        
        },
        myLocationEnabled: true,
        onCameraMove: (position)  async{
          print("Camera Move "+position.target.latitude.toString());
          var localData= await location.getLocation();
          setState(() {
            _locationData =localData;
            _newPosition=position.target;
          print("_locationData  "+_locationData.latitude.toString());
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
              position: _newPosition??LatLng(_locationData!=null?_locationData.latitude:0,_locationData!=null?_locationData.longitude:0),
              infoWindow: InfoWindow(
                title: "Current Location "
              ),
              onDragEnd: (value){
                setState(() {
                  _newPosition=value;
                });
              },
              draggable: true
            )
        ])
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getCurrentLocation,
        label: Text('Set Bickup'),
        icon: Icon(Icons.directions_boat),
      ),

    );
  }
  LatLng _newPosition=null;
  Future<void> getCurrentLocation() async{
    // await getConfig();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_locationData.latitude,_locationData.longitude),
        zoom: 14.00001  
        )
    ));

    final coordinates = new Coordinates(_locationData.latitude,_locationData.longitude);
var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
var first = addresses.first;
print("${first.featureName} : ${first.addressLine} locality");
// await showDialog(context: context,builder: (_context){
//   return AlertDialog(
//       title: Text("${first.featureName} : ${first.addressLine}"),);
// });
   Navigator.pop(context,first); 

  }

  @override
  void initState() {
    super.initState();
    getConfig();   
    print(_locationData.toString()+"  INit Location Data");
    // getCurrentLocation();
  }


  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}