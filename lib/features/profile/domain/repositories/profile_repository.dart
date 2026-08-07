import 'dart:io';
import 'package:expense_iq/features/profile/data/models/profile_model.dart';

/// Defines the contract for profile data operations.
///
/// Provides methods for retrieving and updating user profile information,
/// including profile image management.
abstract interface class ProfileRepository {
  Future<ProfileModel> getProfile();

  Future<void> updateProfile(ProfileModel profile);

  Future<String> uploadProfileImage(File image);

  Future<void> updateProfileImage(String imageUrl);
}