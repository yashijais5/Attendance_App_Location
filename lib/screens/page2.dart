import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart'; // Assuming this is the provided member.dart
import 'dart:convert'; // For JSON decoding
import 'package:flutter/services.dart'; // For loading assets
import 'routes.dart';

class ExpandableMapPage extends StatefulWidget {
  final Member member;

  const ExpandableMapPage({Key? key, required this.member}) : super(key: key);

  @override
  _ExpandableMapPageState createState() => _ExpandableMapPageState();
}

class _ExpandableMapPageState extends State<ExpandableMapPage> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition;
  late Marker _marker;
  bool _isFullScreen = false;

  List<PastLocation> _pastLocations = [];

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

    _loadPastLocations();
  }

  /* Future<void> _loadPastLocations() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/members.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Find the matching member from the JSON data
      final memberData = jsonData.firstWhere((data) => data['id'] == widget.member.id);

      // Parse `past_location` from the JSON data
      final List<dynamic> pastLocationData = memberData['past_location'] ?? [];

      setState(() {
        _pastLocations = pastLocationData.map((data) => PastLocation.fromJson(data)).toList();
      });
    } catch (e) {
      print('Error loading past locations: $e');
    }
  } */

Future<void> _loadPastLocations() async {
  try {
    // Load the members JSON file as a string from assets
    final String jsonString = await rootBundle.loadString('assets/members.json');
    
    // Decode the JSON string into a list of dynamic objects
    final List<dynamic> jsonData = jsonDecode(jsonString);

    // Find the matching member using the member's ID from the widget
    final memberData = jsonData.firstWhere(
      (data) => data['id'] == widget.member.id,
      orElse: () => null, // Added to handle case where member is not found
    );

    if (memberData == null) {
      // Handle case where the member is not found in the JSON data
      print('Member not found');
      return;
    }

    // Parse the 'past_location' data or default to an empty list if not found
    final List<dynamic> pastLocationData = memberData['past_location'] ?? [];

    // Update the state with the parsed list of past locations
    setState(() {
      _pastLocations = pastLocationData
          .map((data) => PastLocation.fromJson(data))
          .toList();
    });
  } catch (e) {
    // Catch and log any errors that occur during the loading or parsing process
    print('Error loading past locations: $e');
  }
}







  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  void _navigateToPastLocationDetails(PastLocation location) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PastLocationDetailsPage(
          member: widget.member,
          pastLocation: location,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${widget.member.name}\'s Location',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Map View
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isFullScreen
                ? 0
                : MediaQuery.of(context).size.height * 0.6,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 13,
              ),
              markers: {_marker},
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),






          // Expandable Bottom View
        /*  Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: _toggleFullScreen,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isFullScreen
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_isFullScreen ? 0 : 30),
                    topRight: Radius.circular(_isFullScreen ? 0 : 30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _pastLocations.length,
                        itemBuilder: (context, index) {
                          PastLocation loc = _pastLocations[index];
                          return InkWell(
                            onTap: () => _navigateToPastLocationDetails(loc),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  loc.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  'Entry: ${loc.entryTime}\nExit: ${loc.exitTime}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), */


        Align(
  alignment: Alignment.bottomCenter,
  child: GestureDetector(
    onTap: _toggleFullScreen,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _isFullScreen
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_isFullScreen ? 0 : 20),
          topRight: Radius.circular(_isFullScreen ? 0 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50], // Light background for the list items
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                itemCount: _pastLocations.length,
                itemBuilder: (context, index) {
                  PastLocation loc = _pastLocations[index];
                  return InkWell(
                    onTap: () => _navigateToPastLocationDetails(loc),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  title: Row(
    children: [
      Icon(
        Icons.location_on, // Location icon
        color: Colors.redAccent,
        size: 20,
      ),
      SizedBox(width: 8), // Space between the icon and the text
      Text(
        loc.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5C3DC2),
        ),
      ),
    ],
  ),
                        subtitle: Text(
                          'Entry: ${loc.entryTime}\nExit: ${loc.exitTime}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),











        ],
      ),
    );
  }
}


