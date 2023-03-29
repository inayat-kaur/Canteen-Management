const db = require('./db');

async function addItem(menuItem) {
  const conn = await db.getConnection();
  const [result] = await conn.query('INSERT INTO menu SET ?', menuItem);
  conn.release();
  return { id: result.insertId };
}

async function deleteItem(item) {
  const conn = await db.getConnection();
  const [result] = await conn.query('DELETE FROM menu WHERE item = ?', [item]);
  conn.release();
  if (result.affectedRows === 0) {
    throw new Error(`Menu item ${item} not found`);
  }
  return { item: item };
}

async function updatePrice(item, price) {
  const conn = await db.getConnection();
  const [result] = await conn.query('UPDATE menu SET price = ? WHERE item = ?', [price, item]);
  conn.release();
  if (result.affectedRows === 0) {
    throw new Error(`Menu item ${item} not found`);
  } 
  return { item: item };
}

async function updateAvailability(item, availability) {
  const conn = await db.getConnection();
  const [result] = await conn.query('UPDATE menu SET availability = ? WHERE item = ?', [availability, item]);
  conn.release();
  if (result.affectedRows === 0) {
    throw new Error(`Menu item ${item} not found`);
  }
  return { item: item };
}

async function updateRating(item, rating) {
  const conn = await db.getConnection();
  const [result] = await conn.query('UPDATE menu SET rating = ? WHERE item = ?', [rating, item]);
  conn.release();
  if (result.affectedRows === 0) {
    throw new Error(`Menu item ${item} not found`);
  }
  return { item: item };
}

async function getMenu() {
  const conn = await db.getConnection();
  const [rows] = await conn.query('SELECT * FROM menu');
  conn.release();
  return rows;
}

module.exports = {
  addItem,
  deleteItem,
  updatePrice,
  updateAvailability,
  updateRating,
  getMenu,
};


