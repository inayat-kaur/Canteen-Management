const db = require('./db');

async function addItem(menuItem) {
  if (!menuItem || !menuItem.item || !menuItem.price || !menuItem.availability || !menuItem.rating) {
    throw new Error('Missing or invalid menu item');
  }
  const queryStmt = `INSERT INTO menu (item, price, availability, rating, category, type, image) VALUES (?, ?, ?, ?,?,?,?)`;
  const values = [menuItem.item, menuItem.price, menuItem.availability, menuItem.rating, menuItem.category, menuItem.type, menuItem.image];
  const result = await db.query(queryStmt, values);

  let message = 'Error in inserting an item in menu';

  if (result.affectedRows) {
    message = `${menuItem.item} added to menu`;
  }

  return { message };
}

async function deleteItem(item) {
  const result = await db.query('DELETE FROM menu WHERE item = ?', [item]);

  let message = 'Error in deleting an item from menu';

  if (result.affectedRows) {
    message = `${item} deleted from menu`;
  }

  return { message };
}

async function updatePrice(item, price) {
  const result = await db.query('UPDATE menu SET price = ? WHERE item = ?', [price, item]);
  let message = 'Error in updating price';

  if (result.affectedRows) {
    message = `price updated to ${price} for ${item}`;
  }

  return { message };
}

async function updateAvailability(item, availability) {
  const result = await db.query('UPDATE menu SET availability = ? WHERE item = ?', [availability, item]);
  let message = 'Error in updating availability';

  if (result.affectedRows) {
    message = `availability updated to ${availability} for ${item}`;
  }

  return { message };
}

async function updateRating(item, rating) {
  const result = await db.query('UPDATE menu SET rating = ? WHERE item = ?', [rating, item]);

  let message = 'Error in updating rating';

  if (result.affectedRows) {
    message = `rating updated to ${rating} for ${item}`;
  }

  return { message };
}

async function getMenu() {
  //const conn = await db.getConnection();
  const rows = await db.query('SELECT * FROM menu');
  //conn.release();
  return rows;
}

async function getCategories() {
  const rows = await db.query('SELECT DISTINCT category FROM menu');
  return rows;
}

module.exports = {
  addItem,
  deleteItem,
  updatePrice,
  updateAvailability,
  updateRating,
  getMenu,
  getCategories
};


