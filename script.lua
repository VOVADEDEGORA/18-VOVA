--[[
    ============================================================
    T00LB0XV2 [PREMIUM FULL EDITION]
    Version: 7.4 (Bigger Menu • Cars Find Fix)
    ============================================================
    ЧТО НОВОГО В V7.4:
    - ГЛАВНОЕ ОКНО УВЕЛИЧЕНО: 1150×740 (по умолчанию), ресайзер
      теперь до 1800×1100
    - ПОЛЁТ: поиск машин расширен — любая модель с деталями
      wheel/tire/rim + SteeringWheel + имена car/truck/motor и т.д.
    - СПАВНЕР МАШИНЫ: тот же расширенный поиск, переключение
      ПРЕДМЕТЫ/МАШИНЫ работает
    ============================================================
]]

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Очистка старых версий интерфейса
for _, oldName in ipairs({"AlphaPremiumUI_V3", "AlphaPremiumUI_V4", "AlphaPremiumUI_V5"}) do
    local old = CoreGui:FindFirstChild(oldName)
    if old then old:Destroy() end
end

-- ==========================================
-- ТЕМЫ: 3 палитры (чёрная / белая / прозрачная)
-- Theme — активная палитра. Все элементы читают Theme.* при создании,
-- поэтому смена темы = перекраска по точному совпадению цвета.
-- ==========================================
local Theme = {
    Background = Color3.fromRGB(12, 14, 20),
    Header = Color3.fromRGB(18, 21, 30),
    Sidebar = Color3.fromRGB(15, 17, 25),
    Footer = Color3.fromRGB(15, 17, 25),
    TabUnselected = Color3.fromRGB(24, 27, 38),
    TabSelected = Color3.fromRGB(124, 92, 255),
    ElementBg = Color3.fromRGB(22, 25, 35),
    ElementHover = Color3.fromRGB(32, 36, 50),
    Text = Color3.fromRGB(240, 242, 248),
    TextDim = Color3.fromRGB(140, 145, 160),
    Accent = Color3.fromRGB(124, 92, 255),
    AccentHover = Color3.fromRGB(146, 118, 255),
    Outline = Color3.fromRGB(40, 44, 60),
    Red = Color3.fromRGB(255, 70, 70),
    RedHover = Color3.fromRGB(255, 95, 95),
    Green = Color3.fromRGB(45, 215, 90),
    GreenHover = Color3.fromRGB(70, 230, 110),
    Gold = Color3.fromRGB(255, 200, 60),
    DeepBg = Color3.fromRGB(14, 16, 22),
    SwitchOff = Color3.fromRGB(55, 58, 70),
    KnobBg = Color3.fromRGB(255, 255, 255),
    Ripple = Color3.fromRGB(255, 255, 255)
}

local Palettes = {
    black = {
        Background = Color3.fromRGB(12, 14, 20), Header = Color3.fromRGB(18, 21, 30),
        Sidebar = Color3.fromRGB(15, 17, 25), Footer = Color3.fromRGB(15, 17, 25),
        TabUnselected = Color3.fromRGB(24, 27, 38), TabSelected = Color3.fromRGB(124, 92, 255),
        ElementBg = Color3.fromRGB(22, 25, 35), ElementHover = Color3.fromRGB(32, 36, 50),
        Text = Color3.fromRGB(240, 242, 248), TextDim = Color3.fromRGB(140, 145, 160),
        Accent = Color3.fromRGB(124, 92, 255), AccentHover = Color3.fromRGB(146, 118, 255),
        Outline = Color3.fromRGB(40, 44, 60),
        Red = Color3.fromRGB(255, 70, 70), RedHover = Color3.fromRGB(255, 95, 95),
        Green = Color3.fromRGB(45, 215, 90), GreenHover = Color3.fromRGB(70, 230, 110),
        Gold = Color3.fromRGB(255, 200, 60), DeepBg = Color3.fromRGB(14, 16, 22),
        SwitchOff = Color3.fromRGB(55, 58, 70), KnobBg = Color3.fromRGB(255, 255, 255),
        Ripple = Color3.fromRGB(255, 255, 255)
    },
    white = {
        Background = Color3.fromRGB(245, 245, 249), Header = Color3.fromRGB(255, 255, 255),
        Sidebar = Color3.fromRGB(238, 239, 244), Footer = Color3.fromRGB(238, 239, 244),
        TabUnselected = Color3.fromRGB(229, 231, 238), TabSelected = Color3.fromRGB(124, 92, 255),
        ElementBg = Color3.fromRGB(255, 255, 255), ElementHover = Color3.fromRGB(238, 239, 244),
        Text = Color3.fromRGB(28, 29, 38), TextDim = Color3.fromRGB(120, 122, 135),
        Accent = Color3.fromRGB(124, 92, 255), AccentHover = Color3.fromRGB(146, 118, 255),
        Outline = Color3.fromRGB(205, 208, 218),
        Red = Color3.fromRGB(230, 60, 60), RedHover = Color3.fromRGB(245, 90, 90),
        Green = Color3.fromRGB(40, 190, 80), GreenHover = Color3.fromRGB(60, 210, 100),
        Gold = Color3.fromRGB(214, 150, 20), DeepBg = Color3.fromRGB(230, 231, 237),
        SwitchOff = Color3.fromRGB(200, 203, 212), KnobBg = Color3.fromRGB(255, 255, 255),
        Ripple = Color3.fromRGB(140, 142, 155)
    },
    transparent = {
        Background = Color3.fromRGB(10, 12, 18), Header = Color3.fromRGB(16, 19, 28),
        Sidebar = Color3.fromRGB(13, 15, 23), Footer = Color3.fromRGB(13, 15, 23),
        TabUnselected = Color3.fromRGB(24, 27, 38), TabSelected = Color3.fromRGB(124, 92, 255),
        ElementBg = Color3.fromRGB(22, 25, 35), ElementHover = Color3.fromRGB(34, 38, 52),
        Text = Color3.fromRGB(240, 242, 248), TextDim = Color3.fromRGB(150, 155, 170),
        Accent = Color3.fromRGB(124, 92, 255), AccentHover = Color3.fromRGB(146, 118, 255),
        Outline = Color3.fromRGB(60, 66, 88),
        Red = Color3.fromRGB(255, 70, 70), RedHover = Color3.fromRGB(255, 95, 95),
        Green = Color3.fromRGB(45, 215, 90), GreenHover = Color3.fromRGB(70, 230, 110),
        Gold = Color3.fromRGB(255, 200, 60), DeepBg = Color3.fromRGB(12, 14, 20),
        SwitchOff = Color3.fromRGB(55, 58, 70), KnobBg = Color3.fromRGB(255, 255, 255),
        Ripple = Color3.fromRGB(255, 255, 255)
    }
}

local CurrentTheme = "black"
local MainBaseTransparency = 0
local PanelBaseTransparency = 0

-- ==========================================
-- ЯЗЫКИ: русский (исходник) / English / Українська
-- Ключи — русские строки-исходники. T() возвращает перевод.
-- ==========================================
local I18N = {
    en = {
        ["ВКЛАДКИ"] = "TABS",
["АВТО"] = "AUTO", ["ПРЕДМЕТЫ"] = "ITEMS", ["СПАВНЕР"] = "SPAWNER", ["ИГРОКИ"] = "PLAYERS",
        ["ТЕЛЕПОРТ"] = "TELEPORT", ["НАСТРОЙКИ"] = "SETTINGS",
        ["ПКМ CTRL — полёт • Y — зомби • P — детонатор • L — активатор • CTRL+ЛКМ — телепорт"] = "R-CTRL — fly • Y — zombie • P — detonator • L — activator • CTRL+CLICK — teleport",
        ["🔍 НАЙТИ МАШИНЫ В МИРЕ"] = "🔍 FIND CARS IN WORLD",
        ["🔍 НАЙТИ ПРЕДМЕТЫ И МОТОРЫ"] = "🔍 FIND ITEMS & ENGINES",
        [" ЗНАЧЕНИЯ (VALUES)"] = " VALUES",
        [" ФИЗИКА КОЛЁС"] = " WHEEL PHYSICS",
        ["Трение (Friction)"] = "Friction",
        ["Плотность (Density)"] = "Density",
        ["Упругость (Elasticity)"] = "Elasticity",
        ["Вес трения (F. Weight)"] = "Friction Weight",
        ["Вес упруг. (E. Weight)"] = "Elasticity Weight",
        [" ПОДВЕСКА"] = " SUSPENSION",
        ["Высота"] = "Height",
        ["Все"] = "All", ["Пер"] = "Front", ["Зад"] = "Rear",
        ["ПЛ"] = "FL", ["ПП"] = "FR", ["ЗЛ"] = "RL", ["ЗП"] = "RR",
        [" ЧИТЫ"] = " CHEATS",
        ["Нет голода"] = "No Hunger",
        ["Нет стамины"] = "No Stamina",
        ["Нет регдолла"] = "No Ragdoll",
        ["Бессмертие"] = "God Mode",
        ["Бессмертие машины"] = "God Car",
        [" ПОЛЕТ (БЕЗ ГРАВИТАЦИИ): ПРАВЫЙ CTRL"] = " FLIGHT (NO GRAVITY): RIGHT CTRL",
        ["Удалятор (debugui)"] = "Deleter (debugui)",
        ["Угол обзора (FOV)"] = "Field of View (FOV)",
        ["Детонатор (Кнопка P)"] = "Detonator (Key P)",
        ["Активатор (Кнопка L)"] = "Activator (Key L)",
        ["Спавн зомби (Зажатие Y)"] = "Spawn Zombie (Hold Y)",
        ["Телепорт по клику (Зажать Ctrl + Левый Клик мышкой)"] = "Teleport on click (Hold Ctrl + Left Click)",
        ["ОЖИДАНИЕ ДАННЫХ..."] = "WAITING FOR DATA...",
        ["ИГРОКОВ НА СЕРВЕРЕ: "] = "PLAYERS ON SERVER: ",
        ["🚀 ТЕЛЕПОРТ К ИГРОКУ"] = "🚀 TELEPORT TO PLAYER",
        ["🔄 ОБНОВИТЬ СПИСОК"] = "🔄 REFRESH LIST",
        ["🚀 ТЕЛЕПОРТ К: "] = "🚀 TELEPORT TO: ",
        ["💻 ЗАПУСТИТЬ Infinite Yield (Консоль)"] = "💻 LOAD Infinite Yield (Console)",
        ["📖 ГОРЯЧИЕ КЛАВИШИ"] = "📖 HOTKEYS",
        ["ТЕМА"] = "THEME", ["ЯЗЫК"] = "LANGUAGE", ["КНОПКА МЕНЮ"] = "MENU BUTTON",
        ["Чёрная"] = "Black", ["Белая"] = "White", ["Прозрачная"] = "Transparent",
        ["Круглая (углы и края)"] = "Round (corners & edges)",
        ["Плоская (верх и низ)"] = "Flat (top & bottom)",
        [": ВКЛ"] = ": ON", [": ВЫКЛ"] = ": OFF",
        ["Полёт включён (ПКМ CTRL — переключить)"] = "Flight ON (R-CTRL to toggle)",
        ["Полёт выключен"] = "Flight OFF",
        ["Телепорт к "] = "Teleport to ",
        [" выполнен"] = " done",
        ["Сначала выбери игрока"] = "Select a player first",
        ["Выбрана машина: "] = "Car selected: ",
        ["Выбран предмет: "] = "Item selected: ",
        ["Сканирование мира завершено"] = "World scan complete",
        ["Сканирование завершено"] = "Scan complete",
        ["Infinite Yield запущен"] = "Infinite Yield loaded",
        [" загружен"] = " loaded",
        ["Игрок зашёл: "] = "Player joined: ",
        ["Игрок вышел: "] = "Player left: ",
        ["• Правый CTRL — вкл/выкл полёт (WASD + Space/Shift)"] = "• Right CTRL — toggle fly (WASD + Space/Shift)",
        ["• CTRL + Левый Клик — телепорт (вкл. во вкладке ТЕЛЕПОРТ)"] = "• CTRL + Left Click — teleport (enable in TELEPORT)",
        ["• Y (зажать) — спавн зомби (вкл. в ИГРОКАХ)"] = "• Y (hold) — spawn zombie (enable in PLAYERS)",
        ["• P — детонатор: активирует tnt/bomb/firework/подарки"] = "• P — detonator: fires tnt/bomb/firework/gifts",
        ["• L — активатор: запускает турбины (TRUST)"] = "• L — activator: starts turbines (TRUST)",
        ["• Кнопка меню (3 полоски) — открыть меню после закрытия"] = "• Menu button (3 stripes) — reopen the menu",
        ["Все функции доступны сразу во вкладке ИГРОКИ."] = "All functions are available right away in PLAYERS."
    },
    ua = {
        ["ВКЛАДКИ"] = "ВКЛАДКИ",
["АВТО"] = "АВТО", ["ПРЕДМЕТЫ"] = "ПРЕДМЕТИ", ["СПАВНЕР"] = "СПАВНЕР", ["ИГРОКИ"] = "ГРАВЦІ",
        ["ТЕЛЕПОРТ"] = "ТЕЛЕПОРТ", ["НАСТРОЙКИ"] = "НАЛАШТУВАННЯ",
        ["ПКМ CTRL — полёт • Y — зомби • P — детонатор • L — активатор • CTRL+ЛКМ — телепорт"] = "ПКМ CTRL — політ • Y — зомбі • P — детонатор • L — активатор • CTRL+ЛКМ — телепорт",
        ["🔍 НАЙТИ МАШИНЫ В МИРЕ"] = "🔍 ЗНАЙТИ АВТО У СВІТІ",
        ["🔍 НАЙТИ ПРЕДМЕТЫ И МОТОРЫ"] = "🔍 ЗНАЙТИ ПРЕДМЕТИ І МОТОРИ",
        [" ЗНАЧЕНИЯ (VALUES)"] = " ЗНАЧЕННЯ (VALUES)",
        [" ФИЗИКА КОЛЁС"] = " ФІЗИКА КОЛІС",
        ["Трение (Friction)"] = "Тертя (Friction)",
        ["Плотность (Density)"] = "Щільність (Density)",
        ["Упругость (Elasticity)"] = "Пружність (Elasticity)",
        ["Вес трения (F. Weight)"] = "Вага тертя (F. Weight)",
        ["Вес упруг. (E. Weight)"] = "Вага пружн. (E. Weight)",
        [" ПОДВЕСКА"] = " ПІДВІСКА",
        ["Высота"] = "Висота",
        ["Все"] = "Всі", ["Пер"] = "Пер", ["Зад"] = "Зад",
        ["ПЛ"] = "ПЛ", ["ПП"] = "ПП", ["ЗЛ"] = "ЗЛ", ["ЗП"] = "ЗП",
        [" ЧИТЫ"] = " ЧІТИ",
        ["Нет голода"] = "Немає голоду",
        ["Нет стамины"] = "Немає витривалості",
        ["Нет регдолла"] = "Немає регдолла",
        ["Бессмертие"] = "Безсмертя",
        ["Бессмертие машины"] = "Безсмертя машини",
        [" ПОЛЕТ (БЕЗ ГРАВИТАЦИИ): ПРАВЫЙ CTRL"] = " ПОЛІТ (БЕЗ ГРАВІТАЦІЇ): ПРАВИЙ CTRL",
        ["Удалятор (debugui)"] = "Видалятор (debugui)",
        ["Угол обзора (FOV)"] = "Кут огляду (FOV)",
        ["Детонатор (Кнопка P)"] = "Детонатор (Клавіша P)",
        ["Активатор (Кнопка L)"] = "Активатор (Клавіша L)",
        ["Спавн зомби (Зажатие Y)"] = "Спавн зомбі (Затиск Y)",
        ["Телепорт по клику (Зажать Ctrl + Левый Клик мышкой)"] = "Телепорт по кліку (Затиск Ctrl + Лівий клік)",
        ["ОЖИДАНИЕ ДАННЫХ..."] = "ОЧІКУВАННЯ ДАНИХ...",
        ["ИГРОКОВ НА СЕРВЕРЕ: "] = "ГРАВЦІВ НА СЕРВЕРІ: ",
        ["🚀 ТЕЛЕПОРТ К ИГРОКУ"] = "🚀 ТЕЛЕПОРТ ДО ГРАВЦЯ",
        ["🔄 ОБНОВИТЬ СПИСОК"] = "🔄 ОНОВИТИ СПИСОК",
        ["🚀 ТЕЛЕПОРТ К: "] = "🚀 ТЕЛЕПОРТ ДО: ",
        ["💻 ЗАПУСТИТЬ Infinite Yield (Консоль)"] = "💻 ЗАПУСТИТИ Infinite Yield (Консоль)",
        ["📖 ГОРЯЧИЕ КЛАВИШИ"] = "📖 ГАРЯЧІ КЛАВІШІ",
        ["ТЕМА"] = "ТЕМА", ["ЯЗЫК"] = "МОВА", ["КНОПКА МЕНЮ"] = "КНОПКА МЕНЮ",
        ["Чёрная"] = "Чорна", ["Белая"] = "Біла", ["Прозрачная"] = "Прозора",
        ["Круглая (углы и края)"] = "Кругла (кути і краї)",
        ["Плоская (верх и низ)"] = "Плоска (верх і низ)",
        [": ВКЛ"] = ": УВІМК", [": ВЫКЛ"] = ": ВИМК",
        ["Полёт включён (ПКМ CTRL — переключить)"] = "Політ увімкнено (ПКМ CTRL — перемкнути)",
        ["Полёт выключен"] = "Політ вимкнено",
        ["Телепорт к "] = "Телепорт до ",
        [" выполнен"] = " виконано",
        ["Сначала выбери игрока"] = "Спочатку обери гравця",
        ["Выбрана машина: "] = "Обрано авто: ",
        ["Выбран предмет: "] = "Обрано предмет: ",
        ["Сканирование мира завершено"] = "Сканування світу завершено",
        ["Сканирование завершено"] = "Сканування завершено",
        ["Infinite Yield запущен"] = "Infinite Yield запущено",
        [" загружен"] = " завантажено",
        ["Игрок зашёл: "] = "Гравець зайшов: ",
        ["Игрок вышел: "] = "Гравець вийшов: ",
        ["• Правый CTRL — вкл/выкл полёт (WASD + Space/Shift)"] = "• Правий CTRL — увімк/вимк політ (WASD + Space/Shift)",
        ["• CTRL + Левый Клик — телепорт (вкл. во вкладке ТЕЛЕПОРТ)"] = "• CTRL + Лівий клік — телепорт (увімк. у вкладці ТЕЛЕПОРТ)",
        ["• Y (зажать) — спавн зомби (вкл. в ИГРОКАХ)"] = "• Y (затиснути) — спавн зомбі (увімк. у ГРАВЦЯХ)",
        ["• P — детонатор: активирует tnt/bomb/firework/подарки"] = "• P — детонатор: активує tnt/bomb/firework/подарунки",
        ["• L — активатор: запускает турбины (TRUST)"] = "• L — активатор: запускає турбіни (TRUST)",
        ["• Кнопка меню (3 полоски) — открыть меню после закрытия"] = "• Кнопка меню (3 смужки) — відкрити меню після закриття",
        ["Все функции доступны сразу во вкладке ИГРОКИ."] = "Усі функції доступні одразу у вкладці ГРАВЦІ."
    }
}

