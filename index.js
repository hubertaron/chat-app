const express = require('express');
const app = express();
const chatRoutes = require('./routes/chat');

app.use(express.json());

app.use('/chat', chatRoutes);

app.get('/', (req, res) => {
  res.send('Üdvözöllek!');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
