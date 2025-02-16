import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
//get total orders
    Stream<int> totalOrdersStream() {
      String userId =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID
      return FirebaseFirestore.instance
          .collection('totalOrders') // Collection name
          .doc(userId) // User-specific document
          .snapshots() // Get real-time updates
          .map((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          return snapshot['totalOrders'] ??
              0; // Return totalOrders or default to 0
        } else {
          return 0; // Default if document doesn't exist
        }
      });
    }

    //get todays order count
    Stream<int> deliveryItemsLengthStream() {
      String userId =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID
      return FirebaseFirestore.instance
          .collection('Partners') // Collection name
          .doc(userId) // User-specific document
          .snapshots() // Get real-time updates
          .map((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          List<dynamic> deliveryItems =
              snapshot['deliveryItems'] ?? []; // Fetch array
          return deliveryItems.length; // Return array length
        } else {
          return 0; // Default if document doesn't exist
        }
      });
    }

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
              StreamBuilder<int>(
                stream: totalOrdersStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading spinner
                  } else if (snapshot.hasError) {
                    return const Text(
                        "Error loading data"); // Handle error case
                  }

                  int totalOrders = snapshot.data ?? 0; // Fallback to 0 if null
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 140,
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$totalOrders",
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
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              //orders today card
              StreamBuilder<int>(
                stream: deliveryItemsLengthStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading spinner
                  }

                  int deliveryItemsCount =
                      snapshot.data ?? 0; // Fallback to 0 if null
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 140,
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$deliveryItemsCount",
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
                  );
                },
              ),
            ],
          ) //other devices
        : Row(
            mainAxisAlignment:
                isTablet ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              //total order card
              StreamBuilder<int>(
                stream: totalOrdersStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading spinner
                  } else if (snapshot.hasError) {
                    return const Text(
                        "Error loading data"); // Handle error case
                  }

                  int totalOrders = snapshot.data ?? 0; // Fallback to 0 if null
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 140,
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$totalOrders",
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
                  );
                },
              ),
              SizedBox(
                width: 25,
              ),
              //orders today card
              StreamBuilder<int>(
                stream: deliveryItemsLengthStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading spinner
                  }

                  int deliveryItemsCount =
                      snapshot.data ?? 0; // Fallback to 0 if null
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 140,
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$deliveryItemsCount",
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
                  );
                },
              ),
            ],
          );
  }
}
