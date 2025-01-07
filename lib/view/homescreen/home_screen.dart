import 'package:delivery_boy_app/view/homescreen/widget/dashboard_cards.dart';
import 'package:delivery_boy_app/view/homescreen/widget/header_box.dart';
import 'package:delivery_boy_app/view/homescreen/widget/neworders_box.dart';
import 'package:delivery_boy_app/view/homescreen/widget/previousorder_box.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMenuExpand = true;
  bool isDashbord = true;
  bool isPreviousOrder = false;
  bool isNewOrder = false;
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        //main container
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header section
              HeaderBox(
                onMenuTap: () {
                  setState(() {
                    isMenuExpand = !isMenuExpand;
                    isDashbord = false;
                    isPreviousOrder = false;
                    isNewOrder = false;
                  });
                },
              ),
              //main contents
              isDesktop
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //main sections :dashboard,new orders,previous orders
                        Container(
                          width: isMenuExpand ? (isDesktop ? 210 : null) : (80),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Main",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDashbord = true;
                                        isNewOrder = false;
                                        isPreviousOrder = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.speed,
                                          color: isDashbord
                                              ? Colors.green
                                              : Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        isMenuExpand
                                            ? Text(
                                                "Dashboard",
                                                style: TextStyle(
                                                    color: isDashbord
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //neworders
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isNewOrder = true;
                                        isPreviousOrder = false;
                                        isDashbord = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.speed,
                                          color: isNewOrder
                                              ? Colors.green
                                              : Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        isMenuExpand
                                            ? Text(
                                                "New Orders",
                                                style: TextStyle(
                                                    color: isNewOrder
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //previousorder
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPreviousOrder = true;
                                        isNewOrder = false;
                                        isDashbord = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.speed,
                                          color: isPreviousOrder
                                              ? Colors.green
                                              : Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        isMenuExpand
                                            ? Text(
                                                "Previous Orders",
                                                style: TextStyle(
                                                    color: isPreviousOrder
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200)),
                        ),
                        //changing contents box

                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isPreviousOrder
                                  ? PreviousorderBox()
                                  : isNewOrder
                                      ? NewordersBox()
                                      : isDashbord
                                          ? DashboardCards()
                                          : SizedBox()
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200)),
                        ))
                      ],
                    )
                  : //other devices
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Column(
                            children: [
                              isMenuExpand
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Main",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isDashbord = true;
                                                isNewOrder = false;
                                                isPreviousOrder = false;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.speed,
                                                  color: isDashbord
                                                      ? Colors.green
                                                      : Colors.grey.shade700,
                                                  size: 28,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Dashboard",
                                                  style: TextStyle(
                                                      color: isDashbord
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //neworders
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isNewOrder = true;
                                                isPreviousOrder = false;
                                                isDashbord = false;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.speed,
                                                  size: 28,
                                                  color: isNewOrder
                                                      ? Colors.green
                                                      : Colors.grey.shade700,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "New Orders",
                                                  style: TextStyle(
                                                      color: isNewOrder
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //previousorder
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isPreviousOrder = true;
                                                isNewOrder = false;
                                                isDashbord = false;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.speed,
                                                  size: 28,
                                                  color: isPreviousOrder
                                                      ? Colors.green
                                                      : Colors.grey.shade700,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Previous Orders",
                                                  style: TextStyle(
                                                      color: isPreviousOrder
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Main",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              //changing contents
                              isPreviousOrder
                                  ? PreviousorderBox()
                                  : isDashbord
                                      ? DashboardCards()
                                      : isNewOrder
                                          ? NewordersBox()
                                          : SizedBox()
                            ],
                          )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200)),
                    )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