local curLang = "ru"

local function T(s)
    local d = I18N[curLang]
    if d and d[s] then return d[s] end
    return s
end

local AnimInfo = {
    Fast = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
    Smooth = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Bounce = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
}

local SCRIPT_VERSION = "V7.4"

-- ==========================================
-- УТИЛИТЫ ДЛЯ СОЗДАНИЯ ИНТЕРФЕЙСА
-- ==========================================
local function Create(className, properties)
    local inst = Instance.new(className)
    for k, v in pairs(properties) do
        pcall(function() inst[k] = v end)
    end
    if (className == "TextLabel" or className == "TextButton" or className == "TextBox") and inst.Text ~= nil and inst:GetAttribute("SrcText") == nil then
        inst:SetAttribute("SrcText", inst.Text)
    end
    if inst:IsA("GuiObject") then
        if inst.BackgroundColor3 and inst.BackgroundTransparency ~= 1 then
            for k, v in pairs(Theme) do
                if v == inst.BackgroundColor3 then inst:SetAttribute("BgKey", k); break end
            end
        end
    end
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
        for k, v in pairs(Theme) do
            if v == inst.TextColor3 then inst:SetAttribute("TextKey", k); break end
        end
    end
    if inst:IsA("UIStroke") then
        for k, v in pairs(Theme) do
            if v == inst.Color then inst:SetAttribute("StrokeKey", k); break end
        end
    end
    return inst
end

local function AddCorner(parent, radius)
    return Create("UICorner", {CornerRadius = UDim.new(0, radius), Parent = parent})
end

local function AddStroke(parent, color, thickness)
    return Create("UIStroke", {
        Color = color,
        Thickness = thickness,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

-- Жёсткий ограничитель прокрутки: не даёт крутиться в пустоту.
-- Когда контент помещается — прокрутка полностью отключается.
local function ClampScroll(scr)
    pcall(function()
        local function updateScrollState()
            pcall(function()
                local list = scr:FindFirstChildOfClass("UIListLayout") or scr:FindFirstChildOfClass("UIGridLayout")
                local contentH = 0
                if list and list.AbsoluteContentSize then
                    contentH = list.AbsoluteContentSize.Y
                else
                    contentH = scr.AbsoluteCanvasSize.Y
                end
                local viewH = scr.AbsoluteSize.Y
                local contentFits = contentH <= viewH + 1
                if contentFits then
                    scr.CanvasSize = UDim2.new(0, 0, 0, 0)
                    scr.ScrollingEnabled = false
                    scr.ScrollBarThickness = 0
                else
                    scr.CanvasSize = UDim2.new(0, 0, 0, contentH + 2)
                    scr.ScrollingEnabled = true
                    scr.ScrollBarThickness = 5
                end
                scr.CanvasPosition = Vector2.new(0, math.clamp(scr.CanvasPosition.Y, 0, math.max(0, contentH - viewH)))
                scr.ScrollBarImageTransparency = 1
            end)
        end
        scr:GetPropertyChangedSignal("CanvasPosition"):Connect(updateScrollState)
        scr:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateScrollState)
        scr:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrollState)
        if scr:FindFirstChildOfClass("UIListLayout") then
            scr:FindFirstChildOfClass("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateScrollState)
        end
        task.spawn(updateScrollState)
        task.delay(0.5, updateScrollState)
        task.delay(1.5, updateScrollState)
    end)
end

-- СИСТЕМА УВЕДОМЛЕНИЙ (ТОСТЫ)
-- ==========================================
local NotifyHolder = Create("Frame", {
    Name = "NotifyHolder",
    Size = UDim2.new(0, 300, 1, -20),
    Position = UDim2.new(1, -310, 0, 10),
    BackgroundTransparency = 1,
    Parent = nil
})

Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    Parent = NotifyHolder
})

local notifyId = 0

local function Notify(text, color)
    notifyId = notifyId + 1
    local Card = Create("Frame", {
        Name = "Notify_" .. notifyId,
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = NotifyHolder
    })
    AddCorner(Card, 10)
    AddStroke(Card, color or Theme.Accent, 1.5)

    Create("TextLabel", {
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
        Parent = Card
    })

    Card.Size = UDim2.new(1, 0, 0, 0)
    TweenService:Create(Card, AnimInfo.Bounce, {Size = UDim2.new(1, 0, 0, 42)}):Play()

    task.delay(3, function()
        pcall(function()
            local out = TweenService:Create(Card, AnimInfo.Fast, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1})
            out:Play()
            out.Completed:Wait()
            Card:Destroy()
        end)
    end)
end

-- ==========================================
-- КНОПКИ (V4: Ripple + атрибутные цвета)
-- ==========================================
local function PlayRipple(btn, input)
    pcall(function()
        local w = btn.AbsoluteSize.X
        local diameter = math.max(w * 1.6, 80)
        local localX = input.Position.X - btn.AbsolutePosition.X
        local localY = input.Position.Y - btn.AbsolutePosition.Y

        local ripple = Create("Frame", {
            Size = UDim2.new(0, 10, 0, 10),
            Position = UDim2.new(0, localX, 0, localY),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Theme.Ripple,
            BackgroundTransparency = 0.82,
            BorderSizePixel = 0,
            ZIndex = btn.ZIndex + 5,
            Parent = btn
        })
        AddCorner(ripple, 100)

        TweenService:Create(ripple, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, diameter, 0, diameter),
            BackgroundTransparency = 1
        }):Play()

        task.delay(0.5, function()
            pcall(function() ripple:Destroy() end)
        end)
    end)
end

local function CreateButtonEx(parent, text, baseColor, hoverColor, callback)
    local cBase = baseColor or Theme.ElementBg
    local cHover = hoverColor or Theme.ElementHover

    local baseKey = "ElementBg"
    local hoverKey = "ElementHover"
    for k, v in pairs(Theme) do
        if v == cBase then baseKey = k end
        if v == cHover then hoverKey = k end
    end

    local Btn = Create("TextButton", {
        Size = UDim2.new(0.98, 0, 0, 40),
        BackgroundColor3 = cBase,
        Text = text,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        AutoButtonColor = false,
        ClipsDescendants = true,
        Parent = parent
    })
    Btn:SetAttribute("BaseColor", cBase)
    Btn:SetAttribute("HoverColor", cHover)
    Btn:SetAttribute("BaseKey", baseKey)
    Btn:SetAttribute("HoverKey", hoverKey)

    AddCorner(Btn, 10)
    local stroke = AddStroke(Btn, Theme.Outline, 1)

    Btn.MouseEnter:Connect(function()
        local hoverCol = Theme[Btn:GetAttribute("HoverKey") or "ElementHover"]
        TweenService:Create(Btn, AnimInfo.Fast, {BackgroundColor3 = hoverCol or cHover}):Play()
        if not baseColor then
            TweenService:Create(stroke, AnimInfo.Fast, {Color = Theme.Accent}):Play()
        end
    end)

    Btn.MouseLeave:Connect(function()
        local baseCol = Theme[Btn:GetAttribute("BaseKey") or "ElementBg"]
        TweenService:Create(Btn, AnimInfo.Fast, {BackgroundColor3 = baseCol or cBase}):Play()
        if not baseColor then
            TweenService:Create(stroke, AnimInfo.Fast, {Color = Theme.Outline}):Play()
        end
    end)

    Btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            PlayRipple(Btn, input)
        end
    end)

    if callback then
        Btn.MouseButton1Click:Connect(function()
            callback(Btn)
        end)
    end
    return Btn
end

local function CreateToggle(parent, text, default, callback)
    local ToggleFrame = Create("Frame", {
        Size = UDim2.new(0.98, 0, 0, 42),
        BackgroundColor3 = Theme.ElementBg,
        BorderSizePixel = 0,
        Parent = parent
    })
    AddCorner(ToggleFrame, 10)
    AddStroke(ToggleFrame, Theme.Outline, 1)

    Create("TextLabel", {
        Size = UDim2.new(0.7, 0, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ToggleFrame
    })

    local SwitchBg = Create("Frame", {
        Size = UDim2.new(0, 46, 0, 26),
        Position = UDim2.new(1, -60, 0.5, -13),
        BackgroundColor3 = default and Theme.Green or Theme.SwitchOff,
        BorderSizePixel = 0,
        Parent = ToggleFrame
    })
    AddCorner(SwitchBg, 13)

    local SwitchKnob = Create("Frame", {
        Size = UDim2.new(0, 22, 0, 22),
        Position = UDim2.new(0, default and 22 or 2, 0.5, -11),
        BackgroundColor3 = Theme.KnobBg,
        BorderSizePixel = 0,
        Parent = SwitchBg
    })
    AddCorner(SwitchKnob, 11)

    local Btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        Parent = ToggleFrame
    })

    local state = default
    local function ApplyState(newState)
        state = newState
        TweenService:Create(SwitchBg, AnimInfo.Fast, {BackgroundColor3 = state and Theme.Green or Theme.SwitchOff}):Play()
        TweenService:Create(SwitchKnob, AnimInfo.Bounce, {Position = UDim2.new(0, state and 22 or 2, 0.5, -11)}):Play()
        if callback then callback(state) end
    end

    Btn.MouseButton1Click:Connect(function()
        ApplyState(not state)
    end)

    return ToggleFrame, function(newState)
        state = newState
        TweenService:Create(SwitchBg, AnimInfo.Fast, {BackgroundColor3 = state and Theme.Green or Theme.SwitchOff}):Play()
        TweenService:Create(SwitchKnob, AnimInfo.Bounce, {Position = UDim2.new(0, state and 22 or 2, 0.5, -11)}):Play()
    end
end

-- Реестр слайдеров для перевода их подписей при смене языка
local sliderRegistry = {}

local function Slider(parent, text, min, max, step, default, callback)
    local container = Create("Frame", {
        Size = UDim2.new(0.98, 0, 0, 50),
        BackgroundColor3 = Theme.ElementBg,
        BorderSizePixel = 0,
        Parent = parent
    })
    AddCorner(container, 10)
    AddStroke(container, Theme.Outline, 1)

    local curVal = default

    local label = Create("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.new(0, 12, 0, 6),
        BackgroundTransparency = 1,
        Text = T(text) .. ": " .. tostring(default),
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local track = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 8),
        Position = UDim2.new(0, 12, 0, 32),
        BackgroundColor3 = Theme.DeepBg,
        BorderSizePixel = 0,
        Parent = container
    })
    AddCorner(track, 4)

    local fill = Create("Frame", {
        Size = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = track
    })
    AddCorner(fill, 4)

    local knob = Create("TextButton", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(1, -9, 0.5, -9),
        BackgroundColor3 = Theme.KnobBg,
        Text = "",
        BorderSizePixel = 0,
        Parent = fill
    })
    AddCorner(knob, 9)

    local dragging = false
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local val = tonumber(string.format("%.2f", math.floor((min + ((max - min) * pos)) / step + 0.5) * step))
            curVal = val
            fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
            label.Text = T(text) .. ": " .. tostring(val)
            callback(val)
        end
    end)

    table.insert(sliderRegistry, {label = label, baseKey = text, getVal = function() return curVal end})

    return container
end

-- ==========================================
-- ИНИЦИАЛИЗАЦИЯ ГЛАВНОГО ИНТЕРФЕЙСА (V5)
-- ==========================================
local ScreenGui = Create("ScreenGui", {Name = "AlphaPremiumUI_V5", Parent = CoreGui, ResetOnSpawn = false, DisplayOrder = 100})
NotifyHolder.Parent = ScreenGui

-- КНОПКА-ГАМБУРГЕР (круглая/плоская, перетаскивается с прилипанием)
local OpenBtn = Create("TextButton", {
    Size = UDim2.new(0, 56, 0, 56),
    Position = UDim2.new(1, -72, 1, -72),
    BackgroundColor3 = Theme.Accent,
    Text = "",
    AutoButtonColor = false,
    ClipsDescendants = true,
    Visible = false,
    Parent = ScreenGui
})
local openBtnCorner = AddCorner(OpenBtn, 28)
AddStroke(OpenBtn, Theme.Text, 1.5)

local stripes = {}
for i = 0, 2 do
    local s = Create("Frame", {
        Size = UDim2.new(0, 24, 0, 3),
        BackgroundColor3 = Theme.KnobBg,
        BorderSizePixel = 0,
        Parent = OpenBtn
    })
    table.insert(stripes, s)
end

local MainFrame = Create("Frame", {
Size = UDim2.new(0, 1150, 0, 740),
    Position = UDim2.new(0.5, -575, 0.5, -370),
    BackgroundColor3 = Theme.Background,
    Active = true,
    BorderSizePixel = 0,
    Parent = ScreenGui
})
AddCorner(MainFrame, 14)
AddStroke(MainFrame, Theme.Outline, 1.5)

local MainScale = Create("UIScale", {Scale = 1, Parent = MainFrame})

-- Реестр подсветок (ESP) — создаётся до OpenMenu/CloseMenu,
-- чтобы закрытие меню могло снимать подсветку со всего.
local HighlightRegistry = {}
local SelectedTargets = {}

local function ClearAllHighlights()
    for i, hl in ipairs(HighlightRegistry) do
        pcall(function() if hl.Parent then hl:Destroy() end end)
    end
    HighlightRegistry = {}
end

local function RestoreAllHighlights()
    ClearAllHighlights()
    for _, entry in ipairs(SelectedTargets) do
        local t = entry and entry[1]
        local color = entry and entry[2]
        pcall(function()
            if t and t.Parent then
                local hl = Instance.new("Highlight")
                hl.Name = "EditorESP"
                hl.FillColor = color or Theme.Accent
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.5
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Parent = t
                table.insert(HighlightRegistry, hl)
            end
        end)
    end
end

-- ШАПКА
local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = Theme.Header,
    BorderSizePixel = 0,
    Parent = MainFrame
})
AddCorner(Header, 14)
Create("Frame", {Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = Theme.Header, BorderSizePixel = 0, Parent = Header})

Create("TextLabel", {
    Size = UDim2.new(0, 40, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    Text = "⚡",
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    Parent = Header
})

local Title = Create("TextLabel", {
    Size = UDim2.new(1, -160, 1, 0),
    Position = UDim2.new(0, 52, 0, 0),
    BackgroundTransparency = 1,
    Text = "T00LB0XV2",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

local MinBtn = Create("TextButton", {
    Size = UDim2.new(0, 46, 0, 46),
    Position = UDim2.new(1, -96, 0, 3),
    BackgroundTransparency = 1,
    Text = "—",
    TextColor3 = Theme.TextDim,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    Parent = Header
})
MinBtn.MouseEnter:Connect(function()
    TweenService:Create(MinBtn, AnimInfo.Fast, {TextColor3 = Theme.Gold}):Play()
end)
MinBtn.MouseLeave:Connect(function()
    TweenService:Create(MinBtn, AnimInfo.Fast, {TextColor3 = Theme.TextDim}):Play()
end)

local CloseBtn = Create("TextButton", {
    Size = UDim2.new(0, 46, 0, 46),
    Position = UDim2.new(1, -50, 0, 3),
    BackgroundTransparency = 1,
    Text = "▢",
    TextColor3 = Theme.TextDim,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    Parent = Header
})
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, AnimInfo.Fast, {TextColor3 = Theme.Red}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, AnimInfo.Fast, {TextColor3 = Theme.TextDim}):Play()
end)

-- Минимизация меню: сворачивает окно в кружок-гамбургер
MinBtn.MouseButton1Click:Connect(function()
    if _G.CloseMenuFn then
        _G.CloseMenuFn()
    else
        local men = CoreGui:FindFirstChild("AlphaPremiumUI_V5")
        if men then men.Visible = false end
        OpenBtn.Visible = true
    end
end)

-- Квадрат: полностью убирает интерфейс с экрана
CloseBtn.MouseButton1Click:Connect(function()
    _G.CloseMenuFn = nil
    local men = CoreGui:FindFirstChild("AlphaPremiumUI_V5")
    if men then men:Destroy() end
    OpenBtn.Visible = false
end)

-- ФУТЕР
local Footer = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 1, -30),
    BackgroundColor3 = Theme.Footer,
    BorderSizePixel = 0,
    Parent = MainFrame
})
AddCorner(Footer, 14)
Create("Frame", {Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Theme.Footer, BorderSizePixel = 0, Parent = Footer})

Create("TextLabel", {
    Size = UDim2.new(1, -90, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    Text = "ПКМ CTRL — полёт • Y — зомби • P — детонатор • L — активатор • CTRL+ЛКМ — телепорт",
    TextColor3 = Theme.TextDim,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Footer
})

Create("TextLabel", {
    Size = UDim2.new(0, 80, 1, 0),
    Position = UDim2.new(1, -90, 0, 0),
    BackgroundTransparency = 1,
    Text = SCRIPT_VERSION .. " PREMIUM",
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Right,
    Parent = Footer
})

-- БОКОВАЯ ПАНЕЛЬ
local Sidebar = Create("Frame", {
    Size = UDim2.new(0, 195, 1, -52 - 30),
    Position = UDim2.new(0, 0, 0, 52),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0,
    Parent = MainFrame
})

Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 28),
    Position = UDim2.new(0, 14, 0, 8),
    BackgroundTransparency = 1,
    Text = "ВКЛАДКИ",
    TextColor3 = Theme.TextDim,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Sidebar
})

local TabHolder = Create("Frame", {
    Size = UDim2.new(1, 0, 1, -44),
    Position = UDim2.new(0, 0, 0, 44),
    BackgroundTransparency = 1,
    Parent = Sidebar
})

Create("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    Parent = TabHolder
})

local PageContainer = Create("Frame", {
    Size = UDim2.new(1, -195 - 24, 1, -52 - 30 - 20),
    Position = UDim2.new(0, 195 + 12, 0, 52 + 10),
    BackgroundTransparency = 1,
    Parent = MainFrame
})

-- ==========================================
-- СИСТЕМА ВКЛАДОК (AutomaticCanvasSize — быстрая прокрутка)
-- ==========================================
local Tabs = {}
local Pages = {}
local SelectTab

local function CreateTab(icon, name)
    local tabIndex = #Tabs + 1

    local TabBtn = Create("TextButton", {
        Size = UDim2.new(1, -16, 0, 46),
        BackgroundColor3 = Theme.TabUnselected,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = tabIndex,
        BorderSizePixel = 0,
        Parent = TabHolder
    })
    AddCorner(TabBtn, 10)
    local tabStroke = AddStroke(TabBtn, Theme.Outline, 1)

    local Icon = Create("TextLabel", {
        Size = UDim2.new(0, 34, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = icon,
        TextColor3 = Theme.TextDim,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Parent = TabBtn
    })

    local Label = Create("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 44, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Theme.TextDim,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TabBtn
    })

    local Page = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = Theme.Accent,
        ScrollBarAutoHide = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        ClipsDescendants = true,
        Visible = false,
        Parent = PageContainer
    })

    ClampScroll(Page)

    Create("UIListLayout", {Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = Page})

    table.insert(Tabs, {Btn = TabBtn, Icon = Icon, Label = Label, Stroke = tabStroke})
    table.insert(Pages, Page)

    TabBtn.MouseButton1Click:Connect(function()
        SelectTab(tabIndex)
    end)

    TabBtn.MouseEnter:Connect(function()
        if not Page.Visible then
            TweenService:Create(TabBtn, AnimInfo.Fast, {BackgroundColor3 = Theme.ElementHover}):Play()
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if not Page.Visible then
            TweenService:Create(TabBtn, AnimInfo.Fast, {BackgroundColor3 = Theme.TabUnselected}):Play()
        end
    end)

    return Page
end

SelectTab = function(index)
    for i, t in ipairs(Tabs) do
        local active = (i == index)
        TweenService:Create(t.Btn, AnimInfo.Fast, {BackgroundColor3 = active and Theme.TabSelected or Theme.TabUnselected}):Play()
        TweenService:Create(t.Label, AnimInfo.Fast, {TextColor3 = active and Color3.fromRGB(255, 255, 255) or Theme.TextDim}):Play()
        TweenService:Create(t.Icon, AnimInfo.Fast, {TextColor3 = active and Color3.fromRGB(255, 255, 255) or Theme.TextDim}):Play()
        TweenService:Create(t.Stroke, AnimInfo.Fast, {Color = active and Theme.Accent or Theme.Outline}):Play()
        Pages[i].Visible = active
        if active then
            task.spawn(function()
                task.wait(0.05)
                pcall(function()
                    Pages[i].CanvasPosition = Vector2.new(0, 0)
                    local list = Pages[i]:FindFirstChildOfClass("UIListLayout")
                    if list and list.AbsoluteContentSize.Y <= Pages[i].AbsoluteSize.Y then
                        Pages[i].ScrollingEnabled = false
                        Pages[i].CanvasSize = UDim2.new(0, 0, 0, 0)
                    end
                end)
            end)
        end
    end
end

local PageAuto = CreateTab("🚗", "АВТО")
local PageItems = CreateTab("📦", "ПРЕДМЕТЫ")
local PageSpawner = CreateTab("➕", "СПАВНЕР")
local PagePlayers = CreateTab("👤", "ИГРОКИ")
local PageTeleport = CreateTab("🌌", "ТЕЛЕПОРТ")
local PageSettings = CreateTab("⚙️", "НАСТРОЙКИ")

SelectTab(1)

-- ==========================================
-- КНОПКА-ГАМБУРГЕР: стили, прилипание, перетаскивание
-- ==========================================
local ButtonStyle = "round"

local function SnapButton()
    local size = OpenBtn.AbsoluteSize
    local anchors
    if ButtonStyle == "flat" then
        anchors = {
            UDim2.new(0.5, -size.X / 2, 0, 16),
            UDim2.new(0.5, -size.X / 2, 1, -size.Y - 16)
        }
    else
        anchors = {
            UDim2.new(0, 16, 0, 16), UDim2.new(1, -size.X - 16, 0, 16),
            UDim2.new(0, 16, 1, -size.Y - 16), UDim2.new(1, -size.X - 16, 1, -size.Y - 16),
            UDim2.new(0.5, -size.X / 2, 0, 16), UDim2.new(0.5, -size.X / 2, 1, -size.Y - 16),
            UDim2.new(0, 16, 0.5, -size.Y / 2), UDim2.new(1, -size.X - 16, 0.5, -size.Y / 2)
        }
    end
    local viewport = Workspace.CurrentCamera.ViewportSize
    local center = OpenBtn.AbsolutePosition + size / 2
    local best, bestD
    for _, a in ipairs(anchors) do
        local px = a.X.Scale * viewport.X + a.X.Offset + size.X / 2
        local py = a.Y.Scale * viewport.Y + a.Y.Offset + size.Y / 2
        local d = (Vector2.new(px, py) - center).Magnitude
        if not best or d < bestD then best, bestD = a, d end
    end
    TweenService:Create(OpenBtn, AnimInfo.Bounce, {Position = best}):Play()
end

local function SetButtonStyle(style)
    ButtonStyle = style
    if style == "round" then
        OpenBtn.Size = UDim2.new(0, 56, 0, 56)
        openBtnCorner.CornerRadius = UDim.new(0, 28)
        local ys = {20, 27, 34}
        for i, s in ipairs(stripes) do
            s.Size = UDim2.new(0, 24, 0, 3)
            s.Position = UDim2.new(0.5, -12, 0, ys[i])
        end
    else
        OpenBtn.Size = UDim2.new(0, 120, 0, 46)
        openBtnCorner.CornerRadius = UDim.new(0, 23)
        local ys = {15, 22, 29}
        for i, s in ipairs(stripes) do
            s.Size = UDim2.new(0, 22, 0, 3)
            s.Position = UDim2.new(0.5, -11, 0, ys[i])
        end
    end
    SnapButton()
end

local function RestorePanelTransparency()
    MainFrame.BackgroundTransparency = MainBaseTransparency
    Header.BackgroundTransparency = PanelBaseTransparency
    Sidebar.BackgroundTransparency = PanelBaseTransparency
    Footer.BackgroundTransparency = PanelBaseTransparency
end

local savedTransparencies = {}
local savedTextTransparencies = {}

local function OpenMenu()
    OpenBtn.Visible = false
    MainFrame.Visible = true
    MainScale.Scale = 0.88
    RestorePanelTransparency()
    RestoreAllHighlights()
    for _, obj in ipairs(MainFrame:GetDescendants()) do
        if obj:IsA("GuiObject") then
            local saved = savedTransparencies[obj]
            if saved ~= nil then obj.BackgroundTransparency = saved end
        end
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local t = savedTextTransparencies[obj]
            obj.TextTransparency = t or 0
        end
    end
    savedTransparencies = {}
    savedTextTransparencies = {}
    TweenService:Create(MainScale, AnimInfo.Bounce, {Scale = 1}):Play()
end

local function CloseMenu()
    ClearAllHighlights()
    for _, obj in ipairs(MainFrame:GetDescendants()) do
        if obj:IsA("GuiObject") then
            savedTransparencies[obj] = obj.BackgroundTransparency
            obj.BackgroundTransparency = 1
        end
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            savedTextTransparencies[obj] = obj.TextTransparency
            obj.TextTransparency = 1
        end
    end
    TweenService:Create(MainScale, AnimInfo.Smooth, {Scale = 0.8}):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    OpenBtn.Visible = true
end
_G.CloseMenuFn = CloseMenu

-- Перетаскивание гамбургера: перетащил — прилип, кликнул — открыть
local btnDragging = false
local btnDragStart = nil
local btnStartPos = nil
local btnMoved = false

OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnMoved = false
        btnDragStart = input.Position
        btnStartPos = OpenBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                btnDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        if delta.Magnitude > 4 then btnMoved = true end
        OpenBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

OpenBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if btnMoved then
            SnapButton()
        else
            OpenMenu()
        end
    end
end)

-- Перетаскивание окна за шапку
local draggingWindow = false
local dragStartPos = nil
local windowStartPos = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingWindow = true
        dragStartPos = input.Position
        windowStartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingWindow = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingWindow and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        MainFrame.Position = UDim2.new(
            windowStartPos.X.Scale, windowStartPos.X.Offset + delta.X,
            windowStartPos.Y.Scale, windowStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Ресайз окна
local Resizer = Create("TextButton", {
    Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new(1, -25, 1, -25), BackgroundTransparency = 1,
    Text = "◢", TextColor3 = Theme.TextDim, Font = Enum.Font.Gotham, TextSize = 16, Parent = MainFrame
})
local isResizing = false
Resizer.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then isResizing = true end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then isResizing = false end end)
UserInputService.InputChanged:Connect(function(input)
    if isResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
local minW, minH = 960, 640
        local w = math.clamp(input.Position.X - MainFrame.AbsolutePosition.X + 12, minW, 1800)
        local h = math.clamp(input.Position.Y - MainFrame.AbsolutePosition.Y + 12, minH, 1100)
        MainFrame.Size = UDim2.new(0, w, 0, h)
    end
end)

-- ==========================================
-- УНИВЕРСАЛЬНЫЕ БЭКЕНД ФУНКЦИИ (ИЗ DMM.TXT — СОХРАНЕНО)
-- ==========================================
local function TryFire(eventName, ...)
    local args = {...}
    pcall(function()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj.Name:lower() == eventName:lower() then
                if obj:IsA("RemoteEvent") then obj:FireServer(unpack(args))
                elseif obj:IsA("RemoteFunction") then obj:InvokeServer(unpack(args)) end
            end
        end
    end)
end

local function FireToggle(targetObj)
    pcall(function()
        if not targetObj then return end
        for _, child in pairs(targetObj:GetDescendants()) do
            if child:IsA("ProximityPrompt") then
                child.MaxActivationDistance = math.huge
                child.RequiresLineOfSight = false
                fireproximityprompt(child)
            elseif child:IsA("ClickDetector") then
                child.MaxActivationDistance = math.huge
                fireclickdetector(child)
            end
        end
        local toggleEvent = ReplicatedStorage:FindFirstChild("toggle", true)
        if toggleEvent then
            if toggleEvent:IsA("RemoteEvent") then
                toggleEvent:FireServer(targetObj, true); toggleEvent:FireServer(targetObj, 1); toggleEvent:FireServer(targetObj)
            elseif toggleEvent:IsA("RemoteFunction") then
                toggleEvent:InvokeServer(targetObj, true); toggleEvent:InvokeServer(targetObj, 1); toggleEvent:InvokeServer(targetObj)
            end
        else
            TryFire("toggle", targetObj, true)
        end
    end)
end

-- Реестр bool-значений для перевода их подписей при смене языка
local valButtons = {}

-- ИСПРАВЛЕННАЯ ФУНКЦИЯ ДЛЯ ЗНАЧЕНИЙ (iOS-тумблеры вместо кнопок)
local function Val(parent, v, name)
    if v:IsA("BoolValue") then
        local ToggleFrame = Create("Frame", {
            Size = UDim2.new(0.98, 0, 0, 42),
            BackgroundColor3 = Theme.ElementBg,
            BorderSizePixel = 0,
            Parent = parent
        })
        AddCorner(ToggleFrame, 10)
        AddStroke(ToggleFrame, Theme.Outline, 1)

        local label = Create("TextLabel", {
            Size = UDim2.new(0.7, 0, 1, 0),
            Position = UDim2.new(0, 15, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamSemibold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = ToggleFrame
        })

        local SwitchBg = Create("Frame", {
            Size = UDim2.new(0, 46, 0, 26),
            Position = UDim2.new(1, -60, 0.5, -13),
            BackgroundColor3 = v.Value and Theme.Green or Theme.SwitchOff,
            BorderSizePixel = 0,
            Parent = ToggleFrame
        })
        AddCorner(SwitchBg, 13)

        local SwitchKnob = Create("Frame", {
            Size = UDim2.new(0, 22, 0, 22),
            Position = UDim2.new(0, v.Value and 22 or 2, 0.5, -11),
            BackgroundColor3 = Theme.KnobBg,
            BorderSizePixel = 0,
            Parent = SwitchBg
        })
        AddCorner(SwitchKnob, 11)

        local Btn = Create("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            Parent = ToggleFrame
        })

        local function ApplyState(newState)
            v.Value = newState
            TweenService:Create(SwitchBg, AnimInfo.Fast, {BackgroundColor3 = newState and Theme.Green or Theme.SwitchOff}):Play()
            TweenService:Create(SwitchKnob, AnimInfo.Bounce, {Position = UDim2.new(0, newState and 22 or 2, 0.5, -11)}):Play()
        end

        Btn.MouseButton1Click:Connect(function()
            ApplyState(not v.Value)
        end)

        v.Changed:Connect(function(x)
            TweenService:Create(SwitchBg, AnimInfo.Fast, {BackgroundColor3 = x and Theme.Green or Theme.SwitchOff}):Play()
            TweenService:Create(SwitchKnob, AnimInfo.Bounce, {Position = UDim2.new(0, x and 22 or 2, 0.5, -11)}):Play()
        end)

        table.insert(valButtons, {btn = Btn, name = name, valueObj = v, label = label})

    elseif v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue") then
        local r = Create("Frame", {Size = UDim2.new(0.98, 0, 0, 36), BackgroundColor3 = Theme.ElementBg, BorderSizePixel = 0, Parent = parent})
        AddCorner(r, 8)
        AddStroke(r, Theme.Outline, 1)

        Create("TextLabel", {Size = UDim2.new(0.5, -5, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = name .. ":", TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = r})

        local tb = Create("TextBox", {Size = UDim2.new(0.45, 0, 0, 24), Position = UDim2.new(0.5, 0, 0, 6), BackgroundColor3 = Theme.DeepBg, TextColor3 = Theme.Accent, Text = tostring(v.Value), Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false, Parent = r})
        AddCorner(tb, 6)
        AddStroke(tb, Theme.Outline, 1)

        tb.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                if v:IsA("StringValue") then v.Value = tb.Text
                else v.Value = tonumber(tb.Text) or v.Value end
            end
        end)
        v.Changed:Connect(function(x)
            if not tb:IsFocused() then tb.Text = tostring(x) end
        end)
    end
end

-- ==========================================
-- ВКЛАДКА "ТЕЛЕПОРТ" (отдельная вкладка)
-- ==========================================
local tpCtrlEnabled = false
CreateToggle(PageTeleport, "Телепорт по клику (Зажать Ctrl + ЛКМ)", false, function(val)
    tpCtrlEnabled = val
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and tpCtrlEnabled then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Mouse.Hit then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end
end)

local tpStatLabel = Create("TextLabel", {
    Size = UDim2.new(0.98, 0, 0, 30), BackgroundTransparency = 1, Text = T("ОЖИДАНИЕ ДАННЫХ..."), TextColor3 = Theme.Green, Font = Enum.Font.GothamBold, TextSize = 14, Parent = PageTeleport
})

local tpLayoutCont = Create("Frame", {Size = UDim2.new(1, 0, 1, -88), BackgroundTransparency = 1, Parent = PageTeleport})
local tpLayoutLeft = Create("ScrollingFrame", {Size = UDim2.new(0.48, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = tpLayoutCont})
local tpLayoutRight = Create("ScrollingFrame", {Size = UDim2.new(0.48, 0, 1, 0), Position = UDim2.new(0.52, 0, 0, 0), BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = tpLayoutCont})
ClampScroll(tpLayoutLeft)
ClampScroll(tpLayoutRight)

Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = tpLayoutLeft})
Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = tpLayoutRight})

local targetTpPlayer = nil

local function updateTpList()
    for _, c in pairs(tpLayoutLeft:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end
    local players = Players:GetPlayers()
    tpStatLabel.Text = T("ИГРОКОВ НА СЕРВЕРЕ: ") .. tostring(#players)
    for _, plr in ipairs(players) do
        if plr ~= LocalPlayer then
            local pb = CreateButtonEx(tpLayoutLeft, plr.Name, Theme.ElementBg, Theme.ElementHover, function()
                targetTpPlayer = plr
                for _, c in pairs(tpLayoutLeft:GetChildren()) do
                    if c:IsA("TextButton") and c:GetAttribute("PlrBtn") then
                        local isSel = (c:GetAttribute("PlrRef") == plr)
                        TweenService:Create(c, AnimInfo.Fast, {BackgroundColor3 = isSel and Theme.Accent or Theme.ElementBg}):Play()
                    end
                end
            end)
            pb:SetAttribute("PlrBtn", true)
            pb:SetAttribute("PlrRef", plr)
        end
    end
end

CreateButtonEx(tpLayoutRight, T("🔄 ОБНОВИТЬ СПИСОК"), Theme.ElementBg, Theme.ElementHover, updateTpList)

CreateButtonEx(tpLayoutRight, "🚀 ТЕЛЕПОРТ К ИГРОКУ", Theme.Accent, Theme.AccentHover, function()
    if targetTpPlayer and targetTpPlayer.Character and targetTpPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetTpPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
            Notify(T("Телепорт к ") .. targetTpPlayer.Name .. T(" выполнен"), Theme.Accent)
        end
    else
        Notify(T("Сначала выбери игрока"), Theme.Red)
    end
end)

-- УРОН ВЫБРАННОМУ ИГРОКУ
local damageVal = 25
Slider(tpLayoutRight, "Урон", 0, 100, 1, damageVal, function(val) damageVal = val end)

CreateButtonEx(tpLayoutRight, "💥 НАНЕСТИ УРОН", Theme.Red, Theme.RedHover, function()
    if not targetTpPlayer then Notify(T("Сначала выбери игрока"), Theme.Red) return end
    local char = targetTpPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function() hum:TakeDamage(damageVal) end)
    Notify("Урон " .. damageVal .. " нанесён: " .. targetTpPlayer.Name, Theme.Red)
end)

CreateButtonEx(tpLayoutRight, "☠ КИЛЬНУТЬ ВСЕХ НА СЕРВЕРЕ", Theme.Red, Theme.RedHover, function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function() hum:TakeDamage(hum.MaxHealth + 1000) end)
            end
        end
    end
    Notify("Все убиты", Theme.Red)
end)

task.spawn(function()
    while task.wait(1) do
        local plrs = Players:GetPlayers()
        tpStatLabel.Text = T("ИГРОКОВ НА СЕРВЕРЕ: ") .. tostring(#plrs)
    end
end)
Players.PlayerAdded:Connect(updateTpList)
Players.PlayerRemoving:Connect(updateTpList)
updateTpList()

-- ==========================================
-- ВКЛАДКА "СПАВНЕР" (полный код Panel Tester, в стиле T00LB0X)
-- ==========================================
local selectedItem = nil
local totalItemsCount = 0
local itemButtonsList = {}
local fluidRows = {}

local currentCategory = "All"

local function spawnCorner(parent, radius)
    return AddCorner(parent, radius or 8)
end
local function spawnStroke(parent, color, thickness)
    return AddStroke(parent, color or Color3.fromRGB(60, 60, 75), thickness or 1)
end

-- ШАПКА
Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 20), BackgroundTransparency = 1, Text = "T00LB0X SPAWNER", TextColor3 = Theme.Accent, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = PageSpawner})

-- Вкладки: ПРЕДМЕТЫ / МАШИНЫ
local spawnMode = "items"
local SpawnTabBar = Create("Frame", {Size = UDim2.new(0.98, 0, 0, 34), BackgroundTransparency = 1, Parent = PageSpawner})
local TabBtnItems = CreateButtonEx(SpawnTabBar, "📦 ПРЕДМЕТЫ", Theme.Accent, Theme.AccentHover, function()
    spawnMode = "items"
    syncSpawnTabs()
    rebuildSpawnGrid()
end)
TabBtnItems.Size = UDim2.new(0.49, 0, 1, 0)
TabBtnItems.Position = UDim2.new(0, 0, 0, 0)
TabBtnItems.TextColor3 = Color3.new(1, 1, 1)
local TabBtnCars = CreateButtonEx(SpawnTabBar, "🚗 МАШИНЫ", Theme.ElementBg, Theme.ElementHover, function()
    spawnMode = "cars"
    syncSpawnTabs()
    rebuildSpawnGrid()
end)
TabBtnCars.Size = UDim2.new(0.49, 0, 1, 0)
TabBtnCars.Position = UDim2.new(0.51, 0, 0, 0)

local function syncSpawnTabs()
    local onItems = (spawnMode == "items")
    TabBtnItems.BackgroundColor3 = onItems and Theme.Accent or Theme.ElementBg
    TabBtnItems.TextColor3 = onItems and Color3.new(1, 1, 1) or Theme.Text
    TabBtnCars.BackgroundColor3 = (not onItems) and Theme.Accent or Theme.ElementBg
    TabBtnCars.TextColor3 = (not onItems) and Color3.new(1, 1, 1) or Theme.Text
end

-- Поиск
local SearchBoxContainer = Create("Frame", {Size = UDim2.new(0.98, 0, 0, 38), BackgroundColor3 = Theme.DeepBg, BorderSizePixel = 0, Parent = PageSpawner})
spawnCorner(SearchBoxContainer, 8)
spawnStroke(SearchBoxContainer, Color3.fromRGB(60, 65, 85), 1)
local SearchBox = Create("TextBox", {Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, TextColor3 = Theme.Text, PlaceholderColor3 = Theme.TextDim, PlaceholderText = "🔍 Поиск предметов...", Font = Enum.Font.Gotham, TextSize = 13, Text = "", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Parent = SearchBoxContainer})

local function updateFilter()
    local searchText = SearchBox.Text:lower()
    for _, data in ipairs(itemButtonsList) do
        local textMatch = (searchText == "" or string.find(data.ItemName, searchText, 1, true))
        data.Button.Visible = textMatch
    end
end

-- Счётчик
local CountLabel = Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 16), BackgroundTransparency = 1, Text = "Предметов найдено: 0", TextColor3 = Theme.TextDim, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = PageSpawner})

-- Раскладка: сетка слева, панель справа
local SpawnBody = Create("Frame", {Size = UDim2.new(0.98, 0, 0, 420), BackgroundTransparency = 1, Parent = PageSpawner})

local ItemsScroll = Create("ScrollingFrame", {Size = UDim2.new(0.58, 0, 1, 0), BackgroundTransparency = 1, ScrollBarThickness = 6, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = SpawnBody})
ClampScroll(ItemsScroll)
local UIGrid = Create("UIGridLayout", {CellSize = UDim2.new(0, 95, 0, 105), CellPadding = UDim2.new(0, 8, 0, 8), Parent = ItemsScroll})

-- ПРАВАЯ ПАНЕЛЬ
local RightPanel = Create("Frame", {Size = UDim2.new(0.4, 0, 1, 0), Position = UDim2.new(0.6, 0, 0, 0), BackgroundColor3 = Theme.ElementBg, BorderSizePixel = 0, Parent = SpawnBody})
spawnCorner(RightPanel, 10)
spawnStroke(RightPanel, Theme.Outline, 1)

local SelectedItemName = Create("TextLabel", {Text = "Предмет не выбран", Size = UDim2.new(1, -20, 0, 22), Position = UDim2.new(0, 10, 0, 8), BackgroundTransparency = 1, TextColor3 = Theme.Gold, Font = Enum.Font.GothamBold, TextSize = 13, TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, Parent = RightPanel})

local AmmoLabel = Create("TextLabel", {Text = "Патроны:", Size = UDim2.new(1, -20, 0, 16), Position = UDim2.new(0, 10, 0, 34), BackgroundTransparency = 1, TextColor3 = Theme.TextDim, Font = Enum.Font.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Visible = false, Parent = RightPanel})
local AmmoInput = Create("TextBox", {PlaceholderText = "Количество / inf", Size = UDim2.new(1, -20, 0, 26), Position = UDim2.new(0, 10, 0, 52), BackgroundColor3 = Theme.DeepBg, TextColor3 = Theme.Text, PlaceholderColor3 = Theme.TextDim, Font = Enum.Font.Gotham, TextSize = 12, Visible = false, Parent = RightPanel})
spawnCorner(AmmoInput, 6)
spawnStroke(AmmoInput, Theme.Outline, 1)

local FluidHeaderLabel = Create("TextLabel", {Text = "Жидкости / Газы:", Size = UDim2.new(0.6, 0, 0, 18), Position = UDim2.new(0, 10, 0, 88), BackgroundTransparency = 1, TextColor3 = Theme.TextDim, Font = Enum.Font.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = RightPanel})
local AddFluidBtn = Create("TextButton", {Text = "+ Строка", Size = UDim2.new(0.35, 0, 0, 22), Position = UDim2.new(0.62, 0, 0, 86), BackgroundColor3 = Theme.Accent, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 11, Parent = RightPanel})
spawnCorner(AddFluidBtn, 4)

local FluidsScroll = Create("ScrollingFrame", {Size = UDim2.new(1, -20, 0, 160), Position = UDim2.new(0, 10, 0, 112), BackgroundColor3 = Theme.Background, ScrollBarThickness = 0, ScrollBarImageTransparency = 1, AutomaticCanvasSize = Enum.AutomaticSize.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = RightPanel})
spawnCorner(FluidsScroll, 6)
local FluidsLayout = Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = FluidsScroll})
ClampScroll(FluidsScroll)

local function addFluidRow(defaultName, defaultValue)
    local row = Create("Frame", {Size = UDim2.new(1, -6, 0, 30), BackgroundColor3 = Theme.DeepBg, Parent = FluidsScroll})
    spawnCorner(row, 4)
    local nameBox = Create("TextBox", {PlaceholderText = "Имя (gas/water)", Text = defaultName or "", Size = UDim2.new(0.48, 0, 1, -4), Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Theme.Background, TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 11, Parent = row})
    spawnCorner(nameBox, 4)
    local valBox = Create("TextBox", {PlaceholderText = "Литры", Text = defaultValue or "", Size = UDim2.new(0.36, 0, 1, -4), Position = UDim2.new(0.50, 0, 0, 2), BackgroundColor3 = Theme.Background, TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 11, Parent = row})
    spawnCorner(valBox, 4)
    local delBtn = Create("TextButton", {Text = "✕", Size = UDim2.new(0.12, 0, 1, -4), Position = UDim2.new(0.87, 0, 0, 2), BackgroundColor3 = Theme.Red, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 12, Parent = row})
    spawnCorner(delBtn, 4)
    local rowData = {Row = row, NameBox = nameBox, ValueBox = valBox}
    table.insert(fluidRows, rowData)
    delBtn.MouseButton1Click:Connect(function()
        for i, r in ipairs(fluidRows) do
            if r == rowData then table.remove(fluidRows, i) break end
        end
        row:Destroy()
    end)
end

addFluidRow("", "")
AddFluidBtn.MouseButton1Click:Connect(function() addFluidRow("", "") end)

Create("TextLabel", {Text = "Количество (1..100):", Size = UDim2.new(1, -20, 0, 16), Position = UDim2.new(0, 10, 0, 268), BackgroundTransparency = 1, TextColor3 = Theme.TextDim, Font = Enum.Font.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = RightPanel})
local AmountInput = Create("TextBox", {Text = "1", Size = UDim2.new(1, -20, 0, 32), Position = UDim2.new(0, 10, 0, 286), BackgroundColor3 = Theme.DeepBg, TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 14, Parent = RightPanel})
spawnCorner(AmountInput, 6)
spawnStroke(AmountInput, Theme.Outline, 1)

-- Горячая клавиша спавна (настраивается, только клавиатура)
local spawnKeybind = Enum.KeyCode.F
local isBindingKey = false
local KeybindBtn = Create("TextButton", {Text = "Клавиша спавна: [ F ]", Size = UDim2.new(1, -20, 0, 32), Position = UDim2.new(0, 10, 0, 322), BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.Text, Font = Enum.Font.GothamMedium, TextSize = 12, Parent = RightPanel})
spawnCorner(KeybindBtn, 6)
KeybindBtn.MouseButton1Click:Connect(function()
    isBindingKey = true
    KeybindBtn.Text = "Нажми любую клавишу... (не мышь)"
    KeybindBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 30)
end)

local SpawnButton = Create("TextButton", {Size = UDim2.new(1, -20, 0, 46), Position = UDim2.new(0, 10, 1, -56), BackgroundColor3 = Theme.Green, Text = "⚡ С П А В Н И Т Ь", Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = Color3.new(1, 1, 1), Parent = RightPanel})
spawnCorner(SpawnButton, 8)

-- ЛОГИКА СПАВНА
local function triggerSpawn(forceAmount)
    if not selectedItem then return end
    local remote = ReplicatedStorage:FindFirstChild("sandboxconnection") and ReplicatedStorage.sandboxconnection:FindFirstChild("spawnobject")
    if not remote then Notify("Remote spawnobject не найден", Theme.Red) return end
    local amount = forceAmount or math.clamp(tonumber(AmountInput.Text) or 1, 1, 100)
    -- Только ОДНА жидкость (первая заполненная строка), чтобы не спавнились лишние
    local fluidTable = {}
    for _, r in ipairs(fluidRows) do
        local fn = r.NameBox.Text
        local fv = r.ValueBox.Text
        if fn ~= "" and fv ~= "" then
            table.insert(fluidTable, {name = fn, value = fv})
        end
    end
    if #fluidTable > 1 then
        fluidTable = {fluidTable[1]}
    end
    if #fluidTable == 0 then table.insert(fluidTable, {name = "", value = ""}) end
    local targetAmmo = ""
    if AmmoInput.Visible then targetAmmo = AmmoInput.Text end
    for i = 1, amount do
        task.spawn(function()
            pcall(function()
                remote:InvokeServer(selectedItem, {
                    color = Color3.new(1, 1, 1),
                    ammo = targetAmmo,
                    grade = 0,
                    fluids = fluidTable
                })
            end)
        end)
    end
end

SpawnButton.MouseButton1Click:Connect(function() triggerSpawn() end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if isBindingKey then
        -- Принимаем только клавиши клавиатуры, НЕ мышь
        if input.UserInputType == Enum.UserInputType.Keyboard then
            spawnKeybind = input.KeyCode
            KeybindBtn.Text = "Клавиша спавна: [ " .. input.KeyCode.Name .. " ]"
            KeybindBtn.BackgroundColor3 = Theme.ElementHover
            isBindingKey = false
        end
        return
    end
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == spawnKeybind then
        triggerSpawn(1)
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        PageSpawner.Visible = not PageSpawner.Visible
        if PageSpawner.Visible then Notify("Спавнер виден", Theme.Green) else Notify("Спавнер скрыт", Theme.Red) end
    end
end)

local function isValidItem(obj)
    if obj:IsA("UnionOperation") then return false end
    local name = obj.Name:lower()
    if name == "union" or name == "part" or name == "meshpart" or name:match("door") then return false end
    if not (obj:IsA("Model") or obj:IsA("Tool") or obj:IsA("BasePart")) then return false end
    return true
end

local function getItemCategory(item)
    local name = item.Name:lower()
    local path = item:GetFullName():lower()
    if name:match("ak%-47") or name:match("shotgun") or name:match("rocket") or name:match("crowbar") or name:match("sledge") or name:match("axe") or name:match("sword") or name:match("gun") then return "Weapons" end
    if name:match("cake") or name:match("apple") or name:match("watermelon") or name:match("bread") or name:match("kebab") or name:match("sausage") or name:match("cookie") or name:match("banana") or name:match("orange") or name:match("fish") then return "food" end
    if name:match("gascan") or name:match("oilcan") or name:match("bigcan") or name:match("tank") then return "Tanks" end
    if name:match("engine") or name == "v8" or name == "turbine" then return "engine" end
    if name:match("radiator") then return "Radiators" end
    if name:match("rim") then return "Rims" end
    if name:match("wheel") or name:match("steering") then return "Steering Wheels" end
    if name:match("tire") then return "Tires" end
    if name:match("trailer") then return "Trailers" end
    if name:match("battery") then return "Battery" end
    if path:match("engine") then return "engine" end
    if path:match("food") then return "food" end
    if path:match("weapon") then return "Weapons" end
    if path:match("trailer") then return "Trailers" end
    return "Other"
end

local function createItemButton(item, category)
    totalItemsCount = totalItemsCount + 1
    local btn = Create("TextButton", {Text = "", BackgroundColor3 = Theme.ElementBg, BorderSizePixel = 0, Parent = ItemsScroll})
    spawnCorner(btn, 8)
    local stroke = spawnStroke(btn, Theme.Outline, 1)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Theme.ElementHover
        stroke.Color = Theme.Accent
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Theme.ElementBg
        stroke.Color = Theme.Outline
    end)

    local displayName = item.Name
    if (displayName:lower() == "rim" or displayName:lower() == "radiator") and item.Parent then
        displayName = item.Parent.Name .. " " .. displayName
    end
    table.insert(itemButtonsList, {Button = btn, ItemName = displayName:lower(), Category = category})

    local viewport = Create("ViewportFrame", {Size = UDim2.new(1, 0, 1, -24), BackgroundTransparency = 1, Parent = btn})
    local cam = Instance.new("Camera")
    viewport.CurrentCamera = cam
    local clone = item:Clone()
    clone.Parent = viewport
    local cf, size = Vector3.new(), Vector3.new(2, 2, 2)
    if clone:IsA("Model") then
        cf, size = clone:GetBoundingBox()
    elseif clone:IsA("BasePart") then
        cf, size = clone.CFrame, clone.Size
    end
    local maxDim = math.max(size.X, size.Y, size.Z)
    cam.CFrame = CFrame.new(cf.Position + Vector3.new(maxDim * 1.3, maxDim * 0.9, maxDim * 1.5), cf.Position)

    local nameLabel = Create("TextLabel", {Text = displayName, Size = UDim2.new(1, 0, 0, 24), Position = UDim2.new(0, 0, 1, -24), BackgroundColor3 = Theme.Background, TextColor3 = Theme.Text, Font = Enum.Font.GothamMedium, TextSize = 10, TextScaled = true, Parent = btn})
    spawnCorner(nameLabel, 6)

    btn.MouseButton1Click:Connect(function()
        selectedItem = item
        SelectedItemName.Text = displayName
        if category == "Weapons" and (item.Name:lower():match("ak") or item.Name:lower():match("shotgun")) then
            AmmoInput.Visible = true
            AmmoLabel.Visible = true
        else
            AmmoInput.Visible = false
            AmmoLabel.Visible = false
        end
    end)
end

local scannedItems = {}

local function rebuildSpawnGrid()
    -- Очистка сетки
    for _, c in pairs(ItemsScroll:GetChildren()) do
        if not c:IsA("UIGridLayout") then c:Destroy() end
    end
    itemButtonsList = {}
    totalItemsCount = 0

    if spawnMode == "cars" then
        local seenCars = {}
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and not Players:GetPlayerFromCharacter(obj) and not seenCars[obj] then
                seenCars[obj] = true
                local n = obj.Name:lower()
                local nameHit = n:match("car") or n:match("van") or n:match("bus") or n:match("buggy") or n:match("moped") or n:match("lada") or n:match("sedan") or n:match("maincar") or n:match("truck") or n:match("motor")
                local hasSteering = obj:FindFirstChild("SteeringWheel", true) or obj:FindFirstChild("Steering", true)
                local hasWheelPart = false
                for _, part in ipairs(obj:GetDescendants()) do
                    local pn = part.Name:lower()
                    if part:IsA("BasePart") and (pn:match("wheel") or pn:match("tire") or pn:match("rim")) then
                        hasWheelPart = true
                        break
                    end
                end
                if (nameHit or hasSteering or hasWheelPart) and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) then
                    createItemButton(obj, "Cars")
                end
            end
        end
    else
        local seen = {}
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if isValidItem(obj) and not seen[obj] then
                seen[obj] = true
                local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                local skipFolder = (parentName == "объекты" or parentName == "objects" or parentName == "object" or parentName == "obj")
                if not obj.Parent:IsA("Model") and not skipFolder then
                    local cat = getItemCategory(obj)
                    createItemButton(obj, cat)
                end
            end
        end
    end

    CountLabel.Text = "Найдено объектов: " .. tostring(totalItemsCount)
    updateFilter()
end

rebuildSpawnGrid()
SearchBox:GetPropertyChangedSignal("Text"):Connect(updateFilter)

-- ==========================================
-- ВКЛАДКА "АВТО" (кнопка наверху, таблицы на всю высоту)
-- ==========================================
local FindCarsBtn = CreateButtonEx(PageAuto, T("🔍 НАЙТИ МАШИНЫ В МИРЕ"), Theme.Accent, Theme.AccentHover, function() end)
FindCarsBtn.LayoutOrder = 1
FindCarsBtn.Size = UDim2.new(0.98, 0, 0, 46)
FindCarsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local AutoLayoutCont = Create("Frame", {Size = UDim2.new(1, 0, 1, -62), BackgroundTransparency = 1, LayoutOrder = 2, Parent = PageAuto})
local cL = Create("ScrollingFrame", {Size = UDim2.new(0.35, 0, 1, 0), BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = AutoLayoutCont})
local cT = Create("ScrollingFrame", {Size = UDim2.new(0.63, 0, 1, 0), Position = UDim2.new(0.37, 0, 0, 0), BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = AutoLayoutCont})
ClampScroll(cL)
ClampScroll(cT)

Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = cL})
Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = cT})

local sCar = nil
local cBts = {}
local sCarHL = nil

local function applyHighlight(target, color)
    SelectedTargets = {}
    ClearAllHighlights()
    if target then
        if target:FindFirstChildOfClass("Highlight") then
            return nil
        end
        local hl = Instance.new("Highlight")
        hl.Name = "EditorESP"
        hl.FillColor = color
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.FillTransparency = 0.5
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = target
        table.insert(HighlightRegistry, hl)
        table.insert(SelectedTargets, {target, color})
        return hl
    end
    return nil
end

FindCarsBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and not Players:GetPlayerFromCharacter(obj) then
            local n = obj.Name:lower()
            if (n:match("car") or n:match("van") or n:match("bus") or n:match("buggy") or n:match("moped") or n:match("2105") or n:match("2109") or n:match("машина") or n:match("lada") or obj:FindFirstChild("Wheels") or obj:FindFirstChild("wheels")) and not cBts[obj] then

                cBts[obj] = CreateButtonEx(cL, obj.Name, Theme.ElementBg, Theme.ElementHover, function()
                    sCar = (sCar == obj) and nil or obj
                    sCarHL = applyHighlight(sCar, Theme.Accent)

                    for _, c in pairs(cT:GetChildren()) do
                        if not c:IsA("UIListLayout") then c:Destroy() end
                    end

                    if sCar then
                        Notify(T("Выбрана машина: ") .. obj.Name, Theme.Accent)

                        local vals = sCar:FindFirstChild("Values") or sCar:FindFirstChild("values")
                        if vals then
                            Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 24), BackgroundTransparency = 1, Text = T(" ЗНАЧЕНИЯ (VALUES)"), TextColor3 = Theme.Accent, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = cT})
                            for _, v in pairs(vals:GetDescendants()) do
                                if v:IsA("ValueBase") then Val(cT, v, v.Name) end
                            end
                        end

                        Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 24), BackgroundTransparency = 1, Text = T(" ФИЗИКА КОЛЁС"), TextColor3 = Theme.Green, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = cT})

                        local function updateWheelPhysics(prop, value)
                            if not sCar then return end
                            local wheels = sCar:FindFirstChild("Wheels") or sCar:FindFirstChild("wheels")
                            if wheels then
                                for _, w in pairs(wheels:GetChildren()) do
                                    if w:IsA("BasePart") then
                                        local currentPhys = w.CustomPhysicalProperties or PhysicalProperties.new(w.Material)
                                        local d, f, e, fw, ew = currentPhys.Density, currentPhys.Friction, currentPhys.Elasticity, currentPhys.FrictionWeight, currentPhys.ElasticityWeight
                                        if prop == "Density" then d = value
                                        elseif prop == "Friction" then f = value
                                        elseif prop == "Elasticity" then e = value
                                        elseif prop == "FrictionWeight" then fw = value
                                        elseif prop == "ElasticityWeight" then ew = value
                                        end
                                        w.CustomPhysicalProperties = PhysicalProperties.new(d, f, e, fw, ew)
                                    end
                                end
                            end
                        end

                        Slider(cT, "Трение (Friction)", 0, 10, 0.1, 1, function(v) updateWheelPhysics("Friction", v) end)
                        Slider(cT, "Плотность (Density)", 0, 10, 0.1, 0.1, function(v) updateWheelPhysics("Density", v) end)
                        Slider(cT, "Упругость (Elasticity)", 0, 1, 0.05, 0.5, function(v) updateWheelPhysics("Elasticity", v) end)
                        Slider(cT, "Вес трения (F. Weight)", 0, 100, 1, 1, function(v) updateWheelPhysics("FrictionWeight", v) end)
                        Slider(cT, "Вес упруг. (E. Weight)", 0, 100, 1, 1, function(v) updateWheelPhysics("ElasticityWeight", v) end)

                        Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 24), BackgroundTransparency = 1, Text = T(" ПОДВЕСКА"), TextColor3 = Theme.Gold, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = cT})

                        local suspTarget = "all"
                        local stFrame = Create("Frame", {Size = UDim2.new(0.98, 0, 0, 28), BackgroundTransparency = 1, Parent = cT})
                        local btnsSt = {
                            {t = "all", n = "Все"}, {t = "front", n = "Пер"}, {t = "rear", n = "Зад"}, {t = "fl", n = "ПЛ"}, {t = "fr", n = "ПП"}, {t = "rl", n = "ЗЛ"}, {t = "rr", n = "ЗП"}
                        }

                        local swidth = 1 / #btnsSt
                        local stBtnRefs = {}

                        for i, inf in ipairs(btnsSt) do
                            local b = Create("TextButton", {
                                Size = UDim2.new(swidth - 0.02, 0, 1, 0), Position = UDim2.new((i - 1) * swidth, 0, 0, 0),
                                Text = T(inf.n), BackgroundColor3 = (inf.t == "all" and Theme.Accent or Theme.ElementBg),
                                TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.Gotham, TextSize = 11, BorderSizePixel = 0, Parent = stFrame
                            })
                            AddCorner(b, 6)
                            b.MouseButton1Click:Connect(function()
                                suspTarget = inf.t
                                for refT, refB in pairs(stBtnRefs) do
                                    TweenService:Create(refB, AnimInfo.Fast, {BackgroundColor3 = (refT == inf.t and Theme.Accent or Theme.ElementBg)}):Play()
                                end
                            end)
                            stBtnRefs[inf.t] = b
                        end

                        Slider(cT, "Высота", 2.4, 4.5, 0.1, 3.45, function(val)
                            if not sCar then return end
                            for _, obj2 in pairs(sCar:GetDescendants()) do
                                if obj2:IsA("SpringConstraint") or obj2:IsA("PrismaticConstraint") then
                                    local n1 = obj2.Name:lower()
                                    local n2 = obj2.Parent and obj2.Parent.Name:lower() or ""
                                    local n3 = (obj2:IsA("Constraint") and obj2.Attachment0 and obj2.Attachment0.Parent) and obj2.Attachment0.Parent.Name:lower() or ""
                                    local n4 = (obj2:IsA("Constraint") and obj2.Attachment1 and obj2.Attachment1.Parent) and obj2.Attachment1.Parent.Name:lower() or ""

                                    local isF, isR, isFL, isFR, isRL, isRR = false, false, false, false, false, false
                                    for _, nm in ipairs({n1, n2, n3, n4}) do
                                        if nm == "fl" or nm == "f_l" or nm:match("frontleft") then isF, isFL = true, true end
                                        if nm == "fr" or nm == "f_r" or nm:match("frontright") then isF, isFR = true, true end
                                        if nm == "rl" or nm == "r_l" or nm:match("rearleft") then isR, isRL = true, true end
                                        if nm == "rr" or nm == "r_r" or nm:match("rearright") then isR, isRR = true, true end
                                        if nm:match("front") or nm:match("^f$") or nm:match("fwheel") then isF = true end
                                        if nm:match("rear") or nm:match("back") or nm:match("^r$") or nm:match("rwheel") then isR = true end
                                    end

                                    local apply = (suspTarget == "all") or (suspTarget == "front" and isF) or (suspTarget == "rear" and isR) or (suspTarget == "fl" and isFL) or (suspTarget == "fr" and isFR) or (suspTarget == "rl" and isRL) or (suspTarget == "rr" and isRR)

                                    if apply then
                                        if obj2:IsA("SpringConstraint") then obj2.FreeLength = math.abs(val)
                                        elseif obj2:IsA("PrismaticConstraint") then obj2.TargetPosition = val end
                                    end
                                end
                            end
                        end)
                    end

                    for x, b in pairs(cBts) do
                        if x.Parent then
                            if x == sCar then TweenService:Create(b, AnimInfo.Fast, {BackgroundColor3 = Theme.Accent}):Play()
                            else TweenService:Create(b, AnimInfo.Fast, {BackgroundColor3 = Theme.ElementBg}):Play() end
                        else
                            b:Destroy(); cBts[x] = nil
                        end
                    end
                end)
            end
        end
    end
    Notify(T("Сканирование мира завершено"), Theme.Green)
end)

-- ==========================================
-- ВКЛАДКА "ЛУТ" (кнопка наверху, таблицы на всю высоту)
-- ==========================================
local FindItemsBtn = CreateButtonEx(PageItems, T("🔍 НАЙТИ ПРЕДМЕТЫ И МОТОРЫ"), Theme.Accent, Theme.AccentHover, function() end)
FindItemsBtn.LayoutOrder = 1
FindItemsBtn.Size = UDim2.new(0.98, 0, 0, 46)
FindItemsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local ItemsLayoutCont = Create("Frame", {Size = UDim2.new(1, 0, 1, -62), BackgroundTransparency = 1, LayoutOrder = 2, Parent = PageItems})
local iL = Create("ScrollingFrame", {Size = UDim2.new(0.35, 0, 1, 0), BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = ItemsLayoutCont})
local iT = Create("ScrollingFrame", {Size = UDim2.new(0.63, 0, 1, 0), Position = UDim2.new(0.37, 0, 0, 0), BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, ScrollBarAutoHide = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ElasticBehavior = Enum.ElasticBehavior.Never, Parent = ItemsLayoutCont})
ClampScroll(iL)
ClampScroll(iT)

Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = iL})
Create("UIListLayout", {Padding = UDim.new(0, 6), Parent = iT})

local sIt = nil
local iBts = {}
local sItHL = nil

FindItemsBtn.MouseButton1Click:Connect(function()
    for _, o in pairs(Workspace:GetDescendants()) do
        local n = o.Name:lower()
        local isSound = o:IsA("Sound") or o:IsA("AudioPlayer") or n:match("sound") or n:match("audio")
        local isEngine = n:match("engine")
        local isItem = o:IsA("Model") and (o:FindFirstChild("chance") or o:FindFirstChild("id") or o:FindFirstChild("Values") or o:FindFirstChild("values"))

        if not isSound and not iBts[o] and (isItem or (o:IsA("Model") and isEngine)) then

            iBts[o] = CreateButtonEx(iL, o.Name, Theme.ElementBg, Theme.ElementHover, function()
                sIt = (sIt == o) and nil or o
                sItHL = applyHighlight(sIt, Theme.Gold)

                for _, c in pairs(iT:GetChildren()) do
                    if not c:IsA("UIListLayout") then c:Destroy() end
                end

                if sIt then
                    Notify(T("Выбран предмет: ") .. o.Name, Theme.Gold)
                    local vals = sIt:FindFirstChild("Values") or sIt:FindFirstChild("values") or sIt
                    for _, v in pairs(vals:GetDescendants()) do
                        if v:IsA("ValueBase") then Val(iT, v, v.Name) end
                    end
                end

                for x, b in pairs(iBts) do
                    if x.Parent then
                        if x == sIt then TweenService:Create(b, AnimInfo.Fast, {BackgroundColor3 = Theme.Accent}):Play()
                        else TweenService:Create(b, AnimInfo.Fast, {BackgroundColor3 = Theme.ElementBg}):Play() end
                    else
                        b:Destroy(); iBts[x] = nil
                    end
                end
            end)
        end
    end
    Notify(T("Сканирование завершено"), Theme.Green)
end)

