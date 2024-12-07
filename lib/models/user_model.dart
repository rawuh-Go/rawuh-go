class UserModel {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String address;
  final String phoneNumber;
  final String country;
  final String jobPosition;
  final String createdAt;
  final String? image; // Optional for user image

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.country,
    required this.jobPosition,
    required this.createdAt,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      country: json['country'],
      jobPosition: json['job_position'],
      createdAt: json['created_at'],
      image: json['image'], // Adjust based on your API response
    );
  }
}
