#!/bin/bash

# Проверка прав суперпользователя
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "Этот скрипт нужно запускать от имени суперпользователя."
    exit 1
  fi
}

# Функция для установки Composer
install_composer() {
  echo "Устанавливаю Composer..."
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
}

# Функция для установки Php-parser
install_php_parser() {
  echo "Устанавливаю Php-parser..."
  composer require nikic/php-parser --dev
}

# Функция для установки Rector
install_rector() {
  echo "Устанавливаю Rector..."
  composer require rector/rector --dev
}

# Функция для установки PHPStan
install_phpstan() {
  echo "Устанавливаю PHPStan..."
  composer require --dev phpstan/phpstan
}

# Функция для установки PHP Code Sniffer
install_phpcs() {
  echo "Устанавливаю PHP Code Sniffer..."
  composer require --dev squizlabs/php_codesniffer
}

# Функция для установки PHPMD
install_phpmd() {
  echo "Устанавливаю PHPMD..."
  composer require --dev phpmd/phpmd
}

# Функция для установки HTMLHint
install_htmlhint() {
  echo "Устанавливаю HTMLHint..."
  npm install -g htmlhint
}

# Функция для установки всех инструментов
install_all_tools() {
  install_composer
  install_rector
  install_php_parser
  install_phpstan
  install_phpcs
  install_phpmd
  install_htmlhint
}

# Основное меню для выбора
show_menu() {
  echo "Выберите инструменты для установки:"
  echo "1. Установить Composer"
  echo "2. Установить Rector"
  echo "3. Установить Php-parser"
  echo "4. Установить PHPStan"
  echo "5. Установить PHP Code Sniffer"
  echo "6. Установить PHPMD"
  echo "7. Установить HTMLHint"
  echo "8. Установить все инструменты"
  echo "9. Выйти"
}

# Обработка выбора пользователя
process_choice() {
  read -p "Введите номер опции: " choice

  case $choice in
    1)
      install_composer
      ;;
    2)
      install_rector
      ;;
    3)
      install_php_parser
      ;;
    4)
      install_phpstan
      ;;
    5)
      install_phpcs
      ;;
    6)
      install_phpmd
      ;;
    7)
      install_htmlhint
      ;;
    8)
      install_all_tools
      ;;
    9)
      echo "Выход..."
      exit 0
      ;;
    *)
      echo "Неверный выбор. Попробуйте снова."
      ;;
  esac
}

# Основной скрипт
check_root
while true; do
  show_menu
  process_choice
done
