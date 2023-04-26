const db = require('./db');

async function addItem(cartItem) {
    if (!cartItem.item || !cartItem.username) {
      throw new Error('Missing or invalid menu item');
    }

    const queryStmt = `INSERT INTO cart (username, item, quantity) VALUES (?, ?, ?, ?)`;
    const values = [cartItem.username,cartItem.item,cartItem.quantity];
    const result = await db.query(queryStmt, values);
  
    let message = 'Error in inserting an item in menu';
  
    if (result.affectedRows) {
      message = `${cartItem.item} added to menu`;
    }
  
    return {message};
}

  
async function deleteItem(username, item) {
    const result = await db.query('DELETE FROM menu WHERE username=? and item = ?',[username], [item]);
  
    let message = 'Error in deleting an item from menu';
  
    if (result.affectedRows) {
      message = `${item} deleted from menu`;
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
    getMyCart,
    updateQuantity
};


