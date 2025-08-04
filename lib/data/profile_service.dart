import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';
import 'supabase_client.dart';

class ProfileService {
  final SupabaseClient _supabase = SupabaseService.instance.client;

  Future<Profile?> getProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      if (response != null) {
        return Profile.fromJson(response);
      }
      return null;
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  Future<void> createProfile(Profile profile) async {
    try {
      await _supabase.from('profiles').insert(profile.toJson());
    } catch (e) {
      print('Error creating profile: $e');
      rethrow;
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await _supabase
          .from('profiles')
          .update(profile.toJson())
          .eq('id', profile.id);
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  Future<void> deleteProfile(String userId) async {
    try {
      await _supabase.from('profiles').delete().eq('id', userId);
    } catch (e) {
      print('Error deleting profile: $e');
      rethrow;
    }
  }
} 