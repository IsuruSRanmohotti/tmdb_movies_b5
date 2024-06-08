class ActorModel {
  String name;
  String character;
  String? image;

  ActorModel({required this.character, required this.name, this.image});

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(character: json['character'], name: json['name'],image: json['profile_path'] == null ? 'https://cdn-icons-png.freepik.com/256/1154/1154989.png?semt=ais_hybrid': 'https://image.tmdb.org/t/p/w500${json['profile_path']}');
  }
}
