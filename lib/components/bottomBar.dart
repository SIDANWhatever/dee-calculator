import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pageProvider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => context.read<Pages>().changePage(index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '主頁',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: '戰績',
        ),
      ],
      currentIndex: context.watch<Pages>().pageIndex,
      selectedItemColor: Colors.amber[800],
    );
  }
}
