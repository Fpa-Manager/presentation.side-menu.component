import 'package:system/system.dart';

class BlancConsoleCommand implements ICommandAsync {
  @override
  String name = "blanc";

  @override
  String title = "Вывод сообщения что команда не подключена.";

  @override
  Future<Result> canExecuteAsync() async {
    return Future(() => Result.Ok());
  }

  @override
  Future executeAsync() async {
    return Future(() => print("Test output to console from command"));
  }
}

class BlockedCommand implements ICommandAsync {
  @override
  String name = "blanc";

  @override
  String title = "Вывод сообщения что команда не подключена.";

  @override
  Future<Result> canExecuteAsync() async {
    return Future(() => Result.Error("Execute impossible"));
  }

  @override
  Future executeAsync() async {
    var canExecute = await canExecuteAsync();
    if(canExecute.isFailure == false) return Future(() => print("Test output to console from command"));
    return Future(() => print(canExecute.messages));
  }
}


class SetMenuItemActiveCommand implements ICommandAsync {
  @override
  String name = "blanc";

  int key;
  Function fn;

  SetMenuItemActiveCommand(this.key, this.fn);

  @override
  String title = "Вывод сообщения что команда не подключена.";

  @override
  Future<Result> canExecuteAsync() async {
    if(key == 333) return Future(() => Result.Error("Execute impossible"));
    return Future(() => Result.Ok());
  }

  @override
  Future executeAsync() async {
    var canExecute = await canExecuteAsync();
    if(canExecute.isFailure == false) return Future(() => fn(key));
    return Future(() => print("Test output to console from command"));
  }
}