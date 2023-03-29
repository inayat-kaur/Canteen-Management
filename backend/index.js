import express from 'express';

const app = express();
let messageJson = { message: 'Hello World!!!' };

app.use(express.json());

app.get('/', (req, res) => {
  res.json(messageJson);
});

app.listen(3000, () => {
  console.log('Server listening on port 3000');
});