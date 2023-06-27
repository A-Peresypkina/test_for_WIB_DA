-- создание SQL базы с таблицами:

-- создание таблицы Users(userId, age)
CREATE TABLE Users(
    userId INT PRIMARY KEY, 
    age INT);

-- внесение данных в Users 
INSERT INTO Users (userId, age) VALUES
(1, 25),
(2, 37),
(3, 18),
(4, 25),
(5, 15),
(6, 55),
(7, 27),
(8, 47),
(9, 15),
(10, 35),
(11, 25);



--Создание таблицы Purchases (purchaseId, userId, itemId, date)
CREATE TABLE Purchase(
    purchaseId INT PRIMARY KEY, 
    userId INT,
    itemId INT,
    date DATE);

INSERT INTO Purchase (purchaseId, userId, itemId, DATE) VALUES
    (1, 6, 1, '01-01-2023'),
       (2, 5, 2, '07-02-2023'),
       (3, 4, 3, '01-01-2022'),
       (4, 3, 4, '12-05-2022'),
       (5, 2, 5, '12-15-1986'),
       (6, 1, 6, '08-05-1985'),
       (7, 8, 7, '01-01-2023'),
       (8, 7, 8, '07-02-2023'),
       (9, 9, 9, '01-01-2022'),
       (10, 11, 10, '12-05-2022'),
       (11, 10, 11, '12-15-1986'),
       (12, 12, 12, '08-05-1985');

--Создание таблицы Items (itemId, price)
CREATE TABLE Items(
    ItemId INT PRIMARY KEY, 
    price INT);

INSERT INTO Items (itemId, price) VALUES
       (1, 175),
       (2, 235),
       (3, 198),
       (4, 254),
       (5, 875),
       (6, 545),
    (7, 175),
       (8, 235),
       (9, 198),
       (10, 254),
       (11, 875),
       (12, 545);

