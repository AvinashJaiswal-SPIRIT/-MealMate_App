import 'package:flutter/material.dart';

import 'home_tab.dart';
import 'categories_tab.dart';
import 'liked_tab.dart';
import 'search_tab.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;
  final List<int> _tabHistory = [0];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _tabHistory.add(index);
      _currentIndex = index;
    });
  }

  void _navigateToSearch() {
    _onTabTapped(3);
  }

  void _navigateToCategories() {
    _onTabTapped(1);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      HomeTab(
        onNavigateToSearch: _navigateToSearch,
        onNavigateToCategories: _navigateToCategories,
      ),
      CategoriesTab(onNavigateToSearch: _navigateToSearch),
      const LikedTab(),
      const SearchTab(),
    ];

    return PopScope(
      canPop: _tabHistory.length <= 1,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        setState(() {
          _tabHistory.removeLast();
          _currentIndex = _tabHistory.last;
        });
      },
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: const Color(0xFFD94A38),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: "Categories",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Liked"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          ],
        ),
      ),
    );
  }
}
