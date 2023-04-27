const express = require('express');
const menuService = require('../services/menuService');
const { authenticateToken } = require('../services/authService');
const router = express.Router();

router.post('/addItem', authenticateToken, async (req, res, next) => {
  try {
    const menuItem = req.body;
    const result = await menuService.addItem(menuItem);
    res.status(201).json(result);
  } catch (err) {
    next(err);
  }
});

router.delete('/deleteItem/:id', authenticateToken, async (req, res, next) => {
  try {
    const id = req.params.id;
    const result = await menuService.deleteItem(id);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.put('/updatePrice/:id', authenticateToken, async (req, res, next) => {
  try {
    const id = req.params.id;
    const menuItem = req.body;
    const result = await menuService.updatePrice(id, menuItem.price);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.put('/updateAvailability/:id', authenticateToken, async (req, res, next) => {
  try {
    const id = req.params.id;
    const menuItem = req.body;
    const result = await menuService.updateAvailability(id, menuItem.availability);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.put('/updateRating/:id', authenticateToken, async (req, res, next) => {
  try {
    const id = req.params.id;
    const menuItem = req.body;
    const result = await menuService.updateRating(id, menuItem.rating);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.get('/getMenu', authenticateToken, async (req, res, next) => {
  try {
    const menu = await menuService.getMenu();
    res.status(200).json(menu);
  } catch (err) {
    next(err);
  }
});

router.get('/getCategories', authenticateToken, async (req, res, next) => {
  try {
    const category = await menuService.getCategory();
    res.status(200).json(category);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
