const express = require('express');
const app = express();

app.use(express.json());

// База данных: "Ключ": "Никнейм"
const KEYS_DATABASE = {
    "DV-F7HQ-B4LS-C5RT-D1MZ": "Zahar_76",
    "tester-M6KL-BXKP-EQCH-R9G1": "Beluga_Beluga321",
    "fofer11-W7PN-J3QZ-M8RT-K2LV": "jutegole"
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
