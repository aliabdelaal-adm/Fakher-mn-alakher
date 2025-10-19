import 'package:app/src/common/helper.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/screens/faq-screen.dart';
import 'package:app/src/ui/screens/orders-screen.dart';
import 'package:app/src/ui/screens/profile-screen.dart';
import 'package:flutter/material.dart';
import '../../../localizations.dart';
import 'home_screen.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;

  Widget currentPage = HomeScreen();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      currentTab = currentTab;
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomeScreen();
          break;
        case 1:
          widget.currentPage = OrdersScreen();
          break;
        case 2:
          widget.currentPage = FaqScreen();
          break;
        // case 3:
        //   widget.currentPage = WalletSuccessWidget();
        //   break;
        case 3:
          widget.currentPage = ProfileScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
//        drawer: DrawerWidget(),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
//          selectedFontSize: 0,
//          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppLocalizations.of(context).home),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: AppLocalizations.of(context).my_orders,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: AppLocalizations.of(context).help_supports,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.wallet_giftcard_outlined),
            //   label: AppLocalizations.of(context).profile,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context).profile,
            )
          ],
        ),
      ),
    );
  }
}
