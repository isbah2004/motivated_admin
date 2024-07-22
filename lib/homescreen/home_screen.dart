import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivated_admin/drawers/home_drawer.dart';
import 'package:motivated_admin/homescreen/hometabs/philosphy_tab.dart';
import 'package:motivated_admin/homescreen/hometabs/poems_tab.dart';
import 'package:motivated_admin/homescreen/hometabs/quotes_tab.dart';
import 'package:motivated_admin/theme/theme_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          SystemNavigator.pop();
        },
        child: Scaffold(
          endDrawer: const HomeDrawer(),
          backgroundColor: AppTheme.hintColor,
          appBar: AppBar(
            backgroundColor: AppTheme.hintColor,
            bottom: TabBar(
              tabs: [
                Text('Philosphy',
                    style: Theme.of(context).textTheme.bodyLarge!),
                Text(
                  'Poems',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Quotes',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Hero(
              tag: 'appbarHero',
              child: Text(
                'Motivational App',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              PhilosphyTab(),
              PoemTab(),
              QuotesTab(),
            ],
          ),
        ),
      ),
    );
  }
}
