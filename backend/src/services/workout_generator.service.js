const { WorkoutPlan, WorkoutDay, WorkoutExercise } = require('../models/workout_plan.model');
const Exercise = require('../models/exercise.model');
const { Op, Sequelize } = require('sequelize');

class WorkoutGeneratorService {
    // 1. Configuration Mapping
    static splits = {
        3: ["Push", "Pull", "Legs"],
        4: ["Upper", "Lower", "Push", "Pull"],
        5: ["Chest", "Back", "Legs", "Shoulders", "Arms"],
        6: ["Push", "Pull", "Legs", "Push", "Pull", "Legs"]
    };

    static muscleMapping = {
        "Push": ["chest", "shoulders"],
        "Pull": ["back"],
        "Legs": ["legs"],
        "Upper": ["chest", "back", "shoulders"],
        "Lower": ["legs", "core"],
        "Chest": ["chest"],
        "Back": ["back"],
        "Shoulders": ["shoulders"],
        "Arms": ["arms"]
    };

    async generate(userId, { goal, experience, daysPerWeek }) {
        // Deactivate old plans
        await WorkoutPlan.update({ isActive: false }, { where: { userId } });

        const plan = await WorkoutPlan.create({ userId, goal, experience, daysPerWeek });
        const dayNames = WorkoutGeneratorService.splits[daysPerWeek];
        const exerciseCount = experience === 'beginner' ? 4 : (experience === 'intermediate' ? 5 : 6);

        for (let i = 0; i < dayNames.length; i++) {
            const day = await WorkoutDay.create({ planId: plan.id, dayName: dayNames[i], dayNumber: i + 1 });
            const targetMuscles = WorkoutGeneratorService.muscleMapping[dayNames[i]] || ["full_body"];
            
            // Fetch random exercises for the muscle groups
            const exercises = await Exercise.findAll({
                where: { muscleGroup: { [Op.in]: targetMuscles } },
                order: Sequelize.literal('RAND()'),
                limit: exerciseCount
            });

            const exerciseLogs = exercises.map((ex, index) => {
                const { sets, reps } = this.calculateSetsReps(goal, index === 0); // index 0 is compound
                return {
                    dayId: day.id,
                    exerciseId: ex.id,
                    sets,
                    reps,
                    order: index
                };
            });
            await WorkoutExercise.bulkCreate(exerciseLogs);
        }
        return this.getPlanDetails(plan.id);
    }

    calculateSetsReps(goal, isCompound) {
        if (goal === 'strength') return { sets: 5, reps: isCompound ? "5" : "8" };
        if (goal === 'muscle_gain') return { sets: isCompound ? 4 : 3, reps: isCompound ? "8" : "12" };
        if (goal === 'fat_loss') return { sets: 3, reps: "15" };
        return { sets: 3, reps: "10" };
    }

    async getPlanDetails(planId) {
        return await WorkoutPlan.findByPk(planId, {
            include: [{
                model: WorkoutDay, as: 'days',
                include: [{ model: WorkoutExercise, as: 'exercises', include: ['details'] }]
            }]
        });
    }
}

module.exports = new WorkoutGeneratorService();