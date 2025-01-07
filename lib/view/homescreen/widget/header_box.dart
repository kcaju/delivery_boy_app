import 'package:flutter/material.dart';

class HeaderBox extends StatefulWidget {
  const HeaderBox({super.key, this.onMenuTap});
  final void Function()? onMenuTap;

  @override
  State<HeaderBox> createState() => _HeaderBoxState();
}

class _HeaderBoxState extends State<HeaderBox> {
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
                    vertical: 6, horizontal: isMobile ? 15 : 45),
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
                radius: isMobile ? 18 : 20,
              ),
              SizedBox(
                width: 5,
              ),
              PopupMenuButton<int>(
                child: Row(
                  children: [
                    Text(
                      "STAFF",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: isDesktop ? 25 : 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                onSelected: (value) {
                  // Handle any selection if required
                  // if (value == 1) {
                  //   //Navigate to the Sign In screen
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SigninScreen()),
                  //   );
                  // } else if (value == 2) {
                  //   // Navigate to the Sign Up screen
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SignupScreen()),
                  //   );
                  // }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ),
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
