-- какую сумму в среднем в месяц тратят пользователи в возрастном диапазоне от 18 до 25 лет включительно

SELECT ROUND(AVG(items.price)/12,2) AS expenses_per_month
          --EXTRACT(MONTH FROM date) As month
FROM items 
INNER JOIN purchase ON items.itemId = purchase.itemId-- объеденим там items и price по itemId
INNER JOIN users ON purchase.userId =users.userId
WHERE users.age >= 18 AND users.age <= 25;

-- какую сумму в среднем в месяц тратят пользователи в возрастном диапазоне от 26 до 35 лет включительно
SELECT ROUND(AVG(items.price)/12,2) AS expenses_per_month
          --EXTRACT(MONTH FROM date) As month
FROM items 
INNER JOIN purchase ON items.itemId = purchase.itemId-- объеденим там items и price по itemId
INNER JOIN users ON purchase.userId =users.userId
WHERE users.age > 26 AND users.age <= 35;

-- можно сгруппировать по месяцам фактических продаж
SELECT ROUND(AVG(items.price),2),
          EXTRACT(MONTH FROM date) As month
FROM items 
INNER JOIN purchase ON items.itemid = purchase.itemid-- объеденим там items и price по item_id
INNER JOIN users ON purchase.userid = users.userid
WHERE users.age >= 18 AND users.age <= 25
GROUP BY EXTRACT(MONTH FROM date);

--в каком месяце года выручка от пользователей в возрастном диапазоне 35+ самая большая
SELECT SUM(items.price) AS revenue,
          EXTRACT(MONTH FROM Purchase.date) AS month
FROM Items 
INNER JOIN Purchase ON Items.itemid = Purchase.itemid
INNER JOIN Users ON Purchase.userid = Users.userid
WHERE Users.age >= 35
GROUP BY items.price, EXTRACT(MONTH FROM Purchase.date)
ORDER BY Items.price DESC;

В) какой товар обеспечивает дает наибольший вклад в выручку за последний год
--какой товар обеспечивает/дает наибольший вклад в выручку за последний год
SELECT i.itemid,
          i.price,
       EXTRACT(YEAR FROM p.date) AS year_of_purchase
FROM items AS I
LEFT JOIN purchase AS p ON p.itemid = I.itemid
WHERE EXTRACT(YEAR FROM p.date) = '2023'
GROUP BY i.itemid, EXTRACT(YEAR FROM p.date)
ORDER BY i.price
LIMIT 1;

--какой товар обеспечивает/дает наибольший вклад в выручку за последний год
--c применением оконной функции
SELECT 
    itemid,
    price,
    year_of_purchase
FROM (
    SELECT 
        i.itemid,
        i.price,
        EXTRACT(YEAR FROM p.date) AS year_of_purchase,
        ROW_NUMBER() OVER (ORDER BY i.price ASC) AS row_num
    FROM 
        items AS i
        LEFT JOIN purchase AS p ON p.itemid = i.itemid
    WHERE 
        EXTRACT(YEAR FROM p.date) = '2023'
    GROUP BY 
        i.itemid, 
        EXTRACT(YEAR FROM p.date)
) t
WHERE 
    t.row_num = 1;

--топ-3 товаров по выручке и их доля в общей выручке за любой год
SELECT EXTRACT(YEAR FROM purchase.date) AS year_of_purchase,
       items.itemid,
      count(*) * 100.0 / sum(count(*)) over(PARTITION BY EXTRACT(YEAR FROM purchase.date)) AS share
FROM items
LEFT JOIN purchase ON purchase.itemid = items.itemid
GROUP BY items.itemid, purchase.purchaseid
ORDER BY EXTRACT(YEAR FROM purchase.date) DESC;