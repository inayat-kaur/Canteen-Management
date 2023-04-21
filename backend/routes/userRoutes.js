const express = require('express');
const userService = require('../services/userService');
const { authenticateToken } = require('../services/authService');

const router = express.Router();

// updatePhone
router.put('/updatePhone/:id', authenticateToken, async (req, res, next) => {
    try {
        const id = req.params.id;
        const user = req.body;
        const result = await userService.updatePhone(id, user.phone);
        res.status(200).json(result);
    } catch (err) { 
        next(err);
    }
});

// updateName
router.put('/updateName/:id', authenticateToken, async (req, res, next) => {
    try {
        const id = req.params.id;
        const user = req.body;
        const result = await userService.updateName(id, user.name);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

// getProfile
router.get('/getProfile/:id', authenticateToken, async (req, res, next) => {
    try {
        const id = req.params.id;
        const result = await userService.getProfile(id);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

module.exports = router;