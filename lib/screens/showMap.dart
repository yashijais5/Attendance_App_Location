import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MembersMapPage extends StatefulWidget {
  @override
  _MembersMapPageState createState() => _MembersMapPageState();
}
class _MembersMapPageState extends State<MembersMapPage> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  List<dynamic> _members = [];
  bool _showListView = false;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    try {
      String jsonString = await rootBundle.loadString('../assets/members.json');
      setState(() {
        _members = json.decode(jsonString);
        _createMarkers();
      });
    } catch (e) {
      print('Error loading members: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load member data')),
      );
    }
  }

  void _createMarkers() {
    _markers = _members.map((member) {
      return Marker(
        markerId: MarkerId(member['id']),
        position: LatLng(member['location']['latitude'], member['location']['longitude']),
        infoWindow: InfoWindow(
          title: member['name'],
          snippet: '${member['status']} - ${member['location']['name']}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          member['status'] == 'WORKING' ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATTENDANCE'),
        backgroundColor: Color(0xFF6E56CF),
       
      ),
      body: _showListView ? _buildListView() : _buildMapView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _showListView = !_showListView;
          });
        },
        label: Text(_showListView ? 'Show Map' : 'Show List view'),
        icon: Icon(_showListView ? Icons.map : Icons.list),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMapView() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(26.8467, 80.9462), // Centered on Lucknow
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      markers: _markers,
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _members.length,
      itemBuilder: (context, index) {
        final member = _members[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member['avatar_url']),
          ),
          title: Text(member['name']),
          subtitle: Text('${member['status']} - ${member['location']['name']}'),
          trailing: Text('${member['login_time']} - ${member['logout_time']}'),
        );
      },
    );
  }
}

