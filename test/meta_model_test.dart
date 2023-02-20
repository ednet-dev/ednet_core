import 'package:test/test.dart';
import 'package:ednet_core/ednet_core.dart';

class DirectDemocracyModel extends Model {
  static const String directDemocracy = 'DirectDemocracy';
  static const String voter = 'Voter';
  static const String digitalProduct = 'DigitalProduct';

  DirectDemocracyModel()
      : super(Domain(directDemocracy), 'EDNet$directDemocracy') {
    _initDigitalProductConcept();
    _initVoterConcept();
    _initRelationships();
  }

  void _initDigitalProductConcept() {
    Concept digitalProductConcept = Concept(this, digitalProduct);
    digitalProductConcept.description = 'Digital product for direct democracy';
    digitalProductConcept.entry = false;
    digitalProductConcept.attributes.add(
        Attribute(Concept(this, 'name'), 'Name')
          ..required = true);
    digitalProductConcept.attributes.add(
        Attribute(Concept(this, 'description'), 'Description'));

    concepts.add(digitalProductConcept);
  }

  void _initVoterConcept() {
    Concept voterConcept = Concept(this, voter);
    voterConcept.description = 'A person who is eligible to vote';
    voterConcept.entry = false;

    voterConcept.attributes.add(Attribute(Concept(this, 'name'), 'Name')
      ..required = true);
    voterConcept.attributes.add(Attribute(Concept(this, 'age'), 'Age')
      ..required = true);

    concepts.add(voterConcept);
  }

  void _initRelationships() {
    Concept voterConcept = getConcept(voter);
    Concept digitalProductConcept = getConcept(digitalProduct);

    digitalProductConcept.children.add(
        Child(voterConcept, digitalProductConcept, 'Voter'));
  }
}

