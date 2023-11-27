import 'package:flutter/material.dart';
import 'package:p3l_gah_android/view/laporan/laporan_dua_screen.dart';
import 'package:p3l_gah_android/view/laporan/laporan_satu_screen.dart';

class ExampleTabBar extends StatefulWidget {
  @override
  _ExampleTabBarState createState() => _ExampleTabBarState();
}

class _ExampleTabBarState extends State<ExampleTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Text("Laporan Satu"),
                Text("Laporan Dua"),
              ],
            ),
            title: const Text('Laporan'),
          ),
          body: TabBarView(
            children: [
              LaporanSatuScreen(),
              LaporanDuaScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

// Contoh penggunaan di dalam Widget lain:
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh Tab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExampleTabBar(),
    );
  }
}

void main() {
  runApp(MyApp());
}
