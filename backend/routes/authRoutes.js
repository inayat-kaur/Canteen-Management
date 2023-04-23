const express = require('express');
const authService = require('../services/authService');
const mailController = require('../services/mailService');
const { authenticateToken } = require('../services/authService');

const router = express.Router();

OTPs = [];

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

router.post('/mailOTP', async (req, res, next) => {
    try {
        present = false;
        const OTP = mailController.generateOTP();
        for(i=0; i<OTPs.length; i++){
            if(OTPs[i][0] == req.body.username){
                OTPs[i][1] = OTP;
                present = true;
                break;
            }
        }
        if(!present)OTPs.push([req.body.username, OTP]);
        mailController.sendMail(req.body.username, 'OTP for password reset', `Your OTP is ${OTP}`)
        res.status(201).json("OTP sent");
    } catch (err) {
        next(err);
    }
});

router.post('/resetPassword1', authenticateToken , async (req, res, next) => {
    try {
        const username = req.user.username;
        const password = req.body.password;
        const result = await authService.resetPassword(username, password);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
});

router.post('/resetPassword2', async (req, res, next) => {
    try {
        match = false;
        const username = req.body.username;
        const password = req.body.password;
        const OTP = req.body.OTP;
        for(i=0; i<OTPs.length; i++){
            if(OTPs[i][0] == username){
                if(OTPs[i][1] == OTP){
                    OTPs.splice(i, 1);
                    match = true;
                    break;
                }
                else{
                    res.status(201).json("Wrong OTP");
                    return;
                }
            }
        }
        if(match) {
            const result = await authService.resetPassword(username, password);
            res.status(201).json(result);
        }else{
            res.status(201).json("No OTP for this account");
            return;
        }
    } catch (err) {
        next(err);
    }
});


module.exports = router;