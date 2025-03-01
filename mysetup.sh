#!/bin/bash

echo "=== MySQL Управление пользователями и базами данных ==="

# Определяем команду для MySQL
MYSQL_CMD="mysql -u root -p"

# Меню действий
echo "Выберите действие:"
echo "1) Создать базу данных и пользователя"
echo "2) Удалить базу данных и пользователя"
echo "3) Показать список таблиц в базе данных"
echo "4) Показать всех пользователей MySQL"
echo "5) Сбросить пароль пользователя MySQL"
read -p "Введите номер действия (1-5): " ACTION

# Действие 1: Создание базы данных и пользователя
if [[ "$ACTION" == "1" ]]; then
    read -p "Введите имя нового пользователя MySQL: " MYSQL_USER
    read -s -p "Введите пароль (оставьте пустым для безпарольного доступа): " MYSQL_PASS
    echo
    read -p "Введите имя базы данных: " DB_NAME

    SQL="
    CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASS';
    GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$MYSQL_USER'@'localhost';
    FLUSH PRIVILEGES;
    "
    
    echo "$SQL" | $MYSQL_CMD
    echo "✅ База данных '$DB_NAME' и пользователь '$MYSQL_USER' созданы!"

# Действие 2: Удаление базы данных и пользователя
elif [[ "$ACTION" == "2" ]]; then
    read -p "Введите имя пользователя MySQL для удаления: " MYSQL_USER
    read -p "Введите имя базы данных для удаления: " DB_NAME

    SQL="
    DROP DATABASE IF EXISTS \`$DB_NAME\`;
    DROP USER IF EXISTS '$MYSQL_USER'@'localhost';
    FLUSH PRIVILEGES;
    "
    
    echo "$SQL" | $MYSQL_CMD
    echo "❌ База данных '$DB_NAME' и пользователь '$MYSQL_USER' удалены!"

# Действие 3: Вывод списка таблиц в базе данных
elif [[ "$ACTION" == "3" ]]; then
    read -p "Введите имя базы данных: " DB_NAME
    SQL="SHOW TABLES FROM \`$DB_NAME\`;"
    
    echo "$SQL" | $MYSQL_CMD

# Действие 4: Вывод списка пользователей MySQL
elif [[ "$ACTION" == "4" ]]; then
    SQL="SELECT User, Host FROM mysql.user;"
    
    echo "$SQL" | $MYSQL_CMD

# Действие 5: Сброс пароля пользователя
elif [[ "$ACTION" == "5" ]]; then
    read -p "Введите имя пользователя MySQL для смены пароля: " MYSQL_USER
    read -s -p "Введите новый пароль: " NEW_PASS
    echo
    
    SQL="
    ALTER USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$NEW_PASS';
    FLUSH PRIVILEGES;
    "
    
    echo "$SQL" | $MYSQL_CMD
    echo "🔑 Пароль пользователя '$MYSQL_USER' успешно изменен!"

else
    echo "❌ Неверный выбор. Скрипт завершен."
    exit 1
fi
