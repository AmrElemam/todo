// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/DialogsUtils.dart';
import 'package:todo/providers/AuthProvider.dart';
import 'package:todo/ui/home/tabs/SettingsTab.dart';
import 'package:todo/ui/home/tabs/TaskListTab.dart';
import 'package:todo/ui/login/LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const SettingsTab(),
    const TasksListTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5D9CEC),
        leading: IconButton(
          onPressed: () {
            logout();
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 15,
        child: BottomNavigationBar(
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list, size: 37), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 37), label: ""),
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }

  void logout() {
    var authprovider = Provider.of<Authprovider>(context, listen: false);
    DialogUtils.showMessage(
      context,
      "Are You Sure To Log Out?",
      posActionTitle: "yes",
      posAction: () {
        authprovider.logout();
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      negActionTitle: "no",
    );
  }
}
