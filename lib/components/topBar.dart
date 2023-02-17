import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pageProvider.dart';
import '../providers/showUnitProvider.dart';
import 'addUser.dart';
import 'changeUser.dart';
import 'setting.dart';
import 'resetAll.dart';
import 'settle.dart';

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
          tooltip: '重置',
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => const SimpleDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      children: [ResetAll()],
                    ));
          }),
      IconButton(
          icon: const Icon(Icons.group_add),
          tooltip: '加人',
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => const SimpleDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      children: [AddUser()],
                    ));
          }),
      IconButton(
        icon: const Icon(Icons.change_circle),
        tooltip: '換人',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const SimpleDialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    children: [ChangeUser()],
                  ));
        },
      ),
      IconButton(
        icon: const Icon(Icons.settings),
        tooltip: '設定',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const SimpleDialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    children: [Setting()],
                  ));
        },
      ),
      IconButton(
        icon: const Icon(Icons.calculate),
        tooltip: '設定',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const SimpleDialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    children: [Settle()],
                  ));
        },
      ),
      context.watch<Pages>().pageIndex == 0 ? Container() : const Spacer(),
      context.watch<Pages>().pageIndex == 0
          ? Container()
          : ToggleButtons(
              color: Colors.grey,
              selectedColor: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              borderWidth: 2,
              isSelected: [
                context.watch<ShowUnit>().showUnit == 0,
                context.watch<ShowUnit>().showUnit == 1
              ],
              onPressed: (int index) {
                context.read<ShowUnit>().changeUnit(index);
              },
              children: const <Widget>[
                Icon(Icons.attach_money),
                Icon(Icons.numbers),
              ],
            ),
    ]));
  }
}
