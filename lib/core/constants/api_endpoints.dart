class ApiEndpoints {
  ApiEndpoints._();

  // ─── Base ──────────────────────────────────────────────────
  // Android emulator → 10.0.2.2 maps to your PC's localhost
  // Real device (same WiFi) → use your PC IP e.g. 192.168.1.5
  static const baseUrl = 'http://10.0.2.2:5000';

  // ─── Auth → /api/auth ──────────────────────────────────────
  static const login        = '/api/auth/login';
  static const register     = '/api/auth/register';
  static const refreshToken = '/api/auth/refresh-token';
  static const logout       = '/api/auth/logout';

  // ─── Exercises → /api/exercises ────────────────────────────
  static const exercises      = '/api/exercises';
  static const exerciseDetail = '/api/exercises/:id';

  // ─── Steps → /api/steps ────────────────────────────────────
  static const stepsSync   = '/api/steps/sync';
  static const stepsTrends = '/api/steps/trends';
  static const stepsToday  = '/api/steps/today';

  // ─── AI Coach → /api/coach ─────────────────────────────────
  static const aiChat = '/api/coach/ask';
  static const workoutFinish = '/api/tracking/finish'; // append /:id in code
  static const logSet        = '/api/tracking/set';

  // ─── Dashboard → /api/dashboard ────────────────────────────
  static const dashboard    = '/api/dashboard';
  static const achievements = '/api/dashboard/achievements';
  static const leaderboard  = '/api/dashboard/leaderboard';
  static const recovery     = '/api/dashboard/recovery';
}