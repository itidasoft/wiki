---
title: Резервное копирование и восстановление
description: Руководство администратора
published: true
date: 2022-08-03T06:51:52.457Z
tags: резервная копия, резервное копирование, восстановление, ярлык, сохранение базы
editor: markdown
dateCreated: 2022-08-03T06:44:46.860Z
---

# Создание и восстановление резервных копий БД

Создание резервных копий является неотъемлемой частью работы администратора системы Айтида. Перед выполнением каких-либо настроек, изменений и обновлений в базе данных следует в обязательном порядке делать резервное копирование базы данных.

Кроме того, появляется необходимость в резервном копировании и для конечных пользователей. Для этого нужно применить ряд настроек администратору, чтобы функционал резервного копирования был доступен для пользователей в рабочей области ПП Айтида.

## Права доступа для пользователей на резервное копирование

Для начала нужно определить, кому из пользователей системы Айтида необходимо установить доступ к созданию резервной копии базы. Администратором устанавливается список пользователей, включенных в определенную группу согласно набору прав, фиксированных для этой группы.

Необходимо зайти в карточку пользователя и установить флаги **«Пользователю разрешено выполнять резервное копирование базы данных», «Пользователю доступна кнопка резервного копирования».**

В выпадающем списке кнопки **«Дополнительно»** следует вызвать настройку параметров пользователя.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/bd96f82c52aa9e6c9cc230c0978938d7.png)

Установить на вкладке Параметры флаг **«Резервное копирование». Затем сохранить все изменения**.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/2a0892e25afa364d599f868e33ba26c9.png)

> **Внимание!** *Кнопка резервного копирования появится на панели инструментов главного окна после входа в систему Айтида под именем этого пользователя.* 
{.is-warning}


**Меню Параметры – Справочник пользователей**

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/a20da04f87cd1e29c40553fdad5d3519.png)

**Login / domain name —** вводится имя пользователя в домене согласно принятой в фирме политике сетевой безопасности.

**Полное имя пользователя —** будет отображаться в других окнах.

**Кнопка «Группа пользователей» —** открывает для выбора «Справочник групп пользователей.

**Сотрудник —** при необходимости указать сотрудника из списка персонала.

**Панель инструментов —** подключить панель, из справочника панелей инструментов.

**Выпадающий список «Тип доступа» —** позволяет присваивать следующие права: «Администратор», «Пользователь без ограничений», «Пользователь с ограничением срока» и «Вход заблокирован».

**Дата окончания доступа —** при выборе варианта «Пользователь с ограничением срока» необходимо будет вручную или с помощью Календаря.

**Рабочее время «с ... по ...» —** назначаются часы работы пользователя.

**Рабочий график —** открывает «Справочник календарей».

**Флаг «Пользователю разрешено выполнять резервное копирование базы данных» —** позволяет настроить права доступа пользователя к резервному копированию базы.

**Флаг «Пользователю доступна кнопка резервного копирования»** **—** позволяет активировать кнопку на панели инструментов программы для резервного копирования базы.

**Кнопка «Дополнительно»** **—** предоставляет выбор дополнительных действий: «Параметры пользователя», «Изменить пароль пользователя», «Создать LOGIN пользователя на сервере» и «Удалить LOGIN пользователя на сервере». Для определения пароля для входа в систему для пользователя используется пункт из выпадающего списка «Изменить пароль пользователя» или «Создать LOGIN пользователя на сервере».

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/c24db967c4938e82c078474d1fd4d7ee.png)

**Кнопка «Записать» —** сохранить введенные данные.

> **Примечание!** *Настройки* *прав пользователей, изменение паролей может производить только Администратор.*
{.is-info}


> **Примечание!** *Подробнее о настройках учета рабочего времени, должностей, сотрудников и т. д. описано в разделе* **Персонал** *в документации* **Руководство пользователя**.
{.is-info}


## Создание резервной копии пользователем ПП Айтида

Необходимо запустить программу Айтида от имени пользователя, которому доступно создание резервной копии базы. На панели инструментов программы Айтида будет активна кнопка «**Резервное копирование базы данных»**.

