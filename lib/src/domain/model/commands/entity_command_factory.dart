import '../commands.dart';

abstract class EntityCommandFactory {
  EntityCommand getCommand();
}
