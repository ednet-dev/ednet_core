part of ednet_core;

class Parents extends Entities<Property> {
  int get externalCount {
    int externalCount = 0;
    for (var parent in this) {
      if ((parent as Neighbor).external) externalCount++;
    }
    return externalCount;
  }
}
