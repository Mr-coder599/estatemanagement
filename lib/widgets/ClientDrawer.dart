import 'package:estatemanagement/ClientPage/cProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientNavigation extends StatelessWidget {
  ClientNavigation({Key? key, required this.user}) : super(key: key);
  final User user;
  final padding = EdgeInsets.symmetric(horizontal: 20);
  VoidCallback? onClicked;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
              text: 'My Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'View Land Update',
              icon: Icons.landscape,
              onClicked: () => selectedItem(context, 1),
            ),
            SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'View HouseRent Update',
              icon: Icons.house_siding,
              onClicked: () => selectedItem(context, 2),
            ),
            SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'View Lease Update',
              icon: Icons.new_releases,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 4),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 5),
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem(
      {required String text,
      required IconData icon,
      required Function() onClicked}) {
    final color = Colors.white;
    final hovercolor = Colors.red;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hovercolor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CProfile(user: user)));
    }
  }
}
