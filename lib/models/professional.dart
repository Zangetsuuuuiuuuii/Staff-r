class Professional {
  final int id; // ← Add this line
  final String name;
  final String jobTitle;
  final String location;
  final double rating;
  final String imageUrl;
  final double hourlyRate;

  Professional({
    required this.id, // ← Add this
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.hourlyRate,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'], // ← Add this
      name: json['name'],
      jobTitle: json['jobTitle'],
      location: json['location'],
      rating: json['rating']?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'],
      hourlyRate: json['hourlyRate']?.toDouble() ?? 0.0,
    );
  }
}
