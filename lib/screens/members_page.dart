import 'package:flutter/material.dart';

void main() => runApp(const MembersApp());

class MembersApp extends StatelessWidget {
  const MembersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MembersPage(),
    );
  }
}

class MembersPage extends StatelessWidget {
   MembersPage({super.key});

//   late SharedPreferences sp;
//   getSharedPrefrences() async{
//     sp= await SharedPreferences.getInstance();
//   }
//   @override
//   void initState(){
//     getSharedPrefrences();
//   }
//   saveIntoSp(){
// // 
//   }
//   readFromSp()
//   {

//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context); // Navigates back to the previous page.
            },
          ),
          title: const Text("MEMBERS"),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Icon(Icons.group, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "All Members",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      buildMemberTile("Mohit Malik", "assets/avatar1.jpg"),
                      Divider(),
                      buildMemberTile("Nitesh Pandey", "assets/avatar2.jpg"),
                      Divider(),
                      buildMemberTile("Vishad Sharma", "assets/avatar3.jpg"),
                      Divider(),
                      buildMemberTile(
                          "Vinove Kumar Shukla", "assets/avatar4.jpg"),
                      Divider(),
                      buildMemberTile("Maneesh Malhotra", "assets/avatar5.jpg"),
                      Divider(),
                      buildMemberTile("Elizabeth Swann", "assets/avatar6.jpg"),
                      Divider(),
                      buildMemberTile("Robert Downey", null),
                      Divider(),
                      buildMemberTile(
                          "Francis Diakowsky", "assets/avatar7.jpg"),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
                            .split("")
                            .map((letter) => Text(
                                  letter,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.blue),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMemberTile(String name, String? avatarPath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        backgroundImage: avatarPath != null ? AssetImage(avatarPath) : null,
        child: avatarPath == null
            ? const Icon(Icons.person, color: Colors.blue)
            : null,
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
