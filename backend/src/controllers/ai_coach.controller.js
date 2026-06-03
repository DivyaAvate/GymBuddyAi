const aiService = require('../services/ai_coach.service');

exports.chat = async (req, res, next) => {
    try {
        const { message } = req.body;
        if (!message) return res.status(400).json({ message: "Message is required" });

        const reply = await aiService.askCoach(req.user.id, message);
        res.json({ reply });
    } catch (e) {
        next(e);
    }
};