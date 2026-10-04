const express = require('express');
const app = express();

app.use(express.json());

// База данных: "Ключ": "Никнейм"
const KEYS_DATABASE = {
    "KEY-1234-ABCD": "Zahar_76",
    "MY-SUPER-KEY": "Vovaddegora"
};

app.post('/verify', (req, res) => {
    const { nickname, key } = req.body;

    if (!nickname || !key) {
        return res.status(400).json({ detail: "заполните все поля" });
    }

    // 1. Если ключа нет в базе
    if (!KEYS_DATABASE[key]) {
        return res.status(400).json({ detail: "не подходящий ключ" });
    }

    // 2. Если ключ существует, но привязан к другому нику
    if (KEYS_DATABASE[key].toLowerCase() !== nickname.toLowerCase()) {
        return res.status(403).json({ detail: "ключ не зарегистрирован  на ник" });
    }

    // Успешный вход
    return res.status(200).json({ status: "success", message: "Успешный вход" });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
