class University {
  List<dynamic> webPages;
  String alphaTwoCode;
  List<dynamic> domains;
  String name;
  String country;

  University({
    required this.webPages,
    required this.alphaTwoCode,
    required this.domains,
    required this.name,
    required this.country,
  });

  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      name: (map['name'] ?? '') as String,
      country: (map['country'] ?? '') as String,
      alphaTwoCode: (map['alpha_two_code'] ?? '') as String,
      domains: (map['domains'] ?? []) as List<dynamic>,
      webPages: (map['web_pages'] ?? []) as List<dynamic>,
    );
  }
}
