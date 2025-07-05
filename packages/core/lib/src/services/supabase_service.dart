import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();
  
  SupabaseService._();
  
  SupabaseClient get client => Supabase.instance.client;
  
  /// Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
  }
  
  /// Test database connection
  Future<Map<String, dynamic>> testConnection() async {
    try {
      // Test basic connection by fetching a simple query
      final response = await client
          .from('profiles')
          .select('*')
          .limit(1);
      
      return {
        'status': 'success',
        'message': 'Database connection successful',
        'data': response,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Database connection failed: ${e.toString()}',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Get all tables info
  Future<Map<String, dynamic>> getTablesInfo() async {
    try {
      final tables = ['profiles', 'banks', 'credit_cards', 'transactions'];
      final results = <String, dynamic>{};
      
      for (final table in tables) {
        try {
          final response = await client
              .from(table)
              .select('*')
              .limit(5);
          
          results[table] = {
            'count': response.length,
            'sample_data': response,
          };
        } catch (e) {
          results[table] = {
            'error': e.toString(),
          };
        }
      }
      
      return {
        'status': 'success',
        'tables': results,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to get tables info: ${e.toString()}',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Create a test profile
  Future<Map<String, dynamic>> createTestProfile() async {
    try {
      final testProfile = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': 'test@example.com',
        'full_name': 'Test User',
        'avatar_url': null,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      final response = await client
          .from('profiles')
          .insert(testProfile);
      
      return {
        'status': 'success',
        'message': 'Test profile created successfully',
        'data': response,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to create test profile: ${e.toString()}',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    try {
      final tables = ['profiles', 'banks', 'credit_cards', 'transactions'];
      final stats = <String, int>{};
      
      for (final table in tables) {
        try {
          final response = await client
              .from(table)
              .select('*');
          
          stats[table] = response.length;
        } catch (e) {
          stats[table] = -1; // Error indicator
        }
      }
      
      return {
        'status': 'success',
        'stats': stats,
        'total_records': stats.values.where((count) => count > 0).fold(0, (sum, count) => sum + count),
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to get database stats: ${e.toString()}',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
} 