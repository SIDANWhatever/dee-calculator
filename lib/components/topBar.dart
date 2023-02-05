import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/matchProvider.dart';
import 'addUser.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
      IconButton(
        icon: const Icon(Icons.refresh),
        tooltip: 'Navigation menu',
        onPressed: () => context.read<Matches>().resetAll(),
      ),
      IconButton(
        icon: const Icon(Icons.group_add),
        tooltip: 'Navigation menu',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const SimpleDialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    children: [AddUser()],
                  ));
        },
      ),
    ]));
  }
}
