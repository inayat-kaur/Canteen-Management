const express = require('express');
const menuService = require('../services/cartService');
const { authenticateToken } = require('../services/authService');
const router = express.Router();

router.post('/addItem', authenticateToken, async (req, res, next) => {
    try {
      const cartItem = req.body;
      const result = await cartService.addItem(cartItem);
      res.status(201).json(result);
    } catch (err) {
      next(err);
    }
  });
  
  router.delete('/deleteItem/:id', authenticateToken, async (req, res, next) => {
    try {
      const username = req.body.username;
      const item = req.params.id;
      const result = await cartService.deleteItem(username,item);
      res.status(200).json(result);
    } catch (err) {
      next(err);
    }
  });

  module.exports = router;