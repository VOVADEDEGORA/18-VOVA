const express = require('express');
const app = express();

app.use(express.json());

// База данных: "Ключ": "Никнейм"
const KEYS_DATABASE = {
    "KEY-1234-ABCD": "Zahar_76",
    "MY-SUPER-KEY": "Vovaddegora"
};

// ⚠️ ВОТ СЮДА ВСТАВЬ ССЫЛКУ НА СВОЙ СКРИПТ (она скрыта от игроков)
const SECRET_SCRIPT_URL = "https://raw.githubusercontent.com/VOVADEDEGORA/ТВОЙ-РЕПОЗИТОРИЙ/main/script.lua";

app.post('/verify', (req, res) => {
    const { nickname, key } = req.body;

    // Ошибка: ничего не ввели
    if (!nickname || !key) {
        return res.status(400).json({ detail: "Key is required" });
    }

    // Ошибка: не подходящий ключ
    if (!KEYS_DATABASE[key]) {
        return res.status(400).json({ detail: "Invalid Key" });
    }

    // Ошибка: ключ не зарегистрирован на ник
    if (KEYS_DATABASE[key].toLowerCase() !== nickname.toLowerCase()) {
        return res.status(403).json({ detail: "Key not registered to this user" });
    }

    // Успешный вход -> Отправляем защищенную ссылку
    return res.status(200).json({ 
        status: "success", 
        message: "Success",
        script_url: SECRET_SCRIPT_URL 
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
