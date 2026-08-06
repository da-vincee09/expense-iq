import 'package:expense_iq/features/profile/data/models/profile_model.dart';

abstract interface class ProfileRepository {
  Future<ProfileModel> getProfile();

  Future<void> updateProfile(ProfileModel profile);
}