const express = require('express');
const authService = require('../services/authService');

const router = express.Router();

router.post('/signUp', async (req, res, next) => {
    try {
        const user = req.body;
        const result = await authService.signUp(user);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
});

router.post('/login', async (req, res, next) => {
    try {
        const username = req.body.username;
        const password = req.body.password;
        const result = await authService.login(username, password);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
});

module.exports = router;