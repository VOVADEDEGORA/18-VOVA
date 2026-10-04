const express = require('express');
const app = express();

// База ключей: ник -> ключ (замени на свою базу / БД)
const KEYS = {
  "YourNick": "KEY-1234-ABCD",
  "AnotherNick": "KEY-5678-EFGH"
};

// 1) Проверка ключа
app.get('/api/check', (req, res) => {
  const nick = (req.query.nick || '').trim().toLowerCase();
  const key  = (req.query.key  || '').trim();

  if (!nick || !key) return res.send('missing');
  if (!Object.keys(KEYS).some(n => n.toLowerCase() === nick)) {
    return res.send('key_not_registered'); // ключ не зарегистрирован на ник
  }
  if (KEYS[Object.keys(KEYS).find(n => n.toLowerCase() === nick)] !== key) {
    return res.send('bad_key'); // не подходящий ключ
  }
  res.send('ok');
});

// 2) Раздача script.lua (файл лежит рядом с server.js)
const fs = require('fs');
const path = require('path');
app.get('/script.lua', (req, res) => {
  const file = path.join(__dirname, 'script.lua');
  if (!fs.existsSync(file)) return res.status(404).send('script not found');
  res.type('text/plain').send(fs.readFileSync(file, 'utf8'));
});

app.get('/', (req, res) => res.send('T00LB0X server is running'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log('Server on ' + PORT));
