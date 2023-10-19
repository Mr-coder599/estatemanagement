import 'package:estatemanagement/ScreenPages/AgentDashboard.dart';
import 'package:estatemanagement/ScreenPages/LandPage.dart';
import 'package:estatemanagement/ScreenPages/LoginPage.dart';
import 'package:estatemanagement/ScreenPages/RentalPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerAgent extends StatelessWidget {
  DrawerAgent({
    Key? key,
    required this.user
  }) : super(key: key);
  final User user;

//   @override
//   State<DrawerAgent> createState() => _DrawerAgentState();
// }

// class _DrawerAgentState extends State<DrawerAgent> {
  VoidCallback? onClicked;
  final padding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.orange,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 45,
            ),
            buildMenuItem(
              text: 'My Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'Rent',
              icon: Icons.house_siding,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'lease',
              icon: Icons.leave_bags_at_home,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Land',
              icon: Icons.flight_land,
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
              thickness: 3,
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
    final hovercolr = Colors.white;
    final fontWeight = FontWeight.bold;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color, fontWeight: fontWeight),
      ),
      hoverColor: hovercolr,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        //  await FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AgentDashboard(
                 user: user,
                )));
        break;
      case 1:
        //  await FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RentalPage(
                user: user,
                )));
        break;
      case 3:
        //  await FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LandPage(
                user: user,
                )));
        break;
      case 4:
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(
                user: user,
                )));
        break;
    }
  }
}
