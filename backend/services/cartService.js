const db = require('./db');

async function addItem(cartItem,username) {
    if (!cartItem.item || !username) {
      throw new Error('Missing or invalid cart item');
    }

    const queryStmt = `INSERT INTO cart (username, item, quantity) VALUES (?, ?, ?)`;
    const values = [username,cartItem.item,cartItem.quantity];
    const result = await db.query(queryStmt, values);
  
    let message = 'Error in inserting an item in cart';
  
    if (result.affectedRows) {
      message = `${cartItem.item} added to cart`;
    }
  
    return {message};
}

  
async function deleteItem(username, item) {
    const queryStmt = `DELETE FROM cart WHERE username = ? AND item = ?`;
    const values = [username,item];
    const result = await db.query(queryStmt, values);
  
    let message = 'Error in deleting an item from cart';
  
    if (result.affectedRows) {
      message = `${item} deleted from cart`;
    }
  
    return {message};
}

async function deleteAllItems(username){
    const result = await db.query('DELETE FROM cart WHERE username = ?', [username]);

    let message = 'Error in deleting all items from cart';

    if (result.affectedRows) {
        message = `All items deleted from cart`;
    }

    return {message};
}

async function getMyCart(username){
    const result = await db.query('SELECT * FROM cart WHERE username = ?', [username]);
    return result;
}

async function updateQuantity(username, item, quantity) {
    if(quantity<=0){
        result = deleteItem(username, item);
        return result;
    }
    else{
        result = await db.query('UPDATE cart SET quantity = ? WHERE username = ? AND item = ?', [quantity, username, item]);
        let message = 'Error in updating quantity';

        if (result.affectedRows) {
            message = `quantity updated to ${quantity} for ${item}`;
        }
        return {message};
    }
}

module.exports = {
    addItem,
    deleteItem,
    deleteAllItems,
    getMyCart,
    updateQuantity
};


