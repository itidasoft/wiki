---
title: Активация
description: активация лицензии
published: true
date: 2022-04-02T20:57:42.668Z
tags: лицензия, активация
editor: markdown
dateCreated: 2022-04-02T20:57:40.029Z
---

Если лицензия не была активирована во время установки системы, то после запуска программы будет предложено активировать лицензию. В случае отказа, программа автоматически перейдет в демонстрационный режим.

![no-license.png](/images/quick-start/no-license.png)

Активация лицензии осуществляется нажатием одноименной кнопки **«Активировать лицензию»**. В этом случае, будет автоматически запущена программа **IActivate.exe** и предложено ввести ключ активации:

![iactivate.png](/images/quick-start/iactivate.png)

В этом окне необходимо указать 25 знаков ключа активации продукта Айтида, который находится в конверте с установочным диском ПП Айтида. В поле **«Укажите наименование покупателя продукта»** необходимо указать наименование организации, для которой производится активация. В следующем поле необходимо указать серийный номер продукта, указанный на упаковке. Для продолжения активации необходимо нажать кнопку **«Продолжить активацию»**. В случае, если ключ продукта был введен без ошибок, программа перейдет к следующему этапу активации:

![online-activation.png](/images/quick-start/online-activation.png)


Первичная активация лицензии возможна тремя способами:
1. **Автоматически**, используя прямое соединение по протоколу TCP/IP с сервером активации лицензий компании Атол. Адрес сервера активации лицензий: ils.itida.ru:99
При выборе этого способа программа отобразит поле с адресом и портом доступа к серверу активации. Эти данные нужно изменять только при прямом указании специалистов Айтида. Во всех остальных случаях необходимо просто нажать на кнопку **«Активировать»**. Программа произведет поиск и соединение с сервером по указанному адресу и выполнит активацию продукта Айтида.

2. **По электронной почте**, сгенерировав файл запроса на активацию и загрузив файл ответа на запрос активации лицензии. Адрес электронной почты: lic@itida.ru
Необходимо нажать на кнопку **«Сохранить файл с информацией об активации для отправки по электронной почте»** и сохранить сгенерированный файл. Отправить сохраненный файл по почте, в теме сообщения указать **«Запрос на активацию»**.
Ответное сообщение придет от сервера активации в течение нескольких минут. Сохранить файл ответа, который будет прикреплен к сообщению, в каталог на локальном диске компьютера. Нажать кнопку **«Загрузить файл с ответной информацией об активации»**, выбрать сохраненный файл. После этого необходимо нажать на кнопку **«Активировать»**. В случае успешной активации, программа сообщит об этом и предложит завершить работу.

3. **По телефону**, продиктовав указанный цифровой код представителю компании Айтида и введя ответный код. При выборе данного способа отобразится цифровой ключ продукта (90 цифр), который необходимо будет сообщить специалистам Айтида. При первичной активации будет сообщен ответный цифровой ключ, в противном случае следовать регламенту «Повторная активация».

> **Внимание!** Регламент **«Повторная активация»** можно скачать по [ссылке](https://itida.ru/download/docs/Regl_acliv_15012013.docx). Повторная активация требуется только при переносе активируемой лицензии на другой компьютер.
{.is-warning}

> **Примечание!** В случае наличия соединения с Интернетом самым быстрым и удобным является вариант **«Активировать через Интернет в режиме online»**.
{.is-info}

> **Внимание!** Запуск программы для активации лицензий необходимо делать только на компьютере (сервере), который будет использоваться в качестве сервера лицензий. Рекомендуем **совмещать месторасположение сервера лицензий и сервера с базой данных** на одном компьютере (сервере).
{.is-warning}

> **Внимание!** Все активированные лицензии будут привязаны к компьютеру (серверу), на котором их активировали! Смена привязки возможна только через повторную активацию лицензии по телефону.
{.is-warning}


