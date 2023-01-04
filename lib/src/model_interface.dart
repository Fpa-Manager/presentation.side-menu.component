import 'package:flutter/cupertino.dart';
import 'package:system/system.dart';

abstract class ISideMenuModel extends ChangeNotifier {
  List<ISideMenuItem> get top;
  List<ISideMenuItem> get middle;
  List<ISideMenuItem> get bottom;

  void setActiveItemByKey(int key);
  void addItem(int? key, String? title, int? iconKey, ICommandAsync command,
      Position position);
  void changeItem(oldItemKey, int? newKey, String? title, int? iconKey, ICommandAsync command);
}

enum Position { top, middle, bottom }

abstract class ISideMenuItem {
  abstract final int key;
  abstract final String? title;
  abstract final int? icon;
  abstract final ICommandAsync command;
  abstract final bool isSelected;
  abstract final bool isEnable;
  abstract final ObserviableCollection<ISideMenuItem> children;
}
