import 'package:expense_iq/features/profile/data/models/profile_model.dart';
import 'package:expense_iq/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repository;

  ProfileProvider(this._repository);

  ProfileModel? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ImagePicker _picker = ImagePicker();

 Future<void> pickAndUploadProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final imageFile = File(pickedFile.path);

      final imageUrl =
          await _repository.uploadProfileImage(imageFile);

      await _repository.updateProfileImage(imageUrl);

      _profile = _profile?.copyWith(
        profileImage: imageUrl,
      );

      await loadProfile();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProfile() async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profile = await _repository.getProfile();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(ProfileModel profile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.updateProfile(profile);
      _profile = profile;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}