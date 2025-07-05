class SupabaseConfig {
  // Local development configuration
  static const String localUrl = 'http://127.0.0.1:54321';
  static const String localAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
  static const String localServiceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU';
  
  // Production configuration (replace with your actual Supabase project details)
  static const String productionUrl = 'https://your-project.supabase.co';
  static const String productionAnonKey = 'your-production-anon-key';
  
  // Get configuration based on environment
  static String get url {
    // For now, always use local for testing
    return localUrl;
  }
  
  static String get anonKey {
    // For now, always use local for testing
    return localAnonKey;
  }
  
  static String get serviceRoleKey {
    // For now, always use local for testing
    return localServiceRoleKey;
  }
} 