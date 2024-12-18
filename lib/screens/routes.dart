import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'page2.dart';

class PastLocationDetailsPage extends StatefulWidget {
  final Member member;
  final PastLocation pastLocation;

  const PastLocationDetailsPage({
    Key? key,
    required this.member,
    required this.pastLocation,
  }) : super(key: key);

  @override
  _PastLocationDetailsPageState createState() => _PastLocationDetailsPageState();
}

class _PastLocationDetailsPageState extends State<PastLocationDetailsPage> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

  void _initializeMapData() {
    // Create markers for initial position and past location
    _markers.add(
      Marker(
        markerId: MarkerId('initial_position'),
        position: LatLng(widget.member.location.latitude, widget.member.location.longitude),
        infoWindow: InfoWindow(title: 'Current Location'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('past_location'),
        position: LatLng(widget.pastLocation.latitude, widget.pastLocation.longitude),
        infoWindow: InfoWindow(title: widget.pastLocation.name),
      ),
    );

    // Create polyline between initial position and past location
    _polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blue,
        width: 5,
        points: [
          LatLng(widget.member.location.latitude, widget.member.location.longitude),
          LatLng(widget.pastLocation.latitude, widget.pastLocation.longitude),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Location Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.member.location.latitude, widget.member.location.longitude),
                zoom: 12,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0), // Add vertical and horizontal padding for space around the container
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            // Section Title: Member Details
            Text(
              'Member Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5C3DC2),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            // Member Name
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.member.name ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Member ID
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.member.id ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 40,
              thickness: 1.2,
              color: Colors.grey,
            ),
            // Section Title: Past Location Details
            Text(
              'Past Location Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5C3DC2),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            // Past Location Name
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.pastLocation.name ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Entry Time
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Entry Time: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.pastLocation.entryTime ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Exit Time
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exit Time: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.pastLocation.exitTime ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
),
        ],
      ),
    );
  }
}