-- ==========================================
-- ОКНО ПОЛЁТА (в стиле нашего меню: шапка, кнопки, список машин, перетаскивание)
-- ==========================================
local flightWin = nil
local function OpenFlightWindow()
    if flightWin and flightWin.Parent then
        flightWin.Visible = not flightWin.Visible
        return
    end
    if not CoreGui:FindFirstChild("FlightWindowGui") then
        local fg = Instance.new("ScreenGui")
        fg.Name = "FlightWindowGui"
        fg.ResetOnSpawn = false
        fg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        fg.Parent = CoreGui

        local win = Instance.new("Frame")
        win.Name = "FlightWin"
        win.Size = UDim2.new(0, 380, 0, 420)
        win.Position = UDim2.new(0.6, 0, 0.3, 0)
        win.BackgroundColor3 = Theme.Background
        win.BorderSizePixel = 0
        win.Visible = true
        win.Parent = fg
        Instance.new("UICorner", win).CornerRadius = UDim.new(0, 14)
        Instance.new("UIStroke", win).Color = Theme.Outline

        -- Шапка в стиле меню
        local winHeader = Instance.new("Frame")
        winHeader.Size = UDim2.new(1, 0, 0, 40)
        winHeader.BackgroundColor3 = Theme.Header
        winHeader.BorderSizePixel = 0
        winHeader.Parent = win
        Instance.new("UICorner", winHeader).CornerRadius = UDim.new(0, 14)

        local winTitle = Instance.new("TextLabel")
        winTitle.Size = UDim2.new(1, -120, 1, 0)
        winTitle.Position = UDim2.new(0, 12, 0, 0)
        winTitle.BackgroundTransparency = 1
        winTitle.Text = "⚡ ПОЛЁТ МАШИНЫ"
        winTitle.TextColor3 = Theme.Text
        winTitle.Font = Enum.Font.GothamBold
        winTitle.TextSize = 14
        winTitle.TextXAlignment = Enum.TextXAlignment.Left
        winTitle.Parent = winHeader

        local winRefresh = Instance.new("TextButton")
        winRefresh.Size = UDim2.new(0, 60, 0, 28)
        winRefresh.Position = UDim2.new(1, -104, 0, 6)
        winRefresh.BackgroundColor3 = Theme.Accent
        winRefresh.Text = "🔄 ОБНОВИТЬ"
        winRefresh.TextColor3 = Color3.new(1, 1, 1)
        winRefresh.Font = Enum.Font.GothamSemibold
        winRefresh.TextSize = 10
        winRefresh.Parent = winHeader
        Instance.new("UICorner", winRefresh).CornerRadius = UDim.new(0, 6)
        winRefresh.MouseButton1Click:Connect(function()
            refreshFlightCars()
            Notify("Список обновлён", Theme.Green)
        end)

        local winClose = Instance.new("TextButton")
        winClose.Size = UDim2.new(0, 32, 0, 32)
        winClose.Position = UDim2.new(1, -38, 0, 4)
        winClose.BackgroundColor3 = Theme.TabUnselected
        winClose.Text = "✕"
        winClose.TextColor3 = Theme.TextDim
        winClose.Font = Enum.Font.GothamBold
        winClose.TextSize = 14
        winClose.Parent = winHeader
        Instance.new("UICorner", winClose).CornerRadius = UDim.new(0, 6)
        winClose.MouseEnter:Connect(function() winClose.TextColor3 = Theme.Red end)
        winClose.MouseLeave:Connect(function() winClose.TextColor3 = Theme.TextDim end)
        winClose.MouseButton1Click:Connect(function() win.Visible = false end)

        -- Перетаскивание окна за шапку
        local dragning, dStart, wStart = false, nil, nil
        winHeader.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragning = true
                dStart = input.Position
                wStart = win.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragning = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragning and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dStart
                win.Position = UDim2.new(wStart.X.Scale, wStart.X.Offset + delta.X, wStart.Y.Scale, wStart.Y.Offset + delta.Y)
            end
        end)

        -- Список машин
        local carHeader = Instance.new("TextLabel")
        carHeader.Size = UDim2.new(1, -20, 0, 20)
        carHeader.Position = UDim2.new(0, 10, 0, 48)
        carHeader.BackgroundTransparency = 1
        carHeader.Text = "🚗 МАШИНЫ В МИРЕ:"
        carHeader.TextColor3 = Theme.TextDim
        carHeader.Font = Enum.Font.GothamSemibold
        carHeader.TextSize = 11
        carHeader.TextXAlignment = Enum.TextXAlignment.Left
        carHeader.Parent = win

        local carList = Instance.new("ScrollingFrame")
        carList.Size = UDim2.new(1, -20, 0, 180)
        carList.Position = UDim2.new(0, 10, 0, 70)
        carList.BackgroundColor3 = Theme.ElementBg
        carList.BorderSizePixel = 0
        carList.ScrollBarThickness = 4
        carList.ScrollBarAutoHide = true
        carList.Parent = win
        Instance.new("UICorner", carList).CornerRadius = UDim.new(0, 8)
        local carLayout = Instance.new("UIListLayout")
        carLayout.Padding = UDim.new(0, 4)
        carLayout.Parent = carList
        ClampScroll(carList)

        local selectedFlightCar = nil

        local function refreshFlightCars()
            for _, c in ipairs(carList:GetChildren()) do
                if c:IsA("TextButton") then c:Destroy() end
            end
            local count = 0
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and not Players:GetPlayerFromCharacter(obj) then
                    local n = obj.Name:lower()
                    local nameHit = n:match("car") or n:match("van") or n:match("bus") or n:match("buggy") or n:match("moped") or n:match("lada") or n:match("sedan") or n:match("maincar") or n:match("truck") or n:match("motor")
                    local hasSteering = obj:FindFirstChild("SteeringWheel", true) or obj:FindFirstChild("Steering", true)
                    -- Любая деталь-колесо/шина в модели
                    local hasWheelPart = false
                    for _, part in ipairs(obj:GetDescendants()) do
                        local pn = part.Name:lower()
                        if part:IsA("BasePart") and (pn:match("wheel") or pn:match("tire") or pn:match("rim")) then
                            hasWheelPart = true
                            break
                        end
                    end
                    if (nameHit or hasSteering or hasWheelPart) then
                        local root = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if root then
                            local btn = Instance.new("TextButton")
                            btn.Size = UDim2.new(1, 0, 0, 28)
                            btn.BackgroundColor3 = Theme.ElementBg
                            btn.Text = obj.Name
                            btn.TextColor3 = Theme.Text
                            btn.Font = Enum.Font.Gotham
                            btn.TextSize = 11
                            btn.TextXAlignment = Enum.TextXAlignment.Left
                            btn.Parent = carList
                            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
                            btn.MouseButton1Click:Connect(function()
                                if selectedFlightCar then clearCarHighlight(selectedFlightCar) end
                                selectedFlightCar = obj
                                windowFlightState.selectedCar = obj
                                applyCarHighlight(obj)
                                carHeader.Text = "🚗 Выбрана: " .. obj.Name
                                carHeader.TextColor3 = Theme.Gold
                                for _, c in ipairs(carList:GetChildren()) do
                                    if c:IsA("TextButton") then
                                        local isSel = (c.Text == obj.Name)
                                        c.BackgroundColor3 = isSel and Theme.Accent or Theme.ElementBg
                                        c.TextColor3 = isSel and Color3.new(1, 1, 1) or Theme.Text
                                    end
                                end
                            end)
                            count = count + 1
                        end
                    end
                end
            end
            carHeader.Text = "🚗 МАШИНЫ (" .. count .. ")"
            if count == 0 then
                local empty = Instance.new("TextLabel")
                empty.Size = UDim2.new(1, 0, 0, 28)
                empty.BackgroundColor3 = Theme.DeepBg
                empty.Text = "Машин не найдено — жми ОБНОВИТЬ"
                empty.TextColor3 = Theme.TextDim
                empty.Font = Enum.Font.Gotham
                empty.TextSize = 10
                empty.Parent = carList
                Instance.new("UICorner", empty).CornerRadius = UDim.new(0, 6)
            end
            pcall(function()
                carList.CanvasSize = UDim2.new(0, 0, 0, carLayout.AbsoluteContentSize.Y)
            end)
        end

        local flyToggleBtn = Instance.new("TextButton")
        flyToggleBtn.Name = "FlyToggleButton"
        flyToggleBtn.Size = UDim2.new(0.9, 0, 0, 34)
        flyToggleBtn.Position = UDim2.new(0.05, 0, 0, 294)
        flyToggleBtn.BackgroundColor3 = Theme.Red
        flyToggleBtn.Text = "[M] Полёт: ВЫКЛ"
        flyToggleBtn.TextColor3 = Color3.new(1, 1, 1)
        flyToggleBtn.Font = Enum.Font.GothamBold
        flyToggleBtn.TextSize = 12
        flyToggleBtn.Parent = win
        Instance.new("UICorner", flyToggleBtn).CornerRadius = UDim.new(0, 6)
        flyToggleBtn.MouseButton1Click:Connect(function()
            if not windowFlightState.selectedCar and not selectedFlightCar then Notify("Сначала выбери машину", Theme.Red) return end
            if not windowFlightState.selectedCar then windowFlightState.selectedCar = selectedFlightCar end
            toggleWindowFlight(flyToggleBtn, nil)
        end)

        local winHint = Instance.new("TextLabel")
        winHint.Size = UDim2.new(1, -20, 0, 16)
        winHint.Position = UDim2.new(0, 10, 0, 340)
        winHint.BackgroundTransparency = 1
        winHint.Text = "M — полёт, Space — газ, Ctrl — тормоз, WASD — повороты"
        winHint.TextColor3 = Theme.TextDim
        winHint.Font = Enum.Font.Gotham
        winHint.TextSize = 10
        winHint.Parent = win

        local flightWinInternal = {
            win = win,
            toggle = nil,
            setCar = function(obj) selectedFlightCar = obj end
        }

        flightWin = win
        _G.ToolboxFlightWindow = flightWinInternal

        refreshFlightCars()

        Notify("Окно полёта открыто", Theme.Gold)
    else
        flightWin = CoreGui.FlightWindowGui:FindFirstChild("FlightWin")
        if flightWin then flightWin.Visible = true end
    end
end

-- ==========================================
-- РАБОЧАЯ ЛОГИКА ПОЛЁТА (по коду пользователя)
-- ==========================================
local windowFlightState = {
    isFlying = false,
    isControlActive = true,
    currentSpeed = 0,
    currentFlightCFrame = CFrame.new(),
    attachment = nil,
    linVel = nil,
    alignOrient = nil,
    selectedCar = nil,
    flyingCar = nil,
    activePart = nil,
    savedProps = {}
}

local FLY_KEY = Enum.KeyCode.M
local MAX_SPEED = 364
local ACCELERATION = 60
local BRAKING = 150
local TARGET_EVENTS = {"dam", "damage", "crashdetails", "falldamage", "crashragdoll", "fd"}

if hookmetamethod then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local st = windowFlightState
        if st.isFlying and (method == "FireServer" or method == "InvokeServer") then
            local rn = string.lower(self.Name)
            for _, nm in ipairs(TARGET_EVENTS) do
                if rn == nm or string.find(rn, nm, 1, true) then
                    return nil
                end
            end
        end
        return oldNamecall(self, ...)
    end)
end

local function setCarCollisions(model, canCollide)
    if not model then return end
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            if not canCollide then
                if not windowFlightState.savedProps[part] then
                    windowFlightState.savedProps[part] = {Collide = part.CanCollide, Touch = part.CanTouch}
                end
                part.CanCollide = false
                part.CanTouch = false
            else
                if windowFlightState.savedProps[part] then
                    part.CanCollide = windowFlightState.savedProps[part].Collide
                    part.CanTouch = windowFlightState.savedProps[part].Touch
                    windowFlightState.savedProps[part] = nil
                end
            end
        end
    end
end

local function applyCarHighlight(carModel)
    if not carModel then return end
    local old = carModel:FindFirstChild("BlueTargetHighlight")
    if old then old:Destroy() end
    if windowFlightState.isFlying then return end
    local hl = Instance.new("Highlight")
    hl.Name = "BlueTargetHighlight"
    hl.FillColor = Color3.fromRGB(0, 85, 255)
    hl.FillTransparency = 0.75
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.OutlineTransparency = 0.2
    hl.Parent = carModel
end

local function clearCarHighlight(carModel)
    if not carModel then return end
    local old = carModel:FindFirstChild("BlueTargetHighlight")
    if old then old:Destroy() end
end

local function setWindowFlightStatus(btn)
    if not btn then return end
    local st = windowFlightState
    if st.isFlying then
        btn.Text = "[M] Полёт: ВКЛ"
        btn.BackgroundColor3 = Theme.Green
    else
        btn.Text = "[M] Полёт: ВЫКЛ"
        btn.BackgroundColor3 = Theme.Red
    end
end

local function toggleWindowFlight(flyBtn, statusLabel)
    local st = windowFlightState
    if st.isFlying then
        st.isFlying = false
        if st.flyingCar then
            setCarCollisions(st.flyingCar, true)
            applyCarHighlight(st.flyingCar)
        end
        if st.linVel then st.linVel:Destroy() st.linVel = nil end
        if st.alignOrient then st.alignOrient:Destroy() st.alignOrient = nil end
        if st.attachment then st.attachment:Destroy() st.attachment = nil end
        st.flyingCar = nil
        st.activePart = nil
        st.currentSpeed = 0
        setWindowFlightStatus(flyBtn)
        if statusLabel then statusLabel.Text = "Полёт выключен" end
    else
        if not st.selectedCar then Notify("Сначала выбери машину", Theme.Red) return end
        st.flyingCar = st.selectedCar
        st.activePart = st.flyingCar.PrimaryPart or st.flyingCar:FindFirstChildWhichIsA("BasePart")
        if not st.activePart then return end
        setCarCollisions(st.flyingCar, false)
        clearCarHighlight(st.flyingCar)

        st.currentFlightCFrame = st.flyingCar:GetPivot()

        st.attachment = Instance.new("Attachment")
        st.attachment.Parent = st.activePart
        st.attachment.WorldCFrame = st.currentFlightCFrame

        st.linVel = Instance.new("LinearVelocity")
        st.linVel.Attachment0 = st.attachment
        st.linVel.MaxForce = math.huge
        st.linVel.VectorVelocity = Vector3.zero
        st.linVel.RelativeTo = Enum.ActuatorRelativeTo.World
        st.linVel.Parent = st.activePart

        st.alignOrient = Instance.new("AlignOrientation")
        st.alignOrient.Attachment0 = st.attachment
        st.alignOrient.Mode = Enum.OrientationAlignmentMode.OneAttachment
        st.alignOrient.RigidityEnabled = true
        st.alignOrient.CFrame = st.currentFlightCFrame
        st.alignOrient.Parent = st.activePart

        st.currentSpeed = 0
        st.isFlying = true
        setWindowFlightStatus(flyBtn)
        if statusLabel then statusLabel.Text = "Полёт включён" end
    end
end

RunService.RenderStepped:Connect(function(deltaTime)
    local st = windowFlightState
    if not st.isFlying or not st.linVel or not st.alignOrient then return end
    if not st.flyingCar or not st.flyingCar.Parent then
        st.isFlying = false
        return
    end

    local pitchInput = 0
    local yawInput = 0

    if st.isControlActive then
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            st.currentSpeed = math.min(st.currentSpeed + (ACCELERATION * deltaTime), MAX_SPEED)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            st.currentSpeed = math.max(st.currentSpeed - (BRAKING * deltaTime), 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then pitchInput = -1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then pitchInput = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then yawInput = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then yawInput = -1 end
    else
        st.currentSpeed = math.max(st.currentSpeed - (BRAKING * deltaTime), 0)
    end

    local turnSpeed = 2.0 * deltaTime
    local pitchSpeed = 1.5 * deltaTime
    local pos = st.currentFlightCFrame.Position
    local rx, ry, rz = st.currentFlightCFrame:ToEulerAnglesYXZ()
    if pitchInput == 0 then
        rx = rx * 0.92
    else
        rx = math.clamp(rx + pitchInput * pitchSpeed, -math.rad(75), math.rad(75))
    end
    ry = ry + yawInput * turnSpeed
    rz = 0
    st.currentFlightCFrame = CFrame.new(pos) * CFrame.Angles(0, ry, 0) * CFrame.Angles(rx, 0, rz)
    st.alignOrient.CFrame = st.currentFlightCFrame
    st.linVel.VectorVelocity = st.currentFlightCFrame.LookVector * st.currentSpeed
end)

-- Подключаем кнопки окна к рабочей логике
local function bindFlightWindowControls()
    if _G.ToolboxFlightWindow and _G.ToolboxFlightWindow.win then
        _G.ToolboxFlightWindow.toggle = function(btn, statusLabel)
            toggleWindowFlight(btn, statusLabel)
        end
        _G.ToolboxFlightWindow.setSelectedCar = function(obj)
            windowFlightState.selectedCar = obj
        end
        local flyBtn = _G.ToolboxFlightWindow.win:FindFirstChild("FlyToggleButton", true)
        if flyBtn then
            flyBtn.MouseButton1Click:Connect(function()
                toggleWindowFlight(flyBtn, nil)
            end)
        end
    end
end
task.spawn(function()
    task.wait(0.5)
    bindFlightWindowControls()
end)

-- ==========================================
-- ВКЛАДКА "ИГРОКИ И ЧИТЫ" (V5: БЕЗ выбора игрока — всё сразу на себя)
-- ==========================================
local states = {}
local flyActive = false
local flySpeed = 50
local flyKeys = {W = false, A = false, S = false, D = false, Space = false, Shift = false}
local IYFlyBG, IYFlyBV = nil, nil
local detonatorActive = false
local activatorActive = false

local function getDebugUi()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then for _, gui in pairs(pg:GetChildren()) do if gui.Name:lower() == "debugui" then return gui end end end
    for _, gui in pairs(CoreGui:GetChildren()) do if gui.Name:lower() == "debugui" then return gui end end
    return nil
end

local function toggleIYFly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")

    if flyActive then
        flyActive = false
        Notify(T("Полёт выключен"), Theme.Red)
        if IYFlyBG then IYFlyBG:Destroy() IYFlyBG = nil end
        if IYFlyBV then IYFlyBV:Destroy() IYFlyBV = nil end
        if hum then hum.PlatformStand = false end
    else
        flyActive = true
        Notify(T("Полёт включён (ПКМ CTRL — переключить)"), Theme.Green)
        if hum then hum.PlatformStand = true end

        IYFlyBG = Instance.new("BodyGyro")
        IYFlyBG.P = 9e4
        IYFlyBG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        IYFlyBG.cframe = hrp.CFrame
        IYFlyBG.Parent = hrp

        IYFlyBV = Instance.new("BodyVelocity")
        IYFlyBV.velocity = Vector3.new(0,0,0)
        IYFlyBV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        IYFlyBV.Parent = hrp

        task.spawn(function()
            while flyActive and char and char:FindFirstChild("HumanoidRootPart") do
                local cam = Workspace.CurrentCamera
                IYFlyBG.cframe = cam.CFrame

                local moveDir = Vector3.zero
                if flyKeys.W then moveDir = moveDir + cam.CFrame.LookVector end
                if flyKeys.S then moveDir = moveDir - cam.CFrame.LookVector end
                if flyKeys.A then moveDir = moveDir - cam.CFrame.RightVector end
                if flyKeys.D then moveDir = moveDir + cam.CFrame.RightVector end
                if flyKeys.Space then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if flyKeys.Shift then moveDir = moveDir - Vector3.new(0, 1, 0) end

                if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end
                IYFlyBV.velocity = moveDir * flySpeed
                RunService.RenderStepped:Wait()
            end
            if IYFlyBG then IYFlyBG:Destroy() IYFlyBG = nil end
            if IYFlyBV then IYFlyBV:Destroy() IYFlyBV = nil end
            if hum then hum.PlatformStand = false end
        end)
    end
end

-- ==========================================
-- ПРОФИЛЬ ИГРОКА
-- ==========================================
local profileCard = Create("Frame", {Size = UDim2.new(0.98, 0, 0, 84), BackgroundColor3 = Theme.ElementBg, BorderSizePixel = 0, Parent = PagePlayers})
AddCorner(profileCard, 12)
AddStroke(profileCard, Theme.Outline, 1)

local profileAvatar = Create("Frame", {Size = UDim2.new(0, 56, 0, 56), Position = UDim2.new(0, 12, 0, 12), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = profileCard})
AddCorner(profileAvatar, 28)
Create("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = string.sub(LocalPlayer.Name, 1, 1):upper(), TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 24, Parent = profileAvatar})

local profileName = Create("TextLabel", {Size = UDim2.new(1, -80, 0, 22), Position = UDim2.new(0, 78, 0, 14), BackgroundTransparency = 1, Text = LocalPlayer.Name, TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, Parent = profileCard})

local profileStatus = Create("TextLabel", {Size = UDim2.new(1, -80, 0, 18), Position = UDim2.new(0, 78, 0, 38), BackgroundTransparency = 1, Text = "В игре", TextColor3 = Theme.Green, Font = Enum.Font.Gotham, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, Parent = profileCard})
task.spawn(function()
    while profileCard and profileCard.Parent do
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    profileStatus.Text = "❤ " .. math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)
                end
            end
        end)
        task.wait(1)
    end
end)

