// part of ednet_core;
// import 'package:yaml/yaml.dart';
//
// class DomainModel {
//   final String name;
//   final String description;
//   final String version;
//   final List<EntityAttributes> attributes;
//
//   final Map<String, BoundedContext> contextMap;
//
//   DomainModel(
//     this.description,
//     this.version, {
//     required this.name,
//     required this.contextMap,
//     required this.attributes,
//     required this.valueObjects,
//     required this.entities,
//     required this.aggregateRoots,
//   });
//
//   List<ApplicationService> getApplicationServices() {
//     final applicationServices = <ApplicationService>[];
//     contextMap.values.forEach((context) {
//       applicationServices.addAll(context.applicationServices);
//     });
//     return applicationServices;
//   }
//
//   List<AggregateRoot> getAggregateRoots() {
//     final aggregateRoots = <AggregateRoot>[];
//     contextMap.values.forEach((context) {
//       aggregateRoots.addAll(context.aggregateRoots);
//     });
//     return aggregateRoots;
//   }
//
//   List<Entity> getEntities() {
//     final entities = <Entity>[];
//     contextMap.values.forEach((context) {
//       entities.addAll(context.entities);
//     });
//     return entities;
//   }
//
//   List<ValueObject> getValueObjects() {
//     final valueObjects = <ValueObject>[];
//     contextMap.values.forEach((context) {
//       valueObjects.addAll(context.valueObjects);
//     });
//     return valueObjects;
//   }
//
//   List<Attribute> getAttributes() {
//     final attributes = <Attribute>[];
//     contextMap.values.forEach((context) {
//       attributes.addAll(context.attributes);
//     });
//     return attributes;
//   }
//
//   List<BoundedContext> getBoundedContexts() {
//     final contexts = <BoundedContext>[];
//     contextMap.values.forEach((context) {
//       contexts.add(context);
//     });
//     return contexts;
//   }
//
//   List<DomainModel> getDependencies() {
//     final dependencies = <DomainModel>[];
//     contextMap.values.forEach((context) {
//       dependencies.addAll(context.dependencies);
//     });
//     return dependencies;
//   }
//
//   factory DomainModel.fromYaml(String yaml) {
//     final doc = loadYaml(yaml);
//
//     // final applicationServices = getApplicationServices(data);
//     // final domainServices = getDomainServices(data);
//     // final entities = getEntities(data);
//     // final valueObjects = getValueObjects(data);
//     // final aggregates = getAggregates(data);
//     // final factories = getFactories(data);
//     // final repositories = getRepositories(data);
//     // final events = getEvents(data);
//     // final exceptions = getExceptions(data);
//     // final interfaces = getInterfaces(data);
//     // final boundedContexts = getBoundedContexts(data);
//     // final domainModel = DomainModel(
//
//     // Create the BoundedContext instances
//     final contextMap = <String, BoundedContext>{};
//     doc['contexts'].forEach((contextYaml) {
//       final context = BoundedContext.fromYaml(contextYaml);
//       contextMap[context.name] = context;
//     });
//
//     // Resolve the dependencies between the BoundedContexts
//     contextMap.forEach((name, context) {
//       context.dependencies = doc['dependencies']
//           .map((dependencyName) => contextMap[dependencyName])
//           .toList();
//     });
//     //
//     // for (final applicationService in applicationServices) {
//     //   if (applicationService.name == null || applicationService.name.isEmpty) {
//     //     throw Exception("Application service must have a name");
//     //   }
//     //   if (applicationService.dependencies == null ||
//     //       applicationService.dependencies.isEmpty) {
//     //     throw Exception(
//     //         "Application service must have at least one dependency");
//     //   }
//     //   if (applicationService.dependencies.length !=
//     //       applicationService.dependencies.toSet().length) {
//     //     throw Exception("Application service dependencies must be unique");
//     //   }
//     //   if (contextMap.containsKey(applicationService.context) == false) {
//     //     throw Exception(
//     //         "Application service context must be defined in the domain model");
//     //   }
//     //   contextMap[applicationService.context]
//     //       ?.applicationServices
//     //       .add(applicationService);
//     // }
//
//     return DomainModel(
//         name: name,
//         contextMap: contextMap,
//         attributes: attributes,
//         valueObjects: valueObjects,
//         entities: entities,
//         aggregateRoots: aggregateRoots);
//   }
// }
