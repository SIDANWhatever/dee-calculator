import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/matchProvider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int doubleIndex = 0;
  int tripleIndex = 0;
  int quadrupleIndex = 0;
  int unitIndex = 0;

  List<double> itemList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
  List<double> unitList = [0.25, 0.5, 0.75, 1, 1.5, 2, 3, 4, 5];

  void change2x(int i) {
    if (i >= 0 && i < itemList.length) {
      setState(() {
        doubleIndex = i;
      });
      if (i > tripleIndex) {
        setState(() {
          tripleIndex = i;
        });
      }
      if (i > quadrupleIndex) {
        setState(() {
          quadrupleIndex = i;
        });
      }
    }
  }

  void change3x(int i) {
    if (i >= 0 && i < itemList.length && i >= doubleIndex) {
      setState(() {
        tripleIndex = i;
      });
      if (i > quadrupleIndex) {
        setState(() {
          quadrupleIndex = i;
        });
      }
    }
  }

  void change4x(int i) {
    if (i >= 0 && i < itemList.length && i >= tripleIndex) {
      setState(() {
        quadrupleIndex = i;
      });
    }
  }

  void changeUnit(int i) {
    if (i >= 0 && i < unitList.length) {
      setState(() {
        unitIndex = i;
      });
    }
  }

  void click(BuildContext context) {
    context.read<Matches>().setX2(itemList[doubleIndex].round());
    context.read<Matches>().setX3(itemList[tripleIndex].round());
    context.read<Matches>().setX4(itemList[quadrupleIndex].round());
    context.read<Matches>().setUnit(unitList[unitIndex]);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
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
                  SettingItem(
                      title: '雙炒',
                      index: doubleIndex,
                      setterCallback: change2x,
                      items: itemList,
                      defaultValue: context.watch<Matches>().x2.toDouble()),
                  SettingItem(
                    title: '三炒',
                    index: tripleIndex,
                    setterCallback: change3x,
                    items: itemList,
                    defaultValue: context.watch<Matches>().x3.toDouble(),
                  ),
                  SettingItem(
                    title: '四炒',
                    index: quadrupleIndex,
                    setterCallback: change4x,
                    items: itemList,
                    defaultValue: context.watch<Matches>().x4.toDouble(),
                  ),
                  SettingItem(
                    title: '單位',
                    index: unitIndex,
                    setterCallback: changeUnit,
                    items: unitList,
                    isInt: false,
                    defaultValue: context.watch<Matches>().unit,
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text('確定'),
                      onPressed: () => click(context),
                    ),
                  ),
                ],
              )),
        ));
  }
}

class SettingItem extends StatefulWidget {
  final String title;
  final List<double> items;
  final void Function(int) setterCallback;
  final bool isInt;
  final double defaultValue;
  final List<int> listener;
  final int index;

  const SettingItem(
      {super.key,
      required this.title,
      required this.items,
      required this.setterCallback,
      required this.index,
      this.isInt = true,
      this.defaultValue = 0,
      this.listener = const []});

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onInit());
  }

  void onInit() {
    widget.setterCallback(widget.items.indexOf(widget.defaultValue));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(left: 20), child: Text(widget.title)),
      const Spacer(),
      Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => widget.setterCallback(widget.index - 1),
          ),
          SizedBox(
            width: 30,
            child: Text(
                widget.isInt
                    ? widget.index == widget.items.length - 1
                        ? "無"
                        : widget.items[widget.index].round().toString()
                    : widget.items[widget.index].toString(),
                textAlign: TextAlign.center),
          ),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => widget.setterCallback(widget.index + 1)),
        ],
      )
    ]);
  }
}
