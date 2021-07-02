import 'package:flutter/material.dart';
import 'package:sneakers_app_firestore/blocs/home_bloc.dart';
import 'package:sneakers_app_firestore/screens/tabs/history_tab.dart';
import 'package:sneakers_app_firestore/screens/tabs/home_tab.dart';
import 'package:sneakers_app_firestore/screens/tabs/pesron_tab.dart';
import 'package:sneakers_app_firestore/screens/tabs/search_tab.dart';
import 'components/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.getName();
    super.initState();
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    SearchTab(),
    HistoryTab(),
    PersonTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(_homeBloc.nameStream,Colors.blueAccent.withOpacity(0.7),Icons.menu),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomTab(),
    );
  }



  BottomNavigationBar BottomTab() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.black),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_edu_outlined, color: Colors.black),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: Colors.black),
          label: 'Person',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


