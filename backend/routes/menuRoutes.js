const express = require('express');
const menuService = require('../services/menuService');

const router = express.Router();

router.post('/addItem', async (req, res, next) => {
  try {
    const menuItem = req.body;
    const result = await menuService.addItem(menuItem);
    res.status(201).json(result);
  } catch (err) {
    next(err);
  }
});

router.delete('/deleteItem/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const result = await menuService.deleteItem(id);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.put('/updatePrice/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const menuItem = req.body;
    const result = await menuService.updatePrice(id, menuItem);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.put('/updateAvailability/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const menuItem = req.body;
    const result = await menuService.updateAvailability(id, menuItem);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.put('/updateRating/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const menuItem = req.body;
    const result = await menuService.updateRating(id, menuItem);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
});

router.get('/getMenu', async (req, res, next) => {
  try {
    const menu = await menuService.getMenu();
    res.status(200).json(menu);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
