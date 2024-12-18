import 'package:flutter/material.dart';
import '../models/member.dart';
import '../screens/page1.dart';
import '../screens/page2.dart';

class MemberTile extends StatelessWidget {
  final Member member;

  const MemberTile({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: isSmallScreen ? 24 : 32,
                    backgroundImage: NetworkImage(member.avatarUrl),
                    backgroundColor: Colors.grey.shade200,
                    child: member.avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 32, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  // Member Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 16 : 18,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          member.id,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: member.status == "WORKING"
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            member.status,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: member.status == "WORKING"
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.login,
                                    size: 16, color: Colors.blueGrey),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'Login: ${member.loginTime}',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 10 : 12,
                                      color: Colors.blueGrey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.logout,
                                    size: 16, color: Colors.blueGrey),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'Logout: ${member.logoutTime}',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 10 : 12,
                                      color: Colors.blueGrey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Action Buttons
              isSmallScreen
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GoogleMapScreen(member: member)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(12),
                          ),
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'Schedule',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExpandableMapPage(member: member)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(12),
                          ),
                          icon: const Icon(
                            Icons.my_location,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'Locate',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GoogleMapScreen(member: member)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(12),
                          ),
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'Schedule',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExpandableMapPage(member: member)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(12),
                          ),
                          icon: const Icon(
                            Icons.my_location,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'Locate',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