-- Разделитель-полоска между профилем и функциями
Create("Frame", {Size = UDim2.new(0.98, 0, 0, 2), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = PagePlayers})

Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 26), BackgroundTransparency = 1, Text = T(" ЧИТЫ"), TextColor3 = Theme.Green, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = PagePlayers})

local function PlayerToggle(text, remoteName, stateKey, callback)
    local st = states[stateKey] or false
    CreateToggle(PagePlayers, text, st, function(newState)
        states[stateKey] = newState
        if callback then callback(newState) end
        if remoteName then task.spawn(function() TryFire(remoteName, LocalPlayer, newState) end) end
    end)
end

PlayerToggle("Нет голода", "nohunger", "nohunger")
PlayerToggle("Нет стамины", "nostamina", "nostamina")
PlayerToggle("Нет регдолла", "noragdoll", "noragdoll")
PlayerToggle("Бессмертие", "godmode", "godmode")
PlayerToggle("Бессмертие машины", "godcar", "godcar")

Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 24), BackgroundTransparency = 1, Text = T(" ПОЛЕТ (БЕЗ ГРАВИТАЦИИ): ПРАВЫЙ CTRL"), TextColor3 = Theme.Accent, Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = PagePlayers})

PlayerToggle("Удалятор (debugui)", nil, "deleter", function(state)
    local dbg = getDebugUi()
    if dbg then
        if dbg:IsA("ScreenGui") then dbg.Enabled = state
        elseif dbg:IsA("GuiObject") then dbg.Visible = state end
    end
end)

local curFov = math.clamp(math.floor(Workspace.CurrentCamera.FieldOfView), 60, 120)
Slider(PagePlayers, "Угол обзора (FOV)", 60, 120, 1, curFov, function(val) Workspace.CurrentCamera.FieldOfView = val end)

PlayerToggle("Детонатор (Кнопка P)", nil, "detonator", function(state) detonatorActive = state end)
PlayerToggle("Активатор (Кнопка L)", nil, "activator", function(state) activatorActive = state end)
PlayerToggle("Спавн зомби (Зажатие Y)", nil, "spawnzombie", function() end)

-- ==========================================
-- ВВОД КЛАВИШ (ПОЛЕТ И ДЕТОНАТОРЫ — СОХРАНЕНО)
-- ==========================================
local isYDown = false
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then flyKeys.W = true end
    if input.KeyCode == Enum.KeyCode.A then flyKeys.A = true end
    if input.KeyCode == Enum.KeyCode.S then flyKeys.S = true end
    if input.KeyCode == Enum.KeyCode.D then flyKeys.D = true end
    if input.KeyCode == Enum.KeyCode.Space then flyKeys.Space = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then flyKeys.Shift = true end
    if input.KeyCode == Enum.KeyCode.RightControl then toggleIYFly() end
    if input.KeyCode == Enum.KeyCode.M then
        local flyBtn = nil
        if _G.ToolboxFlightWindow and _G.ToolboxFlightWindow.win then
            flyBtn = _G.ToolboxFlightWindow.win:FindFirstChild("FlyToggleButton", true)
        end
        if not windowFlightState.selectedCar and not flyBtn then Notify("Открой окно полёта и выбери машину", Theme.Red) return end
        toggleWindowFlight(flyBtn, nil)
    end

    if input.KeyCode == Enum.KeyCode.Y then
        if states.spawnzombie then
            isYDown = true
            task.spawn(function()
                while isYDown do
                    pcall(function()
                        local Event = ReplicatedStorage:FindFirstChild("sandboxconnection") and ReplicatedStorage.sandboxconnection:FindFirstChild("spawnzombie")
                        if Event then
                            if Event:IsA("RemoteFunction") then Event:InvokeServer()
                            elseif Event:IsA("RemoteEvent") then Event:FireServer() end
                        end
                    end)
                    task.wait()
                end
            end)
        end
    elseif input.KeyCode == Enum.KeyCode.P and detonatorActive then
        task.spawn(function()
            for _, obj in pairs(game:GetDescendants()) do
                local n = obj.Name
                if n == "tnt" or n == "bomb" then
                    local part = obj:FindFirstChild("Part")
                    if part then FireToggle(part) end
                elseif n == "firework" then
                    local model = obj:FindFirstChild("Model") or obj:FindFirstChild("model")
                    if model then
                        local main = model:FindFirstChild("main")
                        if main then FireToggle(main) end
                    end
                elseif n == "Gift1" or n == "Gift2" or n == "Gift3" then
                    local ma = obj:FindFirstChild("ma")
                    if ma then FireToggle(ma) end
                end
            end
        end)
elseif input.KeyCode == Enum.KeyCode.L and activatorActive then
        task.spawn(function()
            for _, obj in pairs(game:GetDescendants()) do
                if obj.Name == "turbine" then
                    local trust = obj:FindFirstChild("TRUST")
                    if trust then FireToggle(trust) end
                end
            end
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Y then isYDown = false end
    if input.KeyCode == Enum.KeyCode.W then flyKeys.W = false end
    if input.KeyCode == Enum.KeyCode.A then flyKeys.A = false end
    if input.KeyCode == Enum.KeyCode.S then flyKeys.S = false end
    if input.KeyCode == Enum.KeyCode.D then flyKeys.D = false end
    if input.KeyCode == Enum.KeyCode.Space then flyKeys.Space = false end
    if input.KeyCode == Enum.KeyCode.LeftShift then flyKeys.Shift = false end
end)

-- ==========================================
-- Кнопка ПОЛЁТ — в самом низу вкладки ИГРОКИ
-- ==========================================
CreateButtonEx(PagePlayers, "🕊 ПОЛЁТ", Theme.Accent, Theme.AccentHover, function()
    OpenFlightWindow()
end)

-- ==========================================
-- ПРИМЕНЕНИЕ ТЕМЫ / ЯЗЫКА
-- ==========================================
local hotkeyCardLabel = nil

local function RefreshValButtons()
    for _, e in ipairs(valButtons) do
        if e.label then
            e.label.Text = e.name
        else
            e.btn.Text = e.name .. (e.valueObj.Value and T(": ВКЛ") or T(": ВЫКЛ"))
        end
    end
end

local function RefreshSliders()
    for _, e in ipairs(sliderRegistry) do
        e.label.Text = T(e.baseKey) .. ": " .. tostring(e.getVal())
    end
end

local function RefreshHotkeys()
    if not hotkeyCardLabel then return end
    hotkeyCardLabel.Text = table.concat({
        T("• Правый CTRL — вкл/выкл полёт (WASD + Space/Shift)"),
        T("• CTRL + Левый Клик — телепорт (вкл. во вкладке ТЕЛЕПОРТ)"),
        T("• Y (зажать) — спавн зомби (вкл. в ИГРОКАХ)"),
        T("• P — детонатор: активирует tnt/bomb/firework/подарки"),
        T("• L — активатор: запускает турбины (TRUST)"),
        T("• Кнопка меню (3 полоски) — открыть меню после закрытия"),
        "",
        T("Все функции доступны сразу во вкладке ИГРОКИ.")
    }, "\n")
end

local function ApplyTheme(name)
    local pal = Palettes[name] or Palettes.black
    local directMap = {
        [MainFrame] = pal.Background,
        [Header] = pal.Header,
        [Sidebar] = pal.Sidebar,
        [Footer] = pal.Footer,
        [OpenBtn] = pal.Accent
    }
    for _, obj in ipairs(ScreenGui:GetDescendants()) do
        if obj:IsA("GuiObject") then
            if directMap[obj] ~= nil then
                obj.BackgroundColor3 = directMap[obj]
            end
            local bgKey = obj:GetAttribute("BgKey")
            if bgKey and pal[bgKey] then
                obj.BackgroundColor3 = pal[bgKey]
            end
            local txtKey = obj:GetAttribute("TextKey")
            if txtKey and pal[txtKey] then
                obj.TextColor3 = pal[txtKey]
            end
            local baseKeyA = obj:GetAttribute("BaseKey")
            if baseKeyA and pal[baseKeyA] then
                obj:SetAttribute("BaseColor", pal[baseKeyA])
                obj.BackgroundColor3 = pal[baseKeyA]
            end
            local hoverKeyA = obj:GetAttribute("HoverKey")
            if hoverKeyA and pal[hoverKeyA] then
                obj:SetAttribute("HoverColor", pal[hoverKeyA])
            end
        elseif obj:IsA("UIStroke") then
            local strokeKey = obj:GetAttribute("StrokeKey")
            if strokeKey and pal[strokeKey] then
                obj.Color = pal[strokeKey]
            end
        end
    end

    -- Чиним белый текст на светлых кнопках после смены темы
    for _, obj in ipairs(ScreenGui:GetDescendants()) do
        if obj:IsA("GuiObject") and (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then
            local txt = obj.TextColor3
            if txt.R > 0.9 and txt.G > 0.9 and txt.B > 0.9 and obj.BackgroundTransparency < 0.8 then
                local bg = obj.BackgroundColor3
                local lum = bg.R * 0.299 + bg.G * 0.587 + bg.B * 0.114
                if lum > 0.65 then
                    obj.TextColor3 = pal.Text
                end
            end
        end
    end
    Theme = pal
    CurrentTheme = name
    local glass = (name == "transparent")
    MainBaseTransparency = glass and 0.3 or 0
    PanelBaseTransparency = glass and 0.15 or 0
    if MainFrame.Visible then
        RestorePanelTransparency()
    end
end

local function ApplyLanguage(lang)
    curLang = lang
    for _, obj in ipairs(ScreenGui:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local src = obj:GetAttribute("SrcText")
            if src then
                local tr = I18N[lang] and I18N[lang][src]
                obj.Text = tr or src
            end
        end
end
    if _G.ToolboxFlightWindow and _G.ToolboxFlightWindow.win then
        local plrCount = #Players:GetPlayers()
        local status = _G.ToolboxFlightWindow.win:FindFirstChild("PlayerCountLabel")
        if status then status.Text = "Игроков: " .. tostring(plrCount) end
    end
    RefreshValButtons()
    RefreshSliders()
    RefreshHotkeys()
end

-- ==========================================
-- ВКЛАДКА НАСТРОЙКИ (темы / языки / кнопка меню)
-- ==========================================
CreateButtonEx(PageSettings, T("💻 ЗАПУСТИТЬ Infinite Yield (Консоль)"), Theme.ElementBg, Theme.ElementHover, function()
    pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
    Notify(T("Infinite Yield запущен"), Theme.Gold)
end)

local function BuildSelector(parent, sectionLabel, options, defaultIndex, onSelect)
    Create("TextLabel", {Size = UDim2.new(0.98, 0, 0, 22), BackgroundTransparency = 1, Text = sectionLabel, TextColor3 = Theme.TextDim, Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local refs = {}
    local function PaintRefs(activeIdx)
        for j, r in ipairs(refs) do
            local active = (j == activeIdx)
            local bg = active and Theme.Accent or Theme.ElementBg
            local hov = active and Theme.AccentHover or Theme.ElementHover
            r:SetAttribute("BaseKey", active and "Accent" or "ElementBg")
            r:SetAttribute("HoverKey", active and "AccentHover" or "ElementHover")
            r:SetAttribute("BaseColor", bg)
            r:SetAttribute("HoverColor", hov)
            TweenService:Create(r, AnimInfo.Fast, {BackgroundColor3 = bg}):Play()
            TweenService:Create(r, AnimInfo.Fast, {TextColor3 = active and Color3.fromRGB(255, 255, 255) or Theme.Text}):Play()
            r.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Theme.Text
        end
    end
    for i, opt in ipairs(options) do
        local sel = (i == defaultIndex)
        local b = CreateButtonEx(parent, opt.label, sel and Theme.Accent or Theme.ElementBg, sel and Theme.AccentHover or Theme.ElementHover, function()
            PaintRefs(i)
            onSelect(opt.value)
        end)
        refs[i] = b
    end
    PaintRefs(defaultIndex)
    return refs
end

BuildSelector(PageSettings, "ТЕМА", {
    {label = "Чёрная", value = "black"},
    {label = "Белая", value = "white"},
    {label = "Прозрачная", value = "transparent"}
}, 1, ApplyTheme)

BuildSelector(PageSettings, "ЯЗЫК", {
    {label = "Русский", value = "ru"},
    {label = "English", value = "en"},
    {label = "Українська", value = "ua"}
}, 1, ApplyLanguage)

BuildSelector(PageSettings, "КНОПКА МЕНЮ", {
    {label = "Круглая (углы и края)", value = "round"},
    {label = "Плоская (верх и низ)", value = "flat"}
}, 1, SetButtonStyle)

-- Информационная карточка с горячими клавишами
local InfoCard = Create("Frame", {
    Size = UDim2.new(0.98, 0, 0, 190),
    BackgroundColor3 = Theme.ElementBg,
    BorderSizePixel = 0,
    Parent = PageSettings
})
AddCorner(InfoCard, 10)
AddStroke(InfoCard, Theme.Outline, 1)

Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 24),
    Position = UDim2.new(0, 12, 0, 8),
    BackgroundTransparency = 1,
    Text = T("📖 ГОРЯЧИЕ КЛАВИШИ"),
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = InfoCard
})

hotkeyCardLabel = Create("TextLabel", {
    Size = UDim2.new(1, -24, 1, -40),
    Position = UDim2.new(0, 12, 0, 34),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = Theme.TextDim,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    Parent = InfoCard
})
RefreshHotkeys()

-- ==========================================
-- ФИНАЛИЗАЦИЯ: захват исходных текстов, стиль кнопки, приветствие
-- ==========================================
local function CaptureSourceText()
    for _, obj in ipairs(ScreenGui:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            obj:SetAttribute("SrcText", obj.Text)
        end
    end
end

SetButtonStyle("round")
CaptureSourceText()
Notify("T00LB0XV2 " .. SCRIPT_VERSION .. T(" загружен"), Theme.Accent)
