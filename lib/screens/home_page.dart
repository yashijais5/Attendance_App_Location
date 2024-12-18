import 'package:flutter/material.dart';

import 'attendance_page.dart';
import '../widgets/drawer_item.dart';
import '../screens/attendance_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDrawerOpen = true;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Container(
            color: const Color.fromARGB(255, 246, 246, 249),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    color: const Color(0xFF5C3DC2), // Updated background color
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: _toggleDrawer,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content Cards
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              'Item ${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text('Details about item ${index + 1}'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Navigation Drawer
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: _isDrawerOpen ? 0 : -280,
            top: 0,
            bottom: 0,
            width: 280,
            child: NavigationDrawer(onCloseDrawer: _toggleDrawer),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final VoidCallback onCloseDrawer;

  const NavigationDrawer({Key? key, required this.onCloseDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: Container(
        width: 280,
        color: Colors.white,
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
              decoration: BoxDecoration(
                image:DecorationImage(image: NetworkImage('https://img.freepik.com/free-vector/paper-style-dynamic-lines-background_23-2149008629.jpg'),
                fit:BoxFit.cover)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_filled, color: Colors.white, size: 28),
                          SizedBox(width: 5),
                          Text(
                            'workstatus',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://flyerwiz.app/profile-picture-maker/assets/image/male.png'
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cameron Williamson',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'cameronwilliamson@gmail.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 1),
                children: [
                  DrawerItem(
                    icon: Icons.timer_outlined,
                    title: 'Timer',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Timer Selected')),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Attendance',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AttendancePage()),
                      );
                    },
                  ),
                  DrawerItem(icon: Icons.trending_up_outlined, title: 'Activity'),
                  DrawerItem(icon: Icons.access_time_outlined, title: 'Timesheet'),
                  DrawerItem(icon: Icons.bar_chart_outlined, title: 'Report'),
                  DrawerItem(icon: Icons.place_outlined, title: 'Jobsite'),
                  DrawerItem(icon: Icons.group_outlined, title: 'Team'),
                  DrawerItem(icon:Icons.flight_outlined, title: 'Time Off'),
                  DrawerItem(icon: Icons.schedule_outlined, title: 'Schedules'),
                  DrawerItem(
                    icon: Icons.group_add_outlined,
                    title: 'Request to Join Organization',
                  ),
                  SizedBox(height: 10),
                  Divider(height: 1),
                  SizedBox(height: 10),
                  DrawerItem(icon: Icons.lock_outline, title: 'Change Password'),
                  DrawerItem(icon: Icons.logout_outlined, title: 'Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
