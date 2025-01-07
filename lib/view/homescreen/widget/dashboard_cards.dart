import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return isMobile
        ? Column(
            children: [
              //total order card
              Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 140,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "98",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Orders",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //orders today card
              Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 140,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "1072",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 100,
                        child: Text(
                          "orders-today",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200)),
                ),
              ),
            ],
          ) //other devices
        : Row(
            mainAxisAlignment:
                isTablet ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              //total order card
              Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 140,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "98",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Orders",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200)),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              //orders today card
              Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 140,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "1072",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 100,
                        child: Text(
                          "orders-today",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200)),
                ),
              ),
            ],
          );
  }
}
