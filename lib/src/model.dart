import 'package:flutter/material.dart';
import 'package:side_menu/src/model_interface.dart';
import 'package:system/system.dart';

class SideMenuViewModel extends ChangeNotifier implements ISideMenuModel {
  final List<_KeyValue<Position, ISideMenuItem>> _array = [];

  @override
  List<ISideMenuItem> get top => _array.where((element) => element.key == Position.top).map((e) => e.value).toList();
  @override
  List<ISideMenuItem> get middle => _array.where((element) => element.key == Position.middle).map((e) => e.value).toList();
  @override
  List<ISideMenuItem> get bottom => _array.where((element) => element.key == Position.bottom).map((e) => e.value).toList();

  int _activeItemKey = 0;

  bool _isItemActive(int key) => _activeItemKey == key;

  @override
  void setActiveItemByKey(int key) {
    _activeItemKey = key;
    notifyListeners();
  }

  @override
  void addItem(int? key, String? title, int? iconKey, ICommandAsync command,
      Position position) {
    var item = Item(title, iconKey, command, _isItemActive, key ?? 0);

    _array.add(_KeyValue(position, item));

    notifyListeners();
  }

  @override
  void changeItem(oldItemKey, int? newKey, String? title, int? iconKey, ICommandAsync command) {
    var itemIndex = _array.indexWhere((element) => element.value.key == oldItemKey);
    if(itemIndex != -1){
      var newItem = Item(title, iconKey, command, _isItemActive, newKey ?? 0);
      _array[itemIndex].value = newItem;
      notifyListeners();
    }
  }
}

class _KeyValue<TKey, TValue> {
  TKey key;
  TValue value;
  _KeyValue(this.key, this.value);
}


class Item extends ChangeNotifier implements ISideMenuItem {
  @override
  int key;

  @override
  final String? title;

  @override
  final int? icon;

  @override
  final ICommandAsync command;

  final bool Function(int key) _isActiveFunction;
  @override
  bool get isSelected => _isActiveFunction(key);

  bool _isEnable = false;
  void _setEnable(bool value) {
    _isEnable = value;
    notifyListeners();
  }

  @override
  bool get isEnable => _isEnable;

  @override
  final ObserviableCollection<ISideMenuItem> children =
      ObserviableCollection<ISideMenuItem>();

  Item(this.title, this.icon, this.command, this._isActiveFunction, this.key) {
    _resolveIsEnableFuture();
  }

  Future<bool> _isEnabled() async {
    var result = await command.canExecuteAsync();
    return result.isFailure == false;
  }

  void _resolveIsEnableFuture() {
    _isEnabled().then((value) => _setEnable(value));
  }
}
