import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import '../../../../core/util/api_client.dart';
import '../models/steps_model.dart';

final stepsProvider = StateNotifierProvider<StepsNotifier, AsyncValue<List<StepTrend>>>((ref) {
  return StepsNotifier(ref.watch(dioProvider));
});

class StepsNotifier extends StateNotifier<AsyncValue<List<StepTrend>>> {
  final _dio;
  StepsNotifier(this._dio) : super(const AsyncValue.loading());

  final HealthFactory health = HealthFactory();

  Future<void> fetchAndSyncSteps() async {
    state = const AsyncValue.loading();
    try {
      // 1. Request Permissions
      var types = [HealthDataType.STEPS];
      bool requested = await health.requestAuthorization(types);

      if (requested) {
        // 2. Fetch steps for the last 7 days
        var now = DateTime.now();
        var lastWeek = now.subtract(const Duration(days: 7));
        int? steps = await health.getTotalStepsInInterval(lastWeek, now);

        // 3. Sync today's steps to backend
        await _dio.post('/steps/sync', data: {
          'steps': steps ?? 0,
          'date': "${now.year}-${now.month}-${now.day}"
        });

        // 4. Get trends from backend
        final response = await _dio.get('/steps/trends');
        final List data = response.data;
        state = AsyncValue.data(data.map((e) => StepTrend(
          date: DateTime.parse(e['date']), 
          steps: e['steps']
        )).toList());
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}