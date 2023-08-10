-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT customers.company_name, first_name, last_name, city, shippers.company_name
FROM orders
JOIN employees USING (employee_id)
JOIN customers USING (city,customer_id)
JOIN shippers ON shippers.shipper_id=orders.ship_via
WHERE city='London' and shippers.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT suppliers.contact_name, suppliers.phone, product_name, units_in_stock, category_name
FROM products
JOIN categories USING (category_id)
JOIN suppliers USING (supplier_id)
WHERE units_in_stock < 25 and category_name IN ('Dairy Products', 'Condiments')
ORDER BY units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name, COUNT(*) FROM orders
FULL JOIN customers USING (customer_id)
GROUP BY company_name
HAVING COUNT(*) <=1
ORDER BY COUNT(*)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT DISTINCT product_name FROM products
JOIN order_details USING (product_id)
WHERE quantity IN (SELECT quantity from order_details WHERE quantity = 10)
ORDER BY product_name
