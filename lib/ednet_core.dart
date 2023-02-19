library ednet_core;

import 'dart:math';
import 'dart:convert';

export 'domain/model.dart';

part 'domain/models.dart';

part 'domain/session.dart';

part 'repository.dart';

part 'gen/ednet_repository.dart';

part 'gen/ednet_library.dart';

part 'gen/ednet_library_app.dart';

part 'gen/ednet_domain_generic.dart';

part 'gen/ednet_domain_specific.dart';

part 'gen/ednet_model_generic.dart';

part 'gen/ednet_model_specific.dart';

part 'gen/ednet_concept_generic.dart';

part 'gen/ednet_concept_specific.dart';

part 'gen/ednet_test.dart';

part 'gen/ednet_web.dart';

part 'gen/random.dart';

part 'gen/random_data.dart';

part 'gen/search.dart';

part 'domain/model/event/actions/action_api.dart';

part 'domain/model/event/actions/add_action.dart';

part 'domain/model/event/actions/basic_action.dart';

part 'domain/model/event/actions/entity_action.dart';

part 'domain/model/event/actions/entities_action.dart';

part 'domain/model/event/actions/remove_action.dart';

part 'domain/model/event/actions/set_attribute_action.dart';

part 'domain/model/event/actions/set_child_action.dart';

part 'domain/model/event/actions/set_parent_action.dart';

part 'domain/model/event/actions/transaction.dart';

part 'domain/model/event/actions/transaction_api.dart';

part 'domain/model/event/past.dart';

part 'domain/model/event/reactions.dart';

// part 'domain/model/commands/entity_command.dart';

// part 'domain/model/commands/entity_command_factory.dart';

// part 'domain/model/commands/entity_commands.dart';

// part 'domain/model/policy/entity_policies.dart';
//
// part 'domain/model/policy/entity_policy.dart';
//
// part 'domain/model/policy/entity_policy_factory.dart';

// part 'domain/model/events/entity_event.dart';
//
// part 'domain/model/events/entity_event_factory.dart';
//
// part 'domain/model/events/entity_events.dart';

part 'domain/model/transfer/json.dart';

part 'domain/model/entity/entities.dart';

part 'domain/model/entity/entity.dart';

part 'domain/model/entity/interfaces/i_entity.dart';

part 'domain/model/entity/id.dart';

part 'domain/model/entity/interfaces/i_id.dart';

part 'domain/model/entity/interfaces/i_entities.dart';

part 'domain/model/entries.dart';

part 'domain/model/oid.dart';

part 'domain/model/reference.dart';

part 'meta/attributes.dart';

part 'meta/children.dart';

part 'meta/concepts.dart';

part 'meta/concept.dart';

part 'meta/domains.dart';

part 'meta/models.dart';

part 'meta/neighbor.dart';

part 'meta/parents.dart';

part 'meta/parent.dart';

part 'meta/property.dart';

part 'meta/types.dart';

part 'domain/model/entity/wip/dart_basic_types.dart';

//
// part 'domain/model/entity/wip/entity_attributes.dart';
//
// part 'domain/model/entity/entity_description.dart';
//
// part 'domain/model/entity/wip/entity_id.dart';
//
// part 'domain/model/entity/entity_identity.dart';

part 'domain/model/entity/wip/entity_mapping.dart';

// part 'domain/model/entity/entity_name.dart';
//
// part 'domain/model/entity/entity_tags.dart';

part 'domain/model/entity/wip/flutter_semantic_render_type.dart';

// part 'domain/model/entity/semantic_attribute_format.dart';

part 'domain/model/entity/wip/semantic_attribute_type.dart';

part 'domain/core/serializable.dart';

part 'utilities/text/transformation.dart';

part 'domain/model/error/exceptions.dart';

part 'domain/model/error/i_validation_exception.dart';

part 'domain/model/error/validation_exception.dart';

part 'domain/model/error/validation_exceptions.dart';
