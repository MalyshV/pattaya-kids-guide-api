import express from 'express';

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.json({ message: 'Pattaya Kids Guide API is running' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
