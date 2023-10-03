
import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/screens/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/screens/expenses/expenses_main.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
   CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  int index = 0;
   
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
 
  }
 

  List<Widget> _buildScreens() =>
      [
        const DashboardScreen(),const ExpensesMain(),  
        ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home_filled),
            title: "Home",
            activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          title: "Add Expenses",
          activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
          inactiveColorPrimary: Colors.grey,
        ),
        
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(),
          child: PersistentTabView(
            context,
            onItemSelected: (v) async{
              setState(() {
                index = v;
                
              });
             
            },
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            resizeToAvoidBottomInset: true,
            padding: const NavBarPadding.all(7),
            navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                ? 0.0
                : kBottomNavigationBarHeight,
            bottomScreenMargin: 0,
            
            backgroundColor: mainColor,
            decoration:
                const NavBarDecoration(colorBehindNavBar: Colors.indigo),
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
            ),
            navBarStyle: NavBarStyle.style6,
          ),
        ),
        
      );
}
