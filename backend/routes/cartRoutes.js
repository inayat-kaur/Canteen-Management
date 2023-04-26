const express = require('express');
const cartService = require('../services/cartService');
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
    const result = await cartService.deleteItem(username, item);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.get('/getMyCart', authenticateToken, async (req, res, next) => {
  try {
    username = req.user.username;
    const menu = await menuService.getMyCart(username);
    res.status(200).json(menu);
  } catch (err) {
    next(err);
  }
});

router.put('/updateQuantity/:id', authenticateToken, async (req, res, next) => {
  try {
    username = req.user.username;
    const item = req.params.id;
    const quantity = req.body.quantity;
    const result = await menuService.updatePrice(username, item, quantity);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

module.exports = router;