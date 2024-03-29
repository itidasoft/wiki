---
title: iMark
description: Запретительный режим: проверка КМ на кассах
published: true
date: 2024-02-02T13:26:37.108Z
tags: 
editor: markdown
dateCreated: 2023-12-07T14:52:09.866Z
---

0. Указание Апи ключа и УРЛ для работы с ЧЗ (метод PUT /truemark)
1. База КМ со статусами кодов. Марка добавляется при проверке КМ через запрос POST /document. Проданная сразу добавляется со статусом "Продан".
Возвращенные марки меняют статус с "Продан" на "Доступен". При обработки такого входящего запроса:
1.1. Марки из тела запроса проверяются в ГИС МТ через метод /codes/check. Нужен скрипт. Т.к. есть предварительный запрос авторизации в ЧЗ, затем отправка запроса. Результатом выполнения является JSON с параметрами проверяемого КМ.
1.2. Делаются проверки по внутренней базе на доступность КМ к продаже (был ли ранее продан)
1.3. Ответ из ГИС МТ записывается в тэг truemark_response и вместе с ответом проверки возвращается "клиенту", выполнившему запрос.
1.4. На кассовом месте обрабатываются критерии из ответа от ЧЗ и, если есть критерии к запрету продажи, то на основании этих критериев выводится предупреждение кассиру (или запрет, нужна настройка как поступать - запрещать или предупреждать).
1.5. Если все хорошо и можно продавать (или продают несмотря на предупреждение), то берем reqId и reqTimestamp из ответа и передаем в реквизите 1260 в кассовом чеке.
1.6. Все запросы о КМ к ГИС МТ и ответы на них необходимо логировать, чтобы иметь доказательную базу для исключительных ситуаций. Вероятно такое логирование нужно сделать и в РМК (смотря откуда будет проще получать информацию о том когда и какой запрос выполнялся и что вернулось в ответ).

2. Внутренний процесс. Нужен скрипт. Запрос списка CDN с сайта Честного знака (по регламенту - раз в 6 часов)
2.1. Запрашивается список CDN. Полученный список записывается в базу в таблицу cdnlist. Адрес хоста возвращается в виде: "https://cdn01.am.crptech.ru". Возможные поля для таблицы: поле для адреса хоста, поле для отметки в качестве текущей, поле для отметки площадки неактивной.
2.2. По каждому CDN из списка проверяется его состояние через метод /cdn/health/check. 
2.3. Наиболее приоритетной является CDN-площадка, для которой время, затраченное на получение ответа кассовым узлом от системы (latency) минимально. Записываем CDN для работы в качестве текущей. Можно в той же таблице cdnlist добавить поле для отметки в качестве текущей. Все запросы по КМ выполняем к текущей CDN.

3. Аварийные ситуации
3.1. DOS-атака на CDN и она перестала отвечать на запросы. В таком случае запрос о КМ нужно направлять на следующую по списку CDN площадку. Если и та недоступна, то аналогично пройти все площадки. Если при обходе выяснилось, что ни одна из площадок недоступна (весь Честный знак упал и все CDN разом), то нужно выполнить заново пункты с 2.1. по 2.3. Вполне вероятно, что вместо старых CDN развернули уже новые.
3.2. Если вернувшийся список площадок оказался неактивным, то согласно ППРФ 1944 включаем режим без проверок. В этом режиме мы фоновое задание обновления списка площадок выполняем гораздо чаще, чтобы своевременно узнать о доступности новых CDN, а так же не посылаем запросы о КМ ко всем недоступным CDN, а только к любой одной без долгого ожидания ответа. Логируем запрос (чтобы доказать что мы запрос все же делали) и не заполняем тэг 1260 в чеке, т.к. не получаем ответов с нужными реквизитами.


4. Обработка входящих запосов из списка:
GET /token
GET /token
PUT /truemark
GET /codes/offline
POST<URL сервера>/create_stamp
POST<URL сервера>/unique_product_stamp
PUT<URL сервера>/unique_product_stamp
DELETE<URL сервера>/unique_product_stamp/<код идентификации>