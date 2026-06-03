const { Op } = require('sequelize');
const sequelize = require('../config/db.config');

exports.syncSteps = async (req, res, next) => {
    try {
        const { steps, date } = req.body; // date: YYYY-MM-DD
        const userId = req.user.id;

        // Use UPSERT (Update if exists, Insert if not)
        const sql = `
            INSERT INTO steps (user_id, step_count, activity_date) 
            VALUES (?, ?, ?) 
            ON DUPLICATE KEY UPDATE step_count = VALUES(step_count)
        `;
        await sequelize.query(sql, { replacements: [userId, steps, date] });
        
        res.status(200).json({ message: "Steps synced" });
    } catch (e) { next(e); }
};

exports.getTrends = async (req, res, next) => {
    try {
        const userId = req.user.id;
        const trends = await sequelize.query(`
            SELECT activity_date as date, step_count as steps 
            FROM steps 
            WHERE user_id = ? 
            ORDER BY activity_date DESC LIMIT 30
        `, { replacements: [userId], type: sequelize.QueryTypes.SELECT });

        res.json(trends);
    } catch (e) { next(e); }
};