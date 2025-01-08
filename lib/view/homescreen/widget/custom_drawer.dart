import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(
      {super.key,
      this.onDashboardTap,
      this.onNewOrderTap,
      this.onPreviousOrderTap});
  final void Function()? onDashboardTap;
  final void Function()? onNewOrderTap;
  final void Function()? onPreviousOrderTap;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                onTap: widget.onDashboardTap,
                child: Row(
                  children: [
                    Icon(
                      Icons.speed,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )
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
                onTap: widget.onNewOrderTap,
                child: Row(
                  children: [
                    Icon(
                      Icons.speed,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "New Orders",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )
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
                onTap: widget.onPreviousOrderTap,
                child: Row(
                  children: [
                    Icon(
                      Icons.speed,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Previous Orders",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
