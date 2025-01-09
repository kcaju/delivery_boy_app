import 'package:flutter/material.dart';

class NewordersBox extends StatelessWidget {
  const NewordersBox({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    void scrollRight() {
      _scrollController.animateTo(
        _scrollController.offset +
            320, // Scroll by 320px (card width + spacing)
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    void scrollLeft() {
      _scrollController.animateTo(
        _scrollController.offset -
            320, // Scroll by 320px (card width + spacing)
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

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
        SingleChildScrollView(
          controller: _scrollController,
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
                'Shipping Charge',
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
              orders.length,
              (index) {
                final order = orders[index];
                return DataRow(
                  cells: [
                    DataCell(Text(
                      order['#']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(Text(
                      order['Orderid']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(Text(
                      order['Address']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(Text(
                      order['Totalitems']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(Text(
                      order['Shipcharge']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(Text(
                      order['Totalprice']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(Text(
                      order['Payment']!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )),
                    DataCell(
                      Row(
                        children: [
                          //completebuton
                          Container(
                            height: 40,
                            width: isDesktop ? 80 : 110,
                            padding: EdgeInsets.only(left: isDesktop ? 5 : 0),
                            child: Center(
                                child: Text(
                              order['Status1'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          SizedBox(width: 4),
                          //cancel buton
                          Container(
                            height: 40,
                            width: 80,
                            child: Center(
                                child: Text(
                              order['Status2'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(
                      order['Action']!,
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
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: scrollLeft,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.lightGreen.shade200,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: scrollRight,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.lightGreen.shade200,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
