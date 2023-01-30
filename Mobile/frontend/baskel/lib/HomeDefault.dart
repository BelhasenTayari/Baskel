import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Screens/Cart.dart';
import 'package:baskel/Screens/Favourite.dart';
import 'package:baskel/Screens/Home.dart';
import 'package:baskel/Screens/Piste.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'Widgets/NavDrawer.dart';

class HomeDefault extends StatefulWidget {
  @override
  _HomeDefaultState createState() => _HomeDefaultState();
}

class _HomeDefaultState extends State<HomeDefault> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    const Favourite(),
    Home(),
    const PistePage(),
    const Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              child: Image.asset('lib/assets/images/hamburger.png'),
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Monastir",
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.5,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 15),
            child: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset('lib/assets/images/placeholder.png'),
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.heart,
                  text: 'Favourites',
                ),
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.mapMarked,
                  text: 'Piste',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Cart',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
