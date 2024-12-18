import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart';

class GoogleMapScreen extends StatefulWidget {
  final Member member;

  const GoogleMapScreen({Key? key, required this.member}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _controller;
  late LatLng _initialPosition;
  late Marker _marker;

  @override
  void initState() {
    super.initState();
    _initialPosition = LatLng(widget.member.location.latitude, widget.member.location.longitude);
    _marker = Marker(
      markerId: MarkerId(widget.member.id),
      position: _initialPosition,
      infoWindow: InfoWindow(
        title: widget.member.name,
        snippet: widget.member.location.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.member.name}\'s Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 15,
        ),
        markers: {_marker},
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
