import 'package:delivery_boy_app/view/homescreen/home_screen.dart';
import 'package:delivery_boy_app/view/loginscreen/widget/customtextformfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;

    TextEditingController uname = TextEditingController();
    TextEditingController password = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 430,
            width: 500,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Go",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "mart",
                        style: TextStyle(
                            color: Color(0xFF03AC13),
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Username:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Customtextformfield(hintText: "", controller: uname),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Password:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Customtextformfield(hintText: "", controller: password),
                  SizedBox(
                    height: 25,
                  ),
                  //login button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 80,
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade200)),
          ),
        ),
      ),
    );
  }
}
