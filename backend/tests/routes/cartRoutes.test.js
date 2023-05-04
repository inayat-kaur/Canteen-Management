const request = require('supertest');
const app = 'https://canteenmanagementserver.onrender.com/cart';
const cartService = require('../../services/cartService');

//Mock the cartService.addItem function
jest.mock('../../services/cartService', () => ({
  addItem: jest.fn(),
}));

describe('/addItem route', () => {
  it('should return 201 status code and call cartService.addItem', async () => {
    // Set up mock data
    const cartItem = { item: 'Item 1', quantity: 1 };
    const username = 'test_customer@gmail.com';
    const token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RfY3VzdG9tZXJAZ21haWwuY29tIiwiaWF0IjoxNjgzMTk3ODY0fQ.KAyY6TCXt8_Jm-CyIHF3n1R-nwvHMirkyZ9TbZ_OBiw';

    // Mock the cartService.addItem function to return a result
    cartService.addItem.mockResolvedValue({ message: `${cartItem.item} added to cart` });

    // Send a POST request to the /addItem route
    const response = await request(app)
      .post('/addItem')
      .set('Authorization', token)
      .send(cartItem);

    // Expect the response to have a 201 status code and the result returned by the cartService
    expect(response.status).toBe(201);
    expect(response.body.message).toEqual(`${cartItem.item} added to cart`);

    // Expect the cartService.addItem function to be called with the correct arguments
    expect(cartService.addItem).toHaveBeenCalledTimes(1);
    expect(cartService.addItem).toHaveBeenCalledWith(cartItem, username);
  }, 20000);

  it('should return an error if cartService.addItem throws an error', async () => {
    // Set up mock data
    const cartItem = { item: 'Item 1', quantity: 1 };
    const username = 'test_customer@gmail.com';
    const token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RfY3VzdG9tZXJAZ21haWwuY29tIiwiaWF0IjoxNjgzMTk3ODY0fQ.KAyY6TCXt8_Jm-CyIHF3n1R-nwvHMirkyZ9TbZ_OBiw';

    // Mock the cartService.addItem function to throw an error
    cartService.addItem.mockRejectedValue(new Error('Database error'));

    // Send a POST request to the /addItem route
    const response = await request(app)
      .post('/addItem')
      .set('Authorization', token)
      .send(cartItem);

    // Expect the response to have a 500 status code and an error message
    expect(response.status).toBe(500);
    expect(response.body.message).toBe('Database error');

    // Expect the cartService.addItem function to be called with the correct arguments
    expect(cartService.addItem).toHaveBeenCalledTimes(1);
    expect(cartService.addItem).toHaveBeenCalledWith(cartItem, username);
  }, 20000);
});
