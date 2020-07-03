import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///修复flutter SDK 1.12版本tap事件无效问题;
class TapGestureRepairV112 extends StatefulWidget {
  final Widget child;

  TapGestureRepairV112({this.child, Key key}) : super(key: key);

  @override
  TapGestureRepairV112State createState() => TapGestureRepairV112State();
}

class TapGestureRepairV112State extends State<TapGestureRepairV112> {
  List<int> get pointerIds => _pointerIds;

  List<int> _pointerIds = new List();

  void repairPointer() {
    if (pointerIds.isNotEmpty) {
      for (int pointer in pointerIds) {
        GestureBinding.instance.cancelPointer(pointer);
      }
    }
  }

  void _addPointer(int pointer) {
    if (_pointerIds.indexOf(pointer) == -1) {
      _pointerIds.add(pointer);
    }
  }

  void _removePointer(int pointer) {
    if (_pointerIds.indexOf(pointer) != -1) {
      _pointerIds.remove(pointer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: widget.child,
      onPointerDown: (event) {
        _addPointer(event?.pointer);
      },
      onPointerUp: (event) {
        _removePointer(event?.pointer);
      },
      onPointerCancel: (event) {
        _removePointer(event?.pointer);
      },
    );
  }
}
