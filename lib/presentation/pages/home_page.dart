import 'package:ditonton/presentation/pages/movie_page/about_page.dart';
import 'package:ditonton/presentation/pages/movie_page/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv_seris_page/tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const String _movieText = 'Movie';
  static const String _tvSeriesText = 'TV Series';
  static const String _watchListText = 'Watchlist';
  static const String _aboutText = 'About';

  List<Widget> _listWidget = <Widget>[
    HomeMoviePage(),
    TvSeriesPage(),
    Watchlist(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.local_movies),
        label: _movieText,
        backgroundColor: Colors.yellow[900]),
    BottomNavigationBarItem(
        icon: Icon(Icons.live_tv_outlined),
        label: _tvSeriesText,
        backgroundColor: Colors.yellow[900]),
    BottomNavigationBarItem(
        icon: Icon(Icons.list_alt),
        label: _watchListText,
        backgroundColor: Colors.yellow[900]),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: _aboutText,
        backgroundColor: Colors.yellow[900]),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
