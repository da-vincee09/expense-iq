import 'dart:io';
import 'package:expense_iq/features/profile/data/models/profile_model.dart';
import 'package:expense_iq/features/profile/domain/repositories/profile_repository.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository{

  final SupabaseClient supabase;

  ProfileRepositoryImpl({required this.supabase});

  @override
  Future<ProfileModel> getProfile() async {
    final user = supabase.auth.currentUser;

    if(user == null) {
      throw Exception("User not authenticated.");
    }

    final response = await supabase
      .from('profiles')
      .select()
      .eq('id', user.id)
      .single();
    
    return ProfileModel.fromJson(response);
  } 

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    await supabase
    .from('profiles')
    .update({
      'name': profile.name,
      'monthly_budget': profile.monthlyBudget,
      'profile_image': profile.profileImage,
      'updated_at': DateTime.now().toIso8601String(),
    })
    .eq('id', profile.id);
  }

   @override
  Future<String> uploadProfileImage(File image) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User is not authenticated");
    }

    final fileName = '${user.id}/profile${path.extension(image.path)}';

    await supabase.storage
        .from('profile-images')
        .upload(fileName, image);

    return supabase.storage
        .from('profile-images')
        .getPublicUrl(fileName);
  }

  @override
  Future<void> updateProfileImage(String imageUrl) async {
    final user = supabase.auth.currentUser!;

    await supabase
        .from('profiles')
        .update({
          'profile_image': imageUrl,
        })
        .eq('id', user.id);
  }
}