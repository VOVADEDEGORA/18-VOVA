const express = require('express');
const app = express();

app.use(express.json());

// База данных ключей и привязанных ников
const VALID_KEYS = {
    "KEY-1234-ABCD": "User1",
    "KEY-5678-EFGH": "ProPlayer",
    "VIP-9999-XXXX": "Admin"
};

app.post('/verify', (req, res) => {
    const { nickname, key } = req.body;

    if (!nickname || !key) {
        return res.status(400).json({ detail: "Заполните все поля" });
    }

    // 1. Проверка наличия ключа
    if (!VALID_KEYS[key]) {
        return res.status(400).json({ detail: "не подходящий ключ" });
    }

    // 2. Проверка привязки ключа к нику
    if (VALID_KEYS[key].toLowerCase() !== nickname.toLowerCase()) {
        return res.status(403).json({ detail: "ключ не зарегистрирован  на ник" });
    }

    return res.status(200).json({ status: "success", message: "Успешный вход" });
});

// Railway автоматически назначает порт через process.env.PORT
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Сервер запущен на порту ${PORT}`);
});