![](/images/admin-guide/backup/ebdc9590109e5bc638668bd5deb57078.png)

![](/images/admin-guide/backup/2f003ee49f116e8a1ec88d50e72ab678.png)

В зависимости от настройки параметров резервного копирования в результате, в каталоге, который задан в настройках параметров системы будет сформирована резервная копия базы.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/ef12f9d4905ed5ef3b13714ec7088a2e.png)

> **Примечание!** *Подробнее о настройках параметров системы можно узнать из раздела* [*Параметры системы*](/docs/admin-guide/settings#_Параметры_системы)*.*
{.is-info}


## Создание резервной копии средствами SQL

Создание резервной копии посредством среду SQL может провести и пользователь с правами, разрешающими производить резервное копирование базы данных, и если имеется возможность запустить среду SQL и подключиться к серверу.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/e171f8cec2473075ffa30287ac171a27.png)

В главном окне среды SQL необходимо выбрать из коневого каталога **«Базы данных»** базу, для которой нужно создать резервную копию и щелкнуть правую кнопку мыши.

Выбрать из списка **«Задачи»** и из выпадающего списка выбрать **«Создать резервную копию»**.

![](/images/admin-guide/backup/f724348094cde714e21e9d6cf1c48b66.png)

# Восстановление резервных копий

Восстановление резервных копий рекомендуется делать при помощи служебной программы **IRestoreDB.exe**. Ее можно найти в рабочем каталоге Айтиды. Помимо собственно восстановления резервной копии, эта программа выполняет дополнительные действия необходимые для нормальной работы базы данных на сервере. В состав дополнительных действий входит выдача прав доступа на работы с базой пользователям idleuser и idleadmin, а также запись в справочник филиалов имени, под которым была восстановлена база данных на сервере.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/967586ad8b1b631369f91cbe3350b393.png)

## Подключение к SQL-серверу

Перед восстановление резервной копии необходимо установить соединение с сервером базы данных. В поле **«Имя сервера»** указывается имя SQL сервера. Если сервер установлен на этом же компьютере, то его имя можно выбрать из меню кнопки справа от поля ввода. Поиск сетевых серверов можно осуществить, нажав на кнопку справа от поля ввода.

При необходимости, в поле **«Порт доступа»** можно указать номер порта доступа к SQL серверу. Необходимость может возникнуть в случаях, когда система не может самостоятельно определить номер порта, или на сервере запущенно несколько экземпляров, на разных портах.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/f497b5a8faef720f8d9e0d61bfc82b9f.png)

В поле **«Пользователь»** указывается имя одного из пользователей SQL сервера, с присвоенной ролью администратора SQL сервера. В поле **«Пароль»** указывается пароль этого пользователя. В поле **«Драйвер»** можно выбрать драйвер доступа к данным. Рекомендуется использовать драйвер, выбранный по умолчанию.

Нажать на кнопку **«Подключиться к серверу»**, для установки соединения.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/a640ce7419d67f845e014b162f3c2090.png)

> ***Внимание!** Установка признака **«Использовать значения по умолчанию»** заполнит поле **«Пользователь»** значением **sa**, а поле **«Пароль»** значением **itida***
{.is-success}


## Подключение базы данных

Необходимо ввести или выбрать каталог, в котором будут расположены файлы базы данных. По умолчанию – это **C:\\ItiData**.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/cdb4e769d6c0eb7f55ce0fa540299a40.png)

Поле **«Имя базы данных»** необходимо ввести имя для новой базы. Имя должно состоять из латинских букв и цифр, так же должно начинаться с буквы.

Признак **«Установить как базу копию»** используется для подключения баз из филиалов. В это случае, программа удалит из базы данных все триггеры, чтобы они не мешали приему данных из филиала.

Необходимо выбрать, какую базу хотите восстановить. Если выбран вариант “**из пустой базы данных**” или “**из демонстрационной базы данных**”, то необходимо, чтобы в подкаталоге BASE рабочего каталога Айтиды находились файлы баз данных из дистрибутива – **ItidaRetail.cab** или **ItidaRetailDemo.cab**. Если выбран вариант **“из резервной копии базы данных”**, то необходимо выбрать файл с резервной копией. Нажатием кнопки **«Подключить базу данных»** завершается процесс подключения базы данных к серверу.

