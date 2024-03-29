---
title: Справочник пользователей
description: Руководство администратора
published: true
date: 2022-08-08T22:24:34.227Z
tags: пользователи, доступ
editor: markdown
dateCreated: 2022-08-08T22:24:31.857Z
---

> *Подробнее о настройках чета рабочего времени, должностей, сотрудников и т.д. описано в разделе* **«Персонал»** *в документации* **«Руководство пользователя»**.
{.is-info}


Администратором устанавливается список пользователей, включенных в определенную группу согласно набору прав, фиксированных для этой группы.

**Меню Параметры – Справочник пользователей**

**![2013-04-05_131548.png](/images/admin-guide/directories/users/ec8906427e7b531ffe6ba966b3ed3bb7.png)**

**Login / domain name —** вводится имя пользователя на SQL сервере.

> **Внимание!** *Система Айтида поддерживает как авторизацию* **SQL Server***, так и авторизацию* **Windows***. Для указания логина в формате* **Windows** *необходимо указывать имя домена перед именем:* **domain\\username***. Значение в этом поле не должно превышать* **127** *символов.*
{.is-warning}


**Полное имя пользователя** — имя пользователя для отображения в запросе авторизации и отчетах. Не должно превышать 250 символов.

**Группа пользователей** — содержит ссылку на группу, к которой принадлежит пользователь. Установка этого поля определяет меню, основные права доступа и интерфейсы, с которыми будет работать пользователь.

**Сотрудник** — указание этого поля позволит связать справочник пользователей с сотрудниками, что позволит, например, заполнять автоматически некоторые поля документов, или может быть использовано при печати отчетов.

**Панель инструментов** — позволяет определить специфическую панель инструментов для конкретного пользователя.

**Тип доступа** — возможные значения: «Администратор» (значение 00), «Пользователь без ограничений» (01), «Пользователь с ограничением срока» (02), «Вход закрыт» (04).

**Дата окончания доступа** — если выбран тип доступа «Пользователь с ограничением срока», то это дата, после которой вход в систему будет закрыт.

**Рабочее время «с … по …»** — позволяет указать время суток, в которое пользователю разрешен вход в систему. Данный параметр проверяется, если разница между параметрами больше «1».

**Рабочий график** — позволяет выбрать календарь, в котором указаны выходные и праздничные дни. В выходные и праздничные дни вход в систему будет закрыт.

**Пользователю разрешено выполнять резервное копирование базы данных** — при установке данного признака, система попытается присвоить пользователю роль backupoperator на SQL сервере. Пользователь, выполняющий корректировку карточки, должен иметь административные права на SQL сервере.

**Пользователю доступна кнопка резервного копирования** — при установке этого признака в основной панели инструментов пользователя будет доступна кнопка резервного копирования. При этом должен быть установлен признак «Пользователю разрешено выполнять резервное копирование базы данных.»

**Параметры пользователя** — выбор данного пункта меню позволяет настроить параметры редактируемого пользователя (см. раздел [Параметры пользователя](/docs/admin-guide/settings#_Параметры_пользователя)).

**«Изменить пароль», «Создать пользователя», «Удалить пользователя»** —позволяют изменить пароль пользователя на сервере, добавить или удалить логин пользователя с сервера.

> **Внимание!** *Пользователь, выполняющий корректировку карточки, должен иметь административные права на SQL сервере.*
{.is-warning}


> **Примечание!** *В стандартной поставке система содержит предопределенного пользователя **«Администратор»** (**idleadmin**) с паролем **itida** или, начиная с 2017 года, **Itida2017**.*
{.is-info}


![2013-04-05_132400.png](/images/admin-guide/directories/users/2ead1c8f05a12461480161fbe6ddd4bd.png)
