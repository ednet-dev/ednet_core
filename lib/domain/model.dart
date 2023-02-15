library model;

export 'model/aggregate_root.dart';
export 'model/entities.dart';
export 'model/commands.dart';
export 'model/policies.dart';
export 'model/events.dart';
export 'model/value_object.dart';

String defaultDomainModelYaml = '''
name: TaskManagement
dependsOn: [UserManagement]
aggregateRoots:
  name: task
  commands:
    name: finish
    intention: Finish the task
    policies:
      name: task_finished_policy
      expectation: Task must be in progress
      enforcement: throw TaskNotInProgressException
      events:
    name: task_finished
    payload:
      name
      task_id
applicationServices:
  name: TaskAssignment
  dependencies:
    TaskRepository
    UserRepository
  commands:
    name: assign
    intention: Assign a task to a user
    events:
      name: task_assigned
      payload:
        task_id
        user_id
''';
