import 'package:delivery_boy_app/view/changepassword_screen/changepassword_screen.dart';
import 'package:delivery_boy_app/view/homescreen/widget/custom_drawer.dart';
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
  bool isDashbord = false;
  bool isPreviousOrder = false;
  bool isNewOrder = false;
  bool isChangePassword = false;
  // GlobalKey for Scaffold to control the Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Open the drawer when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.openDrawer();
    });
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: CustomDrawer(
          onDashboardTap: () {
            setState(() {
              isDashbord = true;
              isNewOrder = false;
              isChangePassword = false;
              isPreviousOrder = false;
            });
            Navigator.pop(context);
          },
          onNewOrderTap: () {
            setState(() {
              isNewOrder = true;
              isPreviousOrder = false;
              isChangePassword = false;
              isDashbord = false;
            });
            Navigator.pop(context);
          },
          onPreviousOrderTap: () {
            setState(() {
              isPreviousOrder = true;
              isDashbord = false;
              isChangePassword = false;
              isNewOrder = false;
            });
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          //main container
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header section
                Builder(builder: (context) {
                  return HeaderBox(
                    onDropdownSelection: (p0) {
                      if (p0 == 1) {
                        setState(() {
                          isChangePassword = true;
                          isDashbord = false;
                          isPreviousOrder = false;
                          isNewOrder = false;
                        });
                      }
                    },
                    onMenuTap: () {
                      // Close the drawer programmatically
                      if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
                        Navigator.pop(context); // Close the drawer
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                      setState(() {
                        isDashbord = false;
                        isPreviousOrder = false;
                        isNewOrder = false;
                        isChangePassword = false;
                      });
                    },
                  );
                }),
                //main contents
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isPreviousOrder
                              ? PreviousorderBox()
                              : isNewOrder
                                  ? NewordersBox()
                                  : isDashbord
                                      ? DashboardCards()
                                      : isChangePassword
                                          ? ChangepasswordScreen()
                                          : SizedBox()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }
}