> **Примечание!** Если в каталоге, указанном для подключаемой базы уже есть файлы этой базы данных, например для базы данных **ItidaRetail** файл будет называться **ItidaRetail_data.mdf**, то он не будет переписан новым файлом с подключаемой базой, а будет подключен для работы с устанавливаемой системой.<br> ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/546401601d17ab97f610ea91b8dba29a.png)

## Создание ярлыков

В поле **«База данных»** необходимо выбрать к какой базе должен подключаться создаваемый ярлык. Необходимо ввести имя ярлыка. Имя должно быть уникальным. Можно нажать **кнопку справа** от поля ввода для генерации имени ярлыка на основе имени выбранной базы данных.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/8e5ff24015065c8703fa18b16b312325.png)

Нажатием кнопки **«Создать ярлык Айтида»** завершается процесс создания ярлыка базы данных.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/b6df04d09d4be619dda812332bfef111.png)

> **Внимание!** *Созданный ярлык будет содержать в командной строке все указанные параметры подключения к SQL-серверу, в том числе: имя SQL-сервера, номер порта подключения, пароль* **itida***, выбранный драйвер для доступа к данным. Кроме имени пользователя.*
{.is-warning}

В системе Айтида имеются штатные возможности производить резервное копирование, однако бывают случаи, когда в результате неполадок резервная копия базы данных отсутствует и файлы базы данных сохранились только в папке **ItiData**. Предусмотрен SQL-запрос на подключение базы данных из файлов с расширением **\*.mdf** и **\*.ldf**.

1.  В целях безопасности необходимо сохранить имеющиеся файлы в отдельном каталоге.
2.  После установки нового **Microsoft SQL Server** необходимо запустить среду **SQL Server Management Studio** и осуществить подключение к серверу под логином **sa**.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/7f3393740935653f7becff925e77a586.png)

3.  На панели инструментов нажать кнопку **«Создать запрос»** и в окне запроса ввести текст запроса:

```SQL
EXEC sp_attach_single_file_db 'ItidaRetail', 'C:\ItiData\ItidaRetail_data.mdf'
```

![Изображение выглядит как текст, снимок экрана, внутренний Автоматически созданное описание](/images/admin-guide/backup/bc7fac14eea05b6bb642551f0563dbd9.png)

**'ItidaRetail'** — первым параметром процедуры указывается имя создаваемой базы данных. Если база называлась иначе, следует указать ее старое имя.

**'C:\\ItiData\\ItidaRetail_data.mdf'** — вторым параметром указывается имя файла с данными базы данных. Важно, чтобы этот файл находился на прежнем месте. Так же важно не перемещать и не удалять файл журнала (\*.ldf).

4.  После выполнения запроса, база данных будет подключена. Обязательно создать на SQL сервере имена входа **idleadmin** и **idleuser**.

![](/images/admin-guide/backup/64b68ed14dfb23baf235b3961e0a84be.png)

5.  Далее необходимо выполнить запрос, который даст права этим пользователям на работу с базой. Имя базы данных **ItidaRetail** следует заменить на имя подключенной базы:

```SQL
USE ItidaRetail 
UPDATE sprbranch SET dbase= DB_NAME( ) 
WHERE code IN ( SELECT value FROM param WHERE param= 'branchcode' ) 
GO 
EXECUTE sp_revokedbaccess 'idleuser' 
GO 
EXECUTE sp_revokedbaccess 'idleadmin' 
GO
EXECUTE sp_grantdbaccess 'idleuser' 
GO 
EXECUTE sp_grantdbaccess 'idleadmin' 
GO 
SELECT * FROM param WHERE param= 'databaseversion' 
```

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/backup/bf9797416444d3b0c40b0585ea48da71.png)

6.  Проверить успешность подключения базы данных можно запуском Айтида.