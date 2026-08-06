class ProfileModel {

  final String id;
  final String name;
  final String email;
  final double monthlyBudget;
  final String? profileImage;

  const ProfileModel({
    required this.id, 
    required this.name, 
    required this.email, 
    required this.monthlyBudget, 
    this.profileImage
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      monthlyBudget:
          (json['monthly_budget'] as num?)?.toDouble() ?? 0,
      profileImage: json['profile_image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'monthly_budget': monthlyBudget,
      'profile_image': profileImage,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    double? monthlyBudget,
    String? profileImage,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      profileImage: profileImage ?? this.profileImage,
    );
  } 
}