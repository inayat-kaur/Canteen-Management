const express = require('express');
const orderService = require('../services/orderService');
const { authenticateToken } = require('../services/authService');

const router = express.Router();

router.post('/addOrder', authenticateToken, async (req, res, next) => {
  try {
    const order = req.body;
    const username = req.user.username;
    const result = await orderService.addOrder(order,username);
    res.status(201).json(result);
  } catch (err) {
    next(err);
  }
});

router.delete('/deleteOrder/:id/:item', authenticateToken, async (req, res, next) => {
    try {
        const id = req.params.id;
        const item = req.params.item;
        const result = await orderService.deleteOrder(id, item);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

router.put('/updateOrderStatus/:id/:item', authenticateToken, async (req, res, next) => {
    try {
        const id = req.params.id;
        const item = req.params.item;
        const order = req.body;
        const result = await orderService.updateOrderStatus(id, order.orderStatus, item);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

router.put('/updatePaymentStatus/:id/:item', authenticateToken, async (req, res, next) => {
    try {
        const id = req.params.id;
        const item = req.params.item;
        const order = req.body;
        const result = await orderService.updatePaymentStatus(id, order.paymentStatus, item);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

router.get('/getOrders', authenticateToken, async (req, res, next) => {
    try {
        const result = await orderService.getOrders();
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

// getOrdersByUser
router.get('/getOrdersByUser/:username', authenticateToken, async (req, res, next) => {
    try {
        const username = req.params.username;
        const result = await orderService.getOrdersByUser(username);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

// getOrdersByStatus
router.get('/getOrdersByStatus/:status', authenticateToken, async (req, res, next) => {
    try {
        const status = req.params.status;
        const result = await orderService.getOrdersByStatus(status);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

// getOrdersByPaymentStatus
router.get('/getOrdersByPaymentStatus/:status', authenticateToken, async (req, res, next) => {
    try {
        const status = req.params.status;
        const result = await orderService.getOrdersByPaymentStatus(status);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
});

module.exports = router;