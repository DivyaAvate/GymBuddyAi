const { WorkoutLog, ExerciseLog, SetLog } = require('../models/tracking.model');
const { Op } = require('sequelize');

class TrackingService {
    async startSession(userId, planId) {
        return await WorkoutLog.create({ userId, planId, status: 'active' });
    }

    async logSet(exerciseLogId, userId, exerciseId, weight, reps) {
        // Check if this is a PR (Personal Record)
        const maxWeight = await SetLog.max('weight', {
            include: [{
                model: ExerciseLog,
                where: { exerciseId },
                include: [{ model: WorkoutLog, where: { userId } }]
            }]
        });

        const isPR = weight > (maxWeight || 0);
        return await SetLog.create({ exerciseLogId, weight, reps, isPR });
    }

    async finishSession(workoutLogId, notes) {
        const session = await WorkoutLog.findByPk(workoutLogId, {
            include: [{ model: ExerciseLog, as: 'exercises', include: [{ model: SetLog, as: 'sets' }] }]
        });

        // Calculate total volume
        let totalVolume = 0;
        session.exercises.forEach(ex => {
            ex.sets.forEach(set => {
                totalVolume += (set.weight * set.reps);
            });
        });

        return await session.update({ 
            endTime: new Date(), 
            status: 'completed', 
            totalVolume, 
            notes 
        });
    }
}

module.exports = new TrackingService();