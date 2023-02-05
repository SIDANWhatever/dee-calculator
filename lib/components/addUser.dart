import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/matchProvider.dart';
import 'dart:developer';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const AddUserCard(),
    );
  }
}

class AddUserCard extends StatefulWidget {
  const AddUserCard({super.key});

  @override
  State<AddUserCard> createState() => _AddUserCardState();
}

class _AddUserCardState extends State<AddUserCard> {
  final controller = TextEditingController();
  String newName = "";

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void changeText(String text) {
    setState(() {
      newName = text;
    });
  }

  void click(BuildContext context) {
    log("Logging the text ${controller.text}");
    context.read<Matches>().addUser(Person(name: newName));
    Navigator.pop(context);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 260,
        width: 220,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Expanded(
                      child: Text(
                    "請輸入玩家名字",
                    style: TextStyle(fontSize: 20),
                  )),
                  Expanded(
                      child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: '玩家名字',
                    ),
                    onChanged: (text) => changeText(text),
                  )),
                  Expanded(
                    child: TextButton(
                      child: Text('確定'),
                      onPressed: () => click(context),
                    ),
                  ),
                  Text(controller.text)
                ],
              )),
        ));
  }
}
