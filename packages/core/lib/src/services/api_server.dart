import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'supabase_service.dart';

class ApiServer {
  static ApiServer? _instance;
  static ApiServer get instance => _instance ??= ApiServer._();
  
  ApiServer._();
  
  late final SupabaseService _supabaseService;
  
  /// Initialize the API server
  Future<void> initialize() async {
    _supabaseService = SupabaseService.instance;
    await SupabaseService.initialize();
  }
  
  /// Create the router with all API routes
  Router createRouter() {
    final router = Router();
    
    // Health check endpoint
    router.get('/health', (Request request) {
      return Response.ok(
        jsonEncode({
          'status': 'ok',
          'message': 'API server is running',
          'timestamp': DateTime.now().toIso8601String(),
        }),
        headers: {'content-type': 'application/json'},
      );
    });
    
    // Test database connection
    router.get('/api/init/test-connection', (Request request) async {
      try {
        final result = await _supabaseService.testConnection();
        return Response.ok(
          jsonEncode(result),
          headers: {'content-type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'status': 'error',
            'message': 'Internal server error: ${e.toString()}',
            'timestamp': DateTime.now().toIso8601String(),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    });
    
    // Get database statistics
    router.get('/api/init/stats', (Request request) async {
      try {
        final result = await _supabaseService.getDatabaseStats();
        return Response.ok(
          jsonEncode(result),
          headers: {'content-type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'status': 'error',
            'message': 'Internal server error: ${e.toString()}',
            'timestamp': DateTime.now().toIso8601String(),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    });
    
    // Get tables information
    router.get('/api/init/tables', (Request request) async {
      try {
        final result = await _supabaseService.getTablesInfo();
        return Response.ok(
          jsonEncode(result),
          headers: {'content-type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'status': 'error',
            'message': 'Internal server error: ${e.toString()}',
            'timestamp': DateTime.now().toIso8601String(),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    });
    
    // Create test profile
    router.post('/api/init/create-test-profile', (Request request) async {
      try {
        final result = await _supabaseService.createTestProfile();
        return Response.ok(
          jsonEncode(result),
          headers: {'content-type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'status': 'error',
            'message': 'Internal server error: ${e.toString()}',
            'timestamp': DateTime.now().toIso8601String(),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    });
    
    // Comprehensive init endpoint
    router.get('/api/init', (Request request) async {
      try {
        final results = <String, dynamic>{};
        
        // Test connection
        results['connection'] = await _supabaseService.testConnection();
        
        // Get stats
        results['stats'] = await _supabaseService.getDatabaseStats();
        
        // Get tables info
        results['tables'] = await _supabaseService.getTablesInfo();
        
        return Response.ok(
          jsonEncode({
            'status': 'success',
            'message': 'Database initialization test completed',
            'results': results,
            'timestamp': DateTime.now().toIso8601String(),
          }),
          headers: {'content-type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'status': 'error',
            'message': 'Internal server error: ${e.toString()}',
            'timestamp': DateTime.now().toIso8601String(),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    });
    
    // Handle 404
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound(
        jsonEncode({
          'status': 'error',
          'message': 'Endpoint not found',
          'available_endpoints': [
            'GET /health',
            'GET /api/init',
            'GET /api/init/test-connection',
            'GET /api/init/stats',
            'GET /api/init/tables',
            'POST /api/init/create-test-profile',
          ],
          'timestamp': DateTime.now().toIso8601String(),
        }),
        headers: {'content-type': 'application/json'},
      );
    });
    
    return router;
  }
  
  /// Start the API server
  Future<void> start({int port = 8080}) async {
    await initialize();
    
    final router = createRouter();
    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addHandler(router);
    
    final server = await io.serve(handler, 'localhost', port);
    
    print('🚀 API Server started on http://localhost:$port');
    print('📋 Available endpoints:');
    print('   GET  /health');
    print('   GET  /api/init');
    print('   GET  /api/init/test-connection');
    print('   GET  /api/init/stats');
    print('   GET  /api/init/tables');
    print('   POST /api/init/create-test-profile');
    print('');
    print('🔗 Test your database: http://localhost:$port/api/init');
  }
} 