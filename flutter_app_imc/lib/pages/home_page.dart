import 'package:flutter/material.dart';
import 'package:flutter_app_imc/pages/account_page.dart';
import 'package:flutter_app_imc/pages/quotations_page.dart';
import 'package:flutter_app_imc/pages/conversor_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [ConversorPage(), QuotationsPage(), AccountPage()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money,
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
            label: "Conversor",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
              label: "Quotations"),
        ],
      ),
    );
  }
}
