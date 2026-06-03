const authService = require('../services/auth.service');

exports.register = async (req, res, next) => {
    try {
        const { email, password, displayName } = req.body;
        const user = await authService.register(email, password, displayName);
        res.status(201).json({ message: 'User registered successfully', userId: user.id });
    } catch (error) {
        next(error);
    }
};

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const result = await authService.login(email, password);
        res.json(result);
    } catch (error) {
        res.status(401);
        next(error);
    }
};

exports.googleAuth = async (req, res, next) => {
    try {
        const { idToken } = req.body;
        const result = await authService.googleLogin(idToken);
        res.json(result);
    } catch (error) {
        next(error);
    }
};

exports.refreshToken = async (req, res) => {
    const { token } = req.body;
    if (!token) return res.sendStatus(401);
    
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) return res.sendStatus(403);
        const accessToken = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '15m' });
        res.json({ accessToken });
    });
};