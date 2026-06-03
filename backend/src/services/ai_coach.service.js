const { GoogleGenerativeAI } = require("@google/generative-ai");
const NodeCache = require("node-cache");
const prompts = require('../utils/ai_prompts');
const User = require('../models/user.model');

// Cache AI responses for 1 hour to save API costs on repeated questions
const aiCache = new NodeCache({ stdTTL: 3600 });
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

class AICoachService {
    async askCoach(userId, userMessage) {
        // 1. Check Cache
        const cacheKey = `${userId}_${userMessage.toLowerCase().trim()}`;
        if (aiCache.has(cacheKey)) return aiCache.get(cacheKey);

        // 2. Fetch Context (Mocked stats for brevity, in prod fetch from DB)
        const user = await User.findByPk(userId);
        const stats = { weeklyVolume: 4500, todaySteps: 8432 };

        // 3. Initialize Gemini
        const model = genAI.getGenerativeModel({ model: "gemini-pro" });
        const chat = model.startChat({
            history: [
                { role: "user", parts: [{ text: prompts.SYSTEM_PROMPT(user, stats) }] },
                { role: "model", parts: [{ text: "Understood. I am ready to coach." }] },
            ],
        });

        const result = await chat.sendMessage(userMessage);
        const responseText = result.response.text();

        // 4. Save to Cache
        aiCache.set(cacheKey, responseText);
        return responseText;
    }
}

module.exports = new AICoachService();