const User = require('../models/user.model');
const jwt = require('jsonwebtoken');
const { OAuth2Client } = require('google-auth-library');
const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

class AuthService {
    generateTokens(user) {
        const accessToken = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '15m' });
        const refreshToken = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '7d' });
        return { accessToken, refreshToken };
    }

    async register(email, password, displayName) {
        const existingUser = await User.findOne({ where: { email } });
        if (existingUser) throw new Error('User already exists');
        return await User.create({ email, password, displayName });
    }

    async login(email, password) {
        const user = await User.findOne({ where: { email } });
        if (!user || !(await user.comparePassword(password))) {
            throw new Error('Invalid credentials');
        }
        return { user, ...this.generateTokens(user) };
    }

    async googleLogin(idToken) {
        const ticket = await client.verifyIdToken({
            idToken,
            audience: process.env.GOOGLE_CLIENT_ID
        });
        const { email, sub: googleId, name } = ticket.getPayload();
        
        let user = await User.findOne({ where: { email } });
        if (!user) {
            user = await User.create({ email, googleId, displayName: name, isVerified: true });
        }
        return { user, ...this.generateTokens(user) };
    }
}

module.exports = new AuthService();