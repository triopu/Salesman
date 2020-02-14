import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerMap extends StatefulWidget {
  @override
  _CustomerMapState createState() => _CustomerMapState();
}

class _CustomerMapState extends State<CustomerMap> {
  Completer <GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(-7.5767206,110.8149);
  LatLng _lastMapPosition = _center;
  final Set<Marker> _markers = {};
  String currentLat = '';
  String currentLong = '';

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  void _handleTap(LatLng point){
    setState(() {
      currentLat = point.latitude.toString();
      currentLong = point.longitude.toString();
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: "Marked",
        ),
        icon: BitmapDescriptor.defaultMarker
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            initialCameraPosition: CameraPosition(
                target: LatLng(-7.5767206,110.8149206),
                zoom: 11.0
            ),
            onTap: _handleTap,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.pop(context,[currentLat,currentLong]);
                },
                child: Icon(Icons.control_point,size: 36,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
