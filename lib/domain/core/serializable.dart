part of entities;

mixin Serializable {
  Map<String, dynamic> toJson();

  static fromJson(Map<String, dynamic> json) {}
}
