const User = require('../models/user.model');
const { Achievement, UserAchievement, XpLog } = require('../models/gamification.model'); // Defined from schema above
const constants = require('../utils/gamification_constants');

class GamificationService {
    // 1. Core Logic: Add XP and Check for Level Up
    async addXp(userId, amount, reason) {
        const user = await User.findByPk(userId);
        let newXp = user.xp + amount;
        let newLevel = user.level;

        // Level Calculation: Exponential (Level * 500 * multiplier)
        let xpRequired = Math.floor(newLevel * constants.LEVEL_BASE_XP * constants.LEVEL_MULTIPLIER);
        
        let leveledUp = false;
        while (newXp >= xpRequired) {
            newXp -= xpRequired;
            newLevel++;
            leveledUp = true;
            xpRequired = Math.floor(newLevel * constants.LEVEL_BASE_XP * constants.LEVEL_MULTIPLIER);
        }

        await user.update({ xp: newXp, level: newLevel });
        await XpLog.create({ user_id: userId, amount, reason });

        if (leveledUp) {
            // Trigger a push notification or system message
            console.log(`User ${userId} leveled up to ${newLevel}!`);
        }

        // Check for achievements whenever XP is added
        await this.checkAchievements(userId);
        
        return { newXp, newLevel, leveledUp };
    }

    // 2. Achievement Engine: Check criteria
    async checkAchievements(userId) {
        // Example: Logic for "Total Workouts"
        const workoutCount = await WorkoutLog.count({ where: { user_id: userId, status: 'completed' } });
        
        const eligibleAchievements = await Achievement.findAll({
            where: {
                criteria_type: 'total_workouts',
                criteria_value: { [Op.lte]: workoutCount }
            }
        });

        for (const ach of eligibleAchievements) {
            // Find or Create to ensure we don't duplicate badges
            const [earned, created] = await UserAchievement.findOrCreate({
                where: { user_id: userId, achievement_id: ach.id }
            });
            
            if (created) {
                await this.addXp(userId, ach.xp_reward, `Unlocked Badge: ${ach.name}`);
            }
        }
    }
}

module.exports = new GamificationService();