"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2

import csv

# Извлекаем данные из csv - файла и формируем список кортежей для записи

customers_for_record = []

with open('north_data/customers_data.csv', encoding='utf-8', newline='') as f:
          content = csv.DictReader(f)
          for data in content:
              customer_id = data['customer_id']
              company_name = data['company_name']
              contact_name = data['contact_name']
              customers_for_record.append((customer_id, company_name, contact_name))


# Аналогично

employees_for_record = []

with open('north_data/employees_data.csv', encoding='utf-8', newline='') as f:
          content = csv.DictReader(f)
          for data in content:
              employee_id = data['employee_id']
              first_name = data['first_name']
              last_name = data['last_name']
              title = data['title']
              birth_date = data['birth_date']
              notes = data['notes']
              employees_for_record.append((employee_id, first_name, last_name,
                                           title, birth_date, notes))



# Аналогично

orders_for_record = []

with open('north_data/orders_data.csv', encoding='utf-8', newline='') as f:
          content = csv.DictReader(f)
          for data in content:
              order_id = data['order_id']
              customer_id = data['customer_id']
              employee_id = data['employee_id']
              order_date = data['order_date']
              ship_city = data['ship_city']
              orders_for_record.append((order_id, customer_id, employee_id, order_date,
                                           ship_city))




# Подключаемся к БД и вносим туда данные

conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='12345')
try:
    with conn:
        with conn.cursor() as cur:
            cur.executemany('INSERT INTO customers VALUES (%s, %s, %s)', customers_for_record)
            cur.executemany('INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)', employees_for_record)
            cur.executemany('INSERT INTO orders VALUES (%s, %s, %s, %s, %s)', orders_for_record)


finally:
    conn.close()
