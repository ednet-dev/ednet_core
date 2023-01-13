import '../commands.dart';

abstract class EntityCommands {
  List<EntityCommand> get commands;

  set commands(List<EntityCommand> value);
}
