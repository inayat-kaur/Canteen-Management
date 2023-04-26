const db = require('./db');
//const { v4: uuidv4 } = require('uuid');

async function addOrder(order, username) {
    if(!order || !order.orderId || !order.item || username || !order.orderType || !order.quantity){
        throw new Error('Missing or invalid order');
    }

    const delivery_time = order.delivery_time ? new Date(order.delivery_time).toISOString().slice(0, 19).replace('T', ' ') : null;
    //const orderId = uuidv4();

    const queryStmt = `INSERT INTO orders (orderId, username, orderType, item, quantity, order_status, payment_status, delivery_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;
    const values = [order.orderId, username, order.orderType, order.item, order.quantity, order.order_status, order.payment_status, delivery_time];
    const result = await db.query(queryStmt, values);

    let message = 'Error in inserting an order';

    if(result.affectedRows){
        message = `Order ${order.orderId} added`;
    }

    return {message};

}

async function deleteOrder(orderId, item) {
    const result = await db.query('DELETE FROM orders WHERE orderId = ? and item = ?', [orderId, item]);

    let message = 'Error in deleting an order';

    if(result.affectedRows){
        message = `Order ${orderId} deleted`;
    }

    return {message};
}

async function updateOrderStatus(orderId, orderStatus, item) {
    const result = await db.query('UPDATE orders SET order_status = ? WHERE orderId = ? and item = ?', [orderStatus, orderId, item]);

    let message = 'Error in updating order status';

    if(result.affectedRows){
        message = `Order ${orderId} status updated to ${orderStatus}`;
    }

    return {message};
}

async function updatePaymentStatus(orderId, paymentStatus, item) {
    const result = await db.query('UPDATE orders SET payment_status = ? WHERE orderId = ? and item = ?', [paymentStatus, orderId, item]);

    let message = 'Error in updating payment status';

    if(result.affectedRows){
        message = `Order ${orderId} payment status updated to ${paymentStatus}`;
    }

    return {message};
}

// getOrders

async function getOrders() {
    const result = await db.query('SELECT * FROM orders');

    return result;
}

// getOrdersByUser
async function getOrdersByUser(username) {
    const result = await db.query('SELECT * FROM orders WHERE username = ?', [username]);

    return result;
}

// getOrdersByStatus
async function getOrdersByStatus(orderStatus) {
    const result = await db.query('SELECT * FROM orders WHERE order_status = ?', [orderStatus]);

    return result;
}

// getOrdersByPaymentStatus
async function getOrdersByPaymentStatus(paymentStatus) {
    const result = await db.query('SELECT * FROM orders WHERE payment_status = ?', [paymentStatus]);

    return result;
}

module.exports = {
    addOrder,
    deleteOrder,
    updateOrderStatus,
    updatePaymentStatus,
    getOrders,
    getOrdersByUser,
    getOrdersByStatus,
    getOrdersByPaymentStatus
}