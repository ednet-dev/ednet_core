part of ednet_core;

Attribute findNonIdAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (!attribute.identifier) {
      return attribute;
    }
  }
  return null;
}

Attribute findNonRequiredAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (!attribute.required) {
      return attribute;
    }
  }
  return null;
}

Attribute findRequiredNonIdAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (attribute.required && !attribute.identifier) {
      return attribute;
    }
  }
  return null;
}

Attribute findIdAttribute(Concept concept) {
  for (Attribute attribute in concept.attributes) {
    if (attribute.identifier) {
      return attribute;
    }
  }
  return null;
}

