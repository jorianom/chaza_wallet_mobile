import 'package:chaza_wallet/presentation/views/home_view.dart';
import 'package:chaza_wallet/presentation/views/settings_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int option = 0;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screens = [const HomeView(), const SettingsView()];

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: IndexedStack(
        index: option,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.blueAccent,
        type: BottomNavigationBarType.shifting,
        currentIndex: option,
        onTap: (value) {
          setState(() {
            option = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet),
            activeIcon: const Icon(Icons.account_balance_wallet),
            label: "Wallet",
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            activeIcon: const Icon(Icons.settings),
            label: "Settings",
            backgroundColor: colors.primary,
          )
        ],
      ),
    );
  }
}
