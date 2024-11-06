class Actor {
  final String name;
  final String character;
  final String? profilePath;

  Actor({
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      name: map['name'],
      character: map['character'],
      profilePath: map['profile_path'],
    );
  }
}
