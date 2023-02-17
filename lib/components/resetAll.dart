import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/matchProvider.dart';

class ResetAll extends StatelessWidget {
  const ResetAll({super.key});

  void click(BuildContext context) {
    context.read<Matches>().resetAll();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 135,
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
                      "確定重置？",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: TextButton(
                        child: const Text('確定'),
                        onPressed: () => click(context),
                      ),
                    ),
                  ],
                ))));
  }
}
