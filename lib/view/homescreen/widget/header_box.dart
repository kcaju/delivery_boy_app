import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderBox extends StatefulWidget {
  const HeaderBox({super.key, this.onMenuTap, this.onDropdownSelection});
  final void Function()? onMenuTap;
  final void Function(int)? onDropdownSelection;

  @override
  State<HeaderBox> createState() => _HeaderBoxState();
}

class _HeaderBoxState extends State<HeaderBox> {
  String profileUrl = "";
  String userName = "STAFF"; // Default value
  bool isLoading = true; // To handle loading state

  Future<void> fetchUserData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

      if (uid.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Partners')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            profileUrl = userDoc['url'] ?? ""; // Profile image URL
            userName = userDoc['name'] ?? "STAFF"; // Name field
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Container(
      height: screenHeight * 0.07,
      child: Row(
        children: [
          Row(
            children: [
              //titlebox
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 2 : 6, horizontal: isMobile ? 15 : 45),
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text(
                        "Go",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: isMobile ? 25 : 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "mart",
                        style: TextStyle(
                            color: Color(0xFF03AC13),
                            fontSize: isMobile ? 25 : 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: widget.onMenuTap,
                child: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Spacer(),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage:
                    profileUrl.isNotEmpty ? NetworkImage(profileUrl) : null,
                radius: isMobile ? 18 : 20,
              ),
              SizedBox(
                width: 5,
              ),
              PopupMenuButton<int>(
                child: Row(
                  children: [
                    Text(
                      userName.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: isDesktop ? 25 : 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                onSelected:
                    widget.onDropdownSelection, //dropdown selection press
                itemBuilder: (context) => [
                  // PopupMenuItem(
                  //   value: 1,
                  //   child: Text(
                  //     "Change Password",
                  //     style: TextStyle(
                  //         color: Colors.black, fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
                offset: Offset(0, 50), // Adjusts the popup position
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xFF03AC13),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                15,
              ),
              topRight: Radius.circular(15))),
    );
  }
}
