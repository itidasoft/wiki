---
title: API для работы с файлами обновлений
description: Автообновление РМК
published: false
date: 2025-03-24T08:41:00.137Z
tags: 
editor: markdown
dateCreated: 2025-03-24T08:20:42.981Z
---

# Авторизация на сервере
## POST /auth/login

В теле запроса передается объект с полями:
- **username** - имя пользователя
- **password** - пароль пользователя

Пример:

```json
{
    "username": "user@mail.ru",
    "password": "123456"
}
```

## Ответ
```json
{
    "accessToken": "eyJhbGciOiJIUz...",
    "refreshToken": "eyJhbGciOiJIUzI....",
    "user": {
        "username": "user@mail.ru",
        "fullName": "User Name",
        "id": 1,
        "isActivated": true,
        "roles": "ADMIN"
    }
}
```
- **accessToken** - токен авторизации, который требуется использовать в запросах, требующих авторизацию
- **refreshToken** - токен для обновления авторизационного токена без использования логина и пароля
- **user.username** - логин авторизованного пользователя
- **user.fullName** - Имя авторизованного пользователя
- **user.id** - ИД авторизованного пользователя
- **user.isActivated** - признак активации пользователя (true - пользователь активирован, false - не активирован)
- **user.roles** - роль пользователя


# Запрос добавления файла на сервер
## POST /files/updatefile

> Требуется авторизация
{.is-info}


Содержимое в теле запроса должно быть в формате **"form-data"**
Обязательны для передачи следующие ключи:
- **date** (YYYY-MM-DD) - дата обновления
- **version** (строка) - версия обновления
- **file** - сам файл обновления

