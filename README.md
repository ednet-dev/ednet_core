I edited it from SOM

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.



// ///
// /// # Why
// // ## Motivation for creating
// // ### ednet_core
// // **Ease DDD learning curve and organizational wide adoption** by introducing a set of (agile, evolvable, opinionated)*(templates, processes, and practices) with primary focus on transparent communication and available live documentation. Destroying of knowledge silos, easier and painless onboarding of new team members and
// // **Influence positively Developer experience** by encapsulating repetitive parts of the Domain-driven design implementations across example domain models and more generally across a class of similar specializations.
// // **Shortening idea-to-market time**, so that empowered teams can demonstrate generic MVP rather quickly only based on output of their EventStorming sessions.
// //
// // Overall in all domains of optimization interest for us is the central topic of **Stakeholder experience, be that one of Developer, Designer, Product stakeholder, User and its specializations or any other Role** involved in ideation, management, and creation of Product's purposeful life.
// //
// // # How
// // procedures
// // practices
// // Guidelines
// // rituals
// //
// // The story goes as follows:
// //
// // **Key figures of all companies departments** (up to 8) are gathered **each morning around a Big picture** EventStorming canvas, be that in real life, on some digital platform like "Miro" or kalele's "domorobo". As they chat about domain model and its details described on Big picture canvas, and drink their morning coffee and eat they breakfast and cake, there is also vrijedni **facilitator** who tries to make some order and value out of participants and directs overall conversation in directions as **to explore and exploit all opportunities** as defined by Alberto's EventStorming process.
// // 		Then there is also an **assigned scribe** who will formulate the session's output to **specify requirements for the next level** in the value production chain of a given business.
// // 		**Scribe has additional help of Listeners** who are just spectators and are helping a Scribe to formulate meeting output in some structured and meaningful way.
// // 	Facilitator repeats continuously loud story noted by scribe until consensus is reached. The facilitator should also encourage participants to take rounds in taking responsibility to repeat noted changes laud so that common understanding is validated or challenged. In online format it is useful to time frame all activities *(like giving e.g., 3 minutes for repeating story aloud and then 3 minutes for participants to introduce changes to the newly gained knowledge and identify hotspots, then 3 minutes to discuss upvoted hotspot, before that, there was 1 minute of voting and so on).*
// // **Listeners are then taking the output of scribe and themselves**,  and execute, **now in the role of Facilitators**, a workshop of their own **on the Process level,** involving up to 8 **inner and outer stakeholders** pro or from department
// // Same as before, Scribe and Listeners are taking output of session
// //
// // There is motivation to so much of rigor in process and ritual parts, as we will use **benefits of DSL** (described in dsl.md) to **harness power of data transformations and code generation**, to use strongly typed or just enough generic outputs and artifacts of "Software design level event storming workshop" to generate core infrastructure and domain model based on concrete Dart platform using Dart language and pub packages for backend and frontend development. For Developer experience, we are also choosing a Flutter, a multiplatform UI/UX framework implemented in Dart as it have Material library of widgets which we can then use to efficiently and simply, based on Dart native types and configured entities attributes, commands, events and policies, transform, and render those configurations templates as higher semantic interactions of entities and other players summarized in generic card widget able to parse attributes and show them responsibly in flutter.
// // We use the following pub packages to develop Flutter UI:
// // - For the state management we use mobx
// // - For persistence and caching Isar
// // - For external integration, dio
// // - For modularization on any level appropriate flutter_modular
// // - For semantic rendering of our specialized entities as flutter widgets, we use ednet_semantics, dart pub package which is compatible with ednet_core's concepts and based on them provide developer with possibility to map entities attribute, command, event, or policy summaries or interactions with semantic corresponding widget from their library. Like for example, if entity is a Participant from Domain Model of Paid Sport Activities, and that User is a participant on paid training which is led by a Trainer with name, image, and short bio. Some of possible attributes of such Participants are: ID:int, name: string, birthdate: date, etc., and Requirements are stating that you have to display age of participant on entity widget card, without **ednet_semantics** you would have to calculate age of user/participants and then decide on appropriate display in eventual localized context. All that is not necessary if developer upon providing Entity to EntitySummaryCard or EntityModalForm or FullScreenEntity from ednet_eds (which utilize AdaptiveLayot for responsiveness, provides theming, layouting and skins), also provides and appropriate mapping of ednet_semantics semantic attribute for ednet_eds to consume and use appropriate ui/ux/behavioral pattern implemented as Flutter widget. This could look like:
//
// void main() {
//   const entitySummaryCard = EntitySummaryCard(
//     entity: Participant(
//       id: 1,
//       name: 'John Doe',
//       birthdate: DateTime(1990, 1, 1),
//     ),
//     semanticAttributes: {
//       'birthdate': SemanticAttribute(
//         type: SemanticAttributeType.age,
//         format: SemanticAttributeFormat.short,
//       ),
//     },
//   );
// }
//
// class EntitySummaryCard {
//   const EntitySummaryCard({
//     required this.entity,
//     required this.semanticAttributes,
//   });
//
//   final Entity entity;
//   final Map<String, SemanticAttribute> semanticAttributes;
// }
//
// // This is just a simple example, but it shows how we can use semantic attributes to provide semantic meaning to our entities attributes, and then use that semantic meaning to render appropriate widget for that attribute. This is just a simple example, but it shows how we can use semantic attributes to provide semantic meaning to our entities attributes, and then use that semantic meaning to render appropriate widget for that attribute.
// class SemanticAttribute {
//   const SemanticAttribute({
//     required this.type,
//     required this.format,
//   });
//
//   final SemanticAttributeType type;
//   final SemanticAttributeFormat format;
// }
//
// enum SemanticAttributeType {
//   age,
//   date,
//   time,
//   duration,
//   distance,
//   currency,
//   email,
//   phone,
//   url,
//   text,
//   number,
//   boolean,
//   image,
//   video,
//   audio,
//   file,
//   location,
//   rating,
//   color,
//   icon,
//   button,
//   link,
//   list,
//   map,
//   object,
// }
//
// enum SemanticAttributeFormat {
//   short,
//   medium,
//   long,
//   full,
// }
//
// // Refactor solution of semantic attributes so that we have semantics grouped under primitiv types which mapping they support
// // - String:Currency, Title, Subtitle, Paragraph, Citation, Activation code, Password, Multimedia description, Link, Comment, Counter...
// // - Number: Age, Amount of money, Distance, Duration, Rating, Temperature...
// // - [from:Number, to:Number]: Range of numbers: Age range, Amount of money range, Distance range, Duration range, Rating range, Temperature range...
// // - Date: Age, Birthday, Due date, Booking date, Event date, Payment date...
// // - [from:Date, to:Date]: Age range, Birthday range, Due date range, Booking date range, Event date range, Payment date range, Number of Days, Number of Weeks, Number of Months, Number of Years...
// // - Boolean: Vote (on particular mater), Participation on some event, more general answering questions which are answered exclusively with yes or no; we use for implementation: Switch, Checkbox, etc.
// // - Location: Address, Coordinates, etc.
// // - [from:Location, to:Location]: Route, Distance, etc.
//
// //implementation of class Participant from Domain Model of Paid Sport Activities, and that User is a participant on paid training which is led by a Trainer with name, image, and short bio. Some of possible attributes of such Participants are: ID:int, name: string, birthdate: date, etc., and Requirements are stating that you have to display age of participant on entity widget card
