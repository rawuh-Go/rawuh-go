class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String jobPosition;
  final String address;
  final String country;
  final String gender;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.jobPosition,
    required this.address,
    required this.country,
    required this.gender,
  });

  // Factory method untuk mempermudah parsing dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      jobPosition: json['job_position'] ?? '',
      address: json['address'] ?? '',
      country: json['country'] ?? 'Indonesia',
      gender: json['gender'] == 'laki-laki' ? 'laki-laki' : 'perempuan',
    );
  }
}
