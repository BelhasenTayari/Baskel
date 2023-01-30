import 'package:baskel/Authentification/Login.dart';
import 'package:baskel/Constantes.dart';
import 'package:baskel/Screens/Profile.dart';
import 'package:baskel/Screens/events_page.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("lib/assets/images/belha.jpg"),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Belhassen Tayari",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.local_activity),
            title: const Text('Activity'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Evenement'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => EventsPage())))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text('Logout'),
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()))
            },
          ),
        ],
      ),
    );
  }
}
