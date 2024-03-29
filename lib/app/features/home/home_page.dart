import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parowanie/app/features/home/account_page/my_account_page_content.dart';
import 'package:parowanie/app/features/home/players/players_page_content.dart';
import 'package:parowanie/app/features/home/statistic_page/statistic_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentIndex == 0
            ? 'Gracze'
            : currentIndex == 1
                ? 'Statystyki'
                : 'Konto'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const PlayersPageContent();
        }
        if (currentIndex == 1) {
          return const StatisticsPageContent();
        }
        return MyAccountPageContent(email: widget.user.email!);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Zawodnicy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Statystki',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Konto',
          ),
        ],
      ),
    );
  }
}
