import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/features/catalog/presentation/pages/home_page.dart';
import 'package:showroom/features/catalog/presentation/pages/catalog_selection_page.dart';
import 'package:showroom/features/preview/presentation/pages/recent_visualizations_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final _catalogNavigatorKey = GlobalKey<NavigatorState>();
  final _homeNavigatorKey = GlobalKey<NavigatorState>();
  final _recentNavigatorKey = GlobalKey<NavigatorState>();

  // Static method to switch tabs from anywhere
  static void switchToTab(BuildContext context, int tabIndex) {
    final mainNavState =
        context.findAncestorStateOfType<_MainNavigationState>();
    mainNavState?.setState(() {
      mainNavState._currentIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button for nested navigators
        final currentNavigator = _getCurrentNavigator();
        if (currentNavigator != null &&
            currentNavigator.currentState?.canPop() == true) {
          currentNavigator.currentState?.pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // Home tab with nested navigator
            Navigator(
              key: _homeNavigatorKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => const HomePage(),
                );
              },
            ),
            // Catalog tab with nested navigator
            Navigator(
              key: _catalogNavigatorKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => const CatalogSelectionPage(),
                );
              },
            ),
            // Recent tab with nested navigator
            Navigator(
              key: _recentNavigatorKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => const RecentVisualizationsPage(),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (_currentIndex != index) {
                // Reset the navigator stack when switching tabs
                final navigator = _getCurrentNavigatorByIndex(index);
                navigator?.currentState?.popUntil((route) => route.isFirst);
              }
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: AppColors.white,
            selectedItemColor: const Color(0xFFD4AF37), // Luxury gold
            unselectedItemColor: AppColors.textTertiary,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections_outlined),
                activeIcon: Icon(Icons.collections),
                label: 'Catalog',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                activeIcon: Icon(Icons.history),
                label: 'Recent',
              ),
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey<NavigatorState>? _getCurrentNavigator() {
    return _getCurrentNavigatorByIndex(_currentIndex);
  }

  GlobalKey<NavigatorState>? _getCurrentNavigatorByIndex(int index) {
    switch (index) {
      case 0:
        return _homeNavigatorKey;
      case 1:
        return _catalogNavigatorKey;
      case 2:
        return _recentNavigatorKey;
      default:
        return null;
    }
  }
}
