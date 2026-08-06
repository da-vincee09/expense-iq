import 'package:expense_iq/features/profile/data/models/profile_model.dart';
import 'package:expense_iq/features/profile/domain/repositories/profile_repository.dart';
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

    // ignore: avoid_print
    print(response);
    
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
}