import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PreviousorderBox extends StatelessWidget {
  const PreviousorderBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Get Firestore and Auth instances
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Get current user ID
    final String userId = auth.currentUser!.uid;

    // Create a stream to listen to the current user's document
    final Stream<DocumentSnapshot> userStream =
        firestore.collection('previousOrders').doc(userId).snapshots();

    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;

    final List<Map> orders = [
      {
        'Orderid': '939173',
        '#': '1',
        'Address': 'Puthiya veetil house',
        'Shipcharge': '4.95',
        'Payment': 'Online',
        'Status': 'Delivered',
        'Totalprice': '8.64',
        'Totalitems': '1'
      },
      {
        'Orderid': '179297',
        '#': '2',
        'Address': 'Puthiya veetil house',
        'Shipcharge': '4.95',
        'Payment': 'Online',
        'Status': 'Delivered',
        'Totalprice': '17.25',
        'Totalitems': '1'
      },
      {
        'Orderid': '663233',
        '#': '3',
        'Address': 'Puthiya veetil house',
        'Shipcharge': '4.95',
        'Payment': 'Online',
        'Status': 'Delivered',
        'Totalprice': '11.72',
        'Totalitems': '2'
      },
      {
        'Orderid': '223289',
        '#': '4',
        'Address': 'Puthiya veetil house',
        'Shipcharge': '4.95',
        'Payment': 'COD',
        'Status': 'Delivered',
        'Totalprice': '20.79',
        'Totalitems': '2'
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Previous Orders",
          style: TextStyle(
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
              fontSize: 22),
        ),
        SizedBox(
          height: 15,
        ),

        //table
        StreamBuilder<DocumentSnapshot>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("No orders found."));
            }

            // Get the previousOrders array from the document
            var data = snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> orders = data['previousOrders'] ?? [];

            if (orders.isEmpty) {
              return const Center(child: Text("No orders found."));
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text(
                    '#',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                  )),
                  DataColumn(
                      label: Text(
                    'OrderId',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Address',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Total Items',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Total Price',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Payment Method',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                  DataColumn(
                      label: Text(
                    'Status',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                ],
                rows: List.generate(
                  orders.length,
                  (index) {
                    final order = orders[index] as Map<String, dynamic>;
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          (index + 1).toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['orderId'] ?? 'N/A',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['address'] ?? 'N/A',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['totalItems']?.toString() ?? '0',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['totalPrice']?.toString() ?? '0.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['paymentMethod'] ?? 'N/A',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          "Delivered",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
