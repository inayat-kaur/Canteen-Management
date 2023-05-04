// const cartService = require('../../services/cartService');
// const db = require('../../services/db');

// describe('addItem', () => {
// //   beforeAll(async () => {
// //     // Connect to the database before running tests
// //     await db.connect();
// //   });

// //   afterAll(async () => {
// //     // Disconnect from the database after running tests
// //     await db.disconnect();
// //   });

//   afterEach(async () => {
//     // Delete all rows from the cart table after each test
//     await db.query('DELETE FROM cart');
//   });

//   test('adds an item to the cart', async () => {
//     const cartItem = { item: 'Coke', quantity: 2 };
//     const username = 'test_customer@gmail.com';

//     const result = await cartService.addItem(cartItem, username);

//     expect(result).toEqual({ message: 'Coke added to cart' });

//     // Check that the item was added to the database
//     const rows = await db.query('SELECT * FROM cart');
//     expect(rows.length).toBe(1);
//     expect(rows[0].username).toBe(username);
//     expect(rows[0].item).toBe(cartItem.item);
//     expect(rows[0].quantity).toBe(cartItem.quantity);
//   });

//   test('throws an error when item or username is missing', async () => {
//     const cartItem = { item: 'Coke' };
//     const username = null;

//     await expect(cartService.addItem(cartItem, username)).rejects.toThrow('Missing or invalid cart item');
//   });

//   test('throws an error when item or username is empty', async () => {
//     const cartItem = { item: '', quantity: 2 };
//     const username = '';

//     await expect(cartService.addItem(cartItem, username)).rejects.toThrow('Missing or invalid cart item');
//   });

//   test('handles errors from the database', async () => {
//     const cartItem = { item: 'Coke', quantity: 2 };
//     const username = 'test_customer@gmail.com';

//     // Disconnect from the database to simulate an error
//     //await db.disconnect();

//     await expect(cartService.addItem(cartItem, username)).rejects.toThrow('Unable to perform database operation');

//     // Reconnect to the database for the remaining tests
//     //await db.connect();
//   });
// });
