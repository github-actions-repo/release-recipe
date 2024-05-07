const express = require('express');
const greet = require('@wulfland/package-recipe/src/index')
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send(greet());
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});