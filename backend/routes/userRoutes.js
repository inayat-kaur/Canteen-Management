const express = require('express');
const userService = require('../services/userService');

const router = express.Router();

// addUser
router.post('/addUser', async (req, res, next) => {
    try {
        const user = req.body;
        const result = await userService.addUser(user);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
});

// updatePhone
router.put('/updatePhone/:id', async (req, res, next) => {
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
router.put('/updateName/:id', async (req, res, next) => {
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
router.get('/getProfile/:id', async (req, res, next) => {
    try {
        const id = req.params.id;
        const result = await userService.getProfile(id);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

module.exports = router;