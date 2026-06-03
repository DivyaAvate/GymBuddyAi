final userLevelProvider = FutureProvider((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get('/user/profile'); // Returns {level, xp, totalXpForNextLevel}
  return response.data;
});

final badgesProvider = FutureProvider<List<AchievementModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get('/gamification/badges');
  return (response.data as List).map((e) => AchievementModel(
    name: e['name'],
    description: e['description'],
    iconUrl: e['badge_icon_url'],
    isUnlocked: e['isUnlocked'],
  )).toList();
});