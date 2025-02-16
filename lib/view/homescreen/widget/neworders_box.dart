import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewordersBox extends StatelessWidget {
  const NewordersBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Get current user ID
    final String userId = auth.currentUser!.uid;

    // Create a stream to listen to the current user's document in Partners collection
    final Stream<DocumentSnapshot> userStream =
        firestore.collection('Partners').doc(userId).snapshots();

    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;

    final List<Map> orders = [
      {
        'Orderid': '243556',
        '#': '1',
        'Address': 'Puthiya veetil house',
        'Shipcharge': '4.95',
        'Payment': 'COD',
        'Status1': "Complete Delivery",
        'Status2': "Cancel",
        'Action': '',
        'Totalprice': '15.95',
        'Totalitems': '1'
      },
      {
        'Orderid': '217867',
        '#': '2',
        'Address': 'Cholakottile',
        'Shipcharge': '0.0',
        'Payment': 'COD',
        'Status1': 'Complete Delivery',
        'Status2': 'Cancel',
        'Action': '',
        'Totalprice': '123.14999999',
        'Totalitems': '4'
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Orders",
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
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('No orders found.'));
            }

            // Extract deliveryitems array from Firestore document
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final List<dynamic> deliveryItems = data['deliveryItems'] ?? [];

            if (deliveryItems.isEmpty) {
              return Center(child: Text('No delivery items available.'));
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
                  DataColumn(
                      label: Text(
                    'Action',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  )),
                ],
                rows: List.generate(
                  deliveryItems.length,
                  (index) {
                    final order = deliveryItems[index] as Map<String, dynamic>;
                    List items = order['items'];
                    int itemcount = items.length;

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
                          order['orderId'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['address'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          itemcount.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['totalPrice'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(Text(
                          order['paymentMethod'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                        DataCell(
                          Row(
                            children: [
                              //completebuton
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    String userId = FirebaseAuth
                                        .instance
                                        .currentUser!
                                        .uid; // Get current user ID
                                    FirebaseFirestore firestore =
                                        FirebaseFirestore.instance;

                                    DocumentReference partnerDoc = firestore
                                        .collection('Partners')
                                        .doc(userId);
                                    CollectionReference
                                        outForDeliveryCollection =
                                        firestore.collection('outforDelivery');
                                    CollectionReference
                                        completedOrdersCollection =
                                        firestore.collection('completedOrders');
                                    DocumentReference previousOrdersDoc =
                                        firestore
                                            .collection('previousOrders')
                                            .doc(userId);
                                    // Check if document exists
                                    DocumentSnapshot docSnapshot =
                                        await previousOrdersDoc.get();

                                    // Fetch the current user's document
                                    DocumentSnapshot snapshot =
                                        await partnerDoc.get();

                                    if (snapshot.exists) {
                                      Map<String, dynamic> data = snapshot
                                          .data() as Map<String, dynamic>;

                                      if (data.containsKey('deliveryItems')) {
                                        List<dynamic> deliveryItems =
                                            List.from(data['deliveryItems']);

                                        // Remove the specific orderId from deliveryItems
                                        deliveryItems.removeWhere((item) =>
                                            item['orderId'] ==
                                            order['orderId']);

                                        // Update Firestore with the modified list
                                        await partnerDoc.update(
                                            {'deliveryItems': deliveryItems});
                                      }
                                    }

                                    // Fetch all documents in outForDelivery collection
                                    QuerySnapshot outForDeliverySnapshot =
                                        await outForDeliveryCollection.get();

                                    // Find the document where orderId matches
                                    for (QueryDocumentSnapshot doc
                                        in outForDeliverySnapshot.docs) {
                                      if (doc['orderId'] == order['orderId']) {
                                        await doc.reference
                                            .delete(); // Delete the matching document
                                        break;
                                      }
                                    }

                                    // Add order details to completedOrders collection
                                    await completedOrdersCollection.add({
                                      'orderId': order['orderId'],
                                      'address': order['address'],
                                      'totalPrice': order['totalPrice'],
                                      'totalItems': deliveryItems.length,
                                      'products': deliveryItems,
                                      'paymentMethod': order['paymentMethod'],
                                      'completedAt': FieldValue
                                          .serverTimestamp(), // Store completion time
                                      'completedBy':
                                          userId, // Store who completed it
                                    });

                                    // Add the order details to previousOrders array field inside current user's document
                                    if (docSnapshot.exists) {
                                      // Use update() to add to the array without overwriting other fields
                                      await previousOrdersDoc.update({
                                        'previousOrders':
                                            FieldValue.arrayUnion([
                                          {
                                            'orderId': order['orderId'],
                                            'address': order['address'],
                                            'totalPrice': order['totalPrice'],
                                            'totalItems': deliveryItems.length,
                                            'paymentMethod':
                                                order['paymentMethod'],
                                            // 'completedAt': FieldValue
                                            //     .serverTimestamp(), // Store completion time
                                            'completedBy':
                                                userId, // Store who completed it
                                          }
                                        ])
                                      });
                                    } else {
                                      // Use set() only when creating a new document
                                      await previousOrdersDoc.set({
                                        'previousOrders': [
                                          {
                                            'orderId': order['orderId'],
                                            'address': order['address'],
                                            'totalPrice': order['totalPrice'],
                                            'totalItems': deliveryItems.length,
                                            'paymentMethod':
                                                order['paymentMethod'],
                                            // 'completedAt':
                                            //     FieldValue.serverTimestamp(),
                                            'completedBy': userId,
                                          }
                                        ]
                                      });
                                    }
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              "Order Completed Successfully!!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )));

                                    print("Order completed successfully!");
                                  } catch (e) {
                                    print("Error processing order: $e");
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: isDesktop ? 80 : 110,
                                  padding:
                                      EdgeInsets.only(left: isDesktop ? 5 : 0),
                                  child: Center(
                                      child: Text(
                                    "Complete Delivery",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              // SizedBox(width: 4),
                              // //cancel buton
                              // Container(
                              //   height: 40,
                              //   width: 80,
                              //   child: Center(
                              //       child: Text(
                              //     order['Status2'],
                              //     style: TextStyle(
                              //         color: Colors.white,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 12),
                              //   )),
                              //   decoration: BoxDecoration(
                              //       color: Colors.red,
                              //       borderRadius: BorderRadius.circular(8)),
                              // ),
                            ],
                          ),
                        ),
                        DataCell(Text(
                          "",
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
        ),
      ],
    );
  }
}
