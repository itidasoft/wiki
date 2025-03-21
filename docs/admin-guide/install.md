---
title: Установка программного обеспечения Айтида и установка SQL сервер
description: Установка Айтида и SQL
published: true
date: 2024-11-21T10:08:08.839Z
tags: установка, sql, внедрение
editor: markdown
dateCreated: 2022-07-31T21:20:35.167Z
---

# Введение

## Сокращения
| | |
|-----|--------------------------------------------------------------------|
| РС  | Рабочая Станция                                                    |
| ПК  | Персональный Компьютер                                             |
| ЛКМ | Левая Кнопка Мыши                                                  |
| ПКМ | Правая Кнопка Мыши                                                 |
| ПО  | Программное Обеспечение                                            |
| ОС  | Операционная Система                                               |
| ТМЦ | Товарно-Материальная Ценность                                      |
| ФР  | Фискальный Регистратор                                             |
| ПД  | Принтер Документов                                                 |
| ККМ | Контрольно-Кассовая Машина. Для Frontol это фискальный регистратор |
| КС  | Кассовая Смена                                                     |
| КПП | Код Причины Постановки на учет                                     |
| ИНН | Идентификационный Номер Налогоплательщика                          |
| ТСД | Терминал Сбора Данных                                              |
| БД  | База Данных                                                        |
| ШК  | Штрих-код                                                          |
| ТО  | Торговое Оборудование                                              |
| ДТО | Драйвер Торгового Оборудования                                     |
| РМ  | Рабочее Место                                                      |
| МОД | Модуль Обмена Данными                                              |

## Условные обозначения

> Информация, выделенная таким знаком, является важной и требует обязательного прочтения и/или выполнения.
{.is-warning}

> Информация, выделенная таким знаком, носит ознакомительный и/или рекомендательный характер.
{.is-info}

> Информация, выделенная таким знаком, является примером использования настройки или механизма работы.
{.is-success}

> Информация, выделенная таким знаком, предназначена исключительно для администратора, производящего установку и настройку.


## Назначение

Программные продукты серии Айтида предназначены для автоматизации розничной торговли и общественного питания. Позволяют оперативно вести товарный, складской и кассовый учёт для предприятия розничной торговли и общественного питания с несколькими кассовыми узлами.

![](/images/admin-guide/install/1e200a828c8b074daddbd9881c473d30.png)

Руководство Администратора предназначено для изучения функциональных возможностей программного продукта техническими специалистами, которые будут в дальнейшем осуществлять техническое консультирование, настройку, обучение сотрудников торгового предприятия и сопровождение программного продукта.

Руководство рассчитано на специалистов, которые впервые знакомятся с программным продуктом Айтида и построено на наиболее часто встречающихся примерах по настройке систем автоматизации на базе ПО Айтида.

## Средства разработки

Программные продукты Айтида являются клиент-серверными приложениями. Серверная часть системы разработана на MS TSQL – наиболее известном и распространенном языке программирования, предназначенном для решения именно этих задач. TSQL позволяет пользователю осуществлять быстрые выборки информации из базы данных по заданным фильтрам, группировать данные, сортировать их.

После того, как по запросу пользователя необходимая информация извлечена из базы данных (с помощью TSQL), как правило, требуется произвести какие-либо расчеты. За расчеты в наших программных продуктах отвечает центральный вычислитель системы.

Центральный вычислитель разработан на языке С++. Этот язык программирования является одним из «самых быстрых» и применяется обычно в программах, предназначенных для произведения большого количества сложных математических расчетов. Центральный вычислитель используется и генератором отчетов, для достижения высокой скорости их формирования.

![Вариант-3.png](/images/admin-guide/install/ea7886211d41cc48208c5c767e15b45e.png)

После того, как нужная информация выбрана из базы данных и обработана вычислителем, ее можно представить пользователю.

## Клиент-серверная архитектура

**Клиент-сервер** (англ. Client-Server) — сетевая архитектура, в которой устройства являются либо клиентами, либо серверами. Клиентом является запрашивающая машина (обычно ПК пользователя), сервером - машина, которая отвечает на запрос.

Действительно, программный продукт, разработанный с применением технологии клиент-сервер — это фактически две программы. Одна из них работает на компьютере пользователя (отображает информацию, позволяет сформировать условия выборки данных и передать их на сервер), другая работает на сервере, принимает запросы клиентских станций, осуществляет выборку запрошенных данных, и возвращает их пользователю.

Такая технология работы программы значительно сложнее обычной, но обеспечивает максимальную производительность. При работе более простых систем именно пользовательская станция осуществляет выборку нужных данных. Поэтому при любом запросе (например, при формировании отчета или, при открытии журнала документов) по сети передается большое количество лишней информации - замедляя работу всех пользователей, излишне нагружая сеть.

К основным достоинствам технологии клиент-сервер относятся:
- Более высокая производительность
- Низкие требования к рабочим станциям
- Низкие требования к пропускной способности сети

И, кроме того:
- Надежность хранения данных
- Защита от несанкционированного доступа

Для работы клиент-серверного приложения не обязательно наличие выделенного сервера. И клиентскую и серверную часть программы можно установить на компьютер пользователя. При этом все достоинства технологии сохраняются, а минимальные требования к рабочей станции достаточно лояльны.

Следует отметить, что для работы программных продуктов Айтида приобретение платной лицензии MS SQL сервер не обязательно. Для большинства компаний на долгое время будет достаточно бесплатной версии MS SQL Express, которая поставляется в составе нашего дистрибутива.

## База данных MS SQL

Microsoft SQL Server (SQL Server Express) – это мощная и надежная программа по управлению данными, обеспечивающая множество функций, защиту данных и высокую производительность для встроенных приложений-клиентов, «легких» Web-приложений и локальных хранилищ данных. SQL Server Express предназначен для упрощенного развертывания и быстрого создания прототипов; его можно получить бесплатно и свободно распространять в составе приложений. SQL Server Express естественным образом интегрируется с другими продуктами, входящими в серверную инфраструктуру.

Основным достоинством наличия единой базы данных является то, что она сама, через внутренние связи, триггеры и хранимые процедуры, сохраняет и поддерживает целостность хранимых данных. Таким образом, не зависимо от того какое клиентское приложение используется для внешнего управления данными, все внутренние взаимосвязанные объекты базы (исходные данные документов и справочников и производные от них регистры и расчеты) будут находиться в актуальном состоянии.

### Основные объекты системы Айтида

Все объекты системы Айтида делятся на следующие группы:

1.  Документы и справочники. Объекты, содержащие исходные данные, вводимые пользователем – документы и справочники. Эти объекты имеют пользовательские интерфейсы для ввода, корректировки и удаления введенных данных.
2.  Регистры. Объекты, информация в которые поступает автоматически в результате производимых расчетов над документами и справочниками – регистры учета. Информация в регистрах не доступна для непосредственного изменения пользователями системы и автоматически поддерживается в актуальном состоянии средствами базы данных.
3.  Вспомогательные таблицы. Объекты, содержащие информацию о настройках системы и прочую служебную информацию.

# Подготовка к установке

Серверная часть системы Айтида рассчитана на работу совместно с Microsoft SQL Server различных версий, начиная с версии 2005. Microsoft SQL Server так же может быть установлен на компьютеры, работающие под управлением операционных систем семейства Microsoft Window.

Для клиентской части системы Айтида требования к аппаратной части достаточно скромные. Достаточно компьютера средней офисной конфигурации.

## Системные требования

Система Айтида на стороне клиентской части может быть установлена на компьютеры, работающие под управлением операционных систем семейства Microsoft Window, начиная с версии Windows XP с установленным Service Pack 3.

> **Внимание! Программные продукты Айтида версии 4, Айтида РМК, Айтида iMark не поддерживают работу с Windows XP (подробный перечень совместимых версий смотри в таблице ниже).**
{.is-warning}


- Компьютер Intel Pentium III или оборудованный совместимым процессором с тактовой частотой 600 МГц или выше (рекомендуется 1 ГГц или выше).
- Минимум 1ГБ ОЗУ (рекомендуется 2 ГБ или выше).
- 1 ГБ дискового пространства (рекомендуется 2ГБ)

### Минимальные системные требования для Windows 7 и Windows 10

- Процессор: 1 гигагерц (ГГц) или выше с поддержкой PAE, NX и SSE2;
- ОЗУ: 1 гигабайт (ГБ) для 32-разрядной версии или 2 ГБ для 64-разрядной версии;
- Свободное место на жестком диске: 16 гигабайт (ГБ) для 32-разрядной версии или 20 ГБ для 64-разрядной версии;

Как уже упоминалось, в качестве серверной части могут быть использованы различные версии MS SQL Server, поэтому, перед началом установки системы необходимо определить наиболее оптимальную версию для использования. Для этого можно воспользоваться следующей таблицей.

| Версия операционной системы на компьютере сервере                          | Предпочтительная версия MS SQL Server |
|----------------------------------------------------------------------------|---------------------------------------|
| Windows XP SP3, Window Server 2003 SP2, Windows Vista, Windows Server 2008 **(Не совместимо с Айтида 4 )** | Microsoft SQL Server 2005. **(Не совместимо с Айтида 4 )**     |
| Windows Server 2008 R2 без SP1, Windows 7 без SP1                          | Microsoft SQL Server 2008R2.          |
| Windows Server 2008 R2 SP1, Windows 7 SP1, Windows 8, Windows 8.1          | Microsoft SQL Server 2012.            |
| Windows 10, 11                                                             | Microsoft SQL Server 2014, 2016, 2017, 2019 |
| Windows 11                                                                 | Microsoft SQL Server 2014, 2016, 2017, 2019, 2022 |

Так же необходимо определить какой вариант операционной системы установлен на компьютере сервере – 32-х битный или 64-х битный. От этого зависит, какой вариант SQL сервера необходимо использовать. После определения версии MS SQL Server Express Edition дистрибутив программы можно скачать с сайта компании Microsoft по следующим ссылкам:

| Версия MS SQL Server Express Edition                                               | Интернет адрес для загрузки |
|------------------------------------------------------------------------------------|-----------------------------|
| Microsoft SQL Server 2005. Этот вариант не делится на 32-х и 64-х битные варианты. **(Не совместимо с Айтида 4 )** |  [SQLEXPR_ADV_RUS.EXE](http://download.microsoft.com/download/0/b/2/0b266d5b-9724-4e4d-8db2-e3f2e3418403/SQLEXPR_ADV_RUS.EXE)                            |
| Microsoft SQL Server 2008R2x86 (32-бита)                                           | [SQLEXPRWT_x86_RUS.exe](http://download.microsoft.com/download/3/A/9/3A92B0B1-D996-464E-A0C9-60C9BFA2D071/SQLEXPRWT_x86_RUS.exe)                         |
| Microsoft SQL Server 2008R2x64(64-бита)                                            | [SQLEXPRWT_x64_RUS.exe](http://download.microsoft.com/download/3/A/9/3A92B0B1-D996-464E-A0C9-60C9BFA2D071/SQLEXPRWT_x64_RUS.exe)                         |
| Microsoft SQL Server 2012x86 (32-бита)                                             | [SQLEXPRWT_x86_RUS.exe](http://download.microsoft.com/download/C/9/C/C9CC7335-F901-4463-AD0E-07B12ED9E976/SQLEXPRWT_x86_RUS.exe)                         |
| Microsoft SQL Server 2012x64 (64-бита)                                             | [SQLEXPRWT_x64_RUS.exe](http://download.microsoft.com/download/C/9/C/C9CC7335-F901-4463-AD0E-07B12ED9E976/SQLEXPRWT_x64_RUS.exe)                         |
| Microsoft SQL Server 2014x86 (32-бита)                                             | [SQLEXPRWT_x86_RUS.exe](http://download.microsoft.com/download/4/E/3/4E38FD5A-8859-446F-8C58-9FC70FE82BB1/ExpressAndTools%2032BIT/SQLEXPRWT_x86_RUS.exe) |
| Microsoft SQL Server 2014x64 (64-бита)                                             | [SQLEXPRWT_x64_RUS.exe](http://download.microsoft.com/download/4/E/3/4E38FD5A-8859-446F-8C58-9FC70FE82BB1/ExpressAndTools%2064BIT/SQLEXPRWT_x64_RUS.exe) |
| Microsoft SQL Server 2016x64 (64-бита)                                             | [SQLServer2016-SSEI-Expr.exe](https://download.microsoft.com/download/3/7/6/3767D272-76A1-4F31-8849-260BD37924E4/SQLServer2016-SSEI-Expr.exe) |
| Microsoft SQL Server 2017x64 (64-бита)                                             | [SQLServer2017-SSEI-Expr.exe](https://download.microsoft.com/download/5/E/9/5E9B18CC-8FD5-467E-B5BF-BADE39C51F73/SQLServer2017-SSEI-Expr.exe) |
| Microsoft SQL Server 2019x64 (64-бита)                                             | [SQL2019-SSEI-Expr.exe](https://download.microsoft.com/download/7/f/8/7f8a9c43-8c8a-4f7c-9f92-83c18d96b681/SQL2019-SSEI-Expr.exe) |
| Microsoft SQL Server 2022x64 (64-бита)                                             | [SQL2022-SSEI-Expr.exe](https://download.microsoft.com/download/5/1/4/5145fe04-4d30-4b85-b0d1-39533663a2f1/SQL2022-SSEI-Expr.exe) |

Перед установкой ПП Айтида загруженный файл MS SQL Server Express Edition, версии соответствующей операционной системе, необходимо поместить в папку Itida дистрибутива ПП Айтида.

> При установке однопользовательского варианта ПП Айтида из состава продукта XPos PLUS на рабочее место под управлением Windows XP ставится MS SQL Server 2006 Express. Для остальных версий Windows ставится SQLLocalDB 2012. В этом случае, нет необходимости в дополнительной загрузке файлов, т.к. все необходимое для установки есть в самом дистрибутиве ПП Айтида.
{.is-warning}

> При возникновении ошибок во время установки **Microsoft SQL Server** из дистрибутива **Itida**, рекомендуется установить **Microsoft SQL Server** вручную. Для установки **Microsoft SQL Server** вручную необходимо следовать рекомендациям, указанным в разделе [Приложение: ручная установка Microsoft SQL Server](#ручная-установка-microsoft-sql-server-express-edition-2005).
{.is-warning}


# Установка ПП Айтида

Установку Айтида может произвести только администратор или пользователь с правами администратора, так как во время установки ПО будет производиться запись в системные каталоги Windows и в реестр Windows.

> В системе Айтида до 2017 года по умолчанию использовался пароль – **itida**, а с 2017 года - **Itida2017**
{.is-warning}

Дистрибутив системы Айтида хранится на сайте [www.itida.ru](https://itida.ru/products/downloads) и доступен для скачивания в разделе «Продукты - Скачать». Перед установкой скачанный архив необходимо распаковать в любую папку на любом носителе. Если установка будет производиться на компьютере сервере и предполагается установка самого SQL сервера, то Microsoft SQL Server Express Edition можно установить либо средствами ПП Айтида или самостоятельно. Для установки SQL сервера средствами ПП Айтида, необходимо в подкаталог «Itida» поместить выбранный вариант установочного файла Microsoft SQL Server Express Edition. Для самостоятельной установки Microsoft SQL Server Express Edition рекомендуется действовать согласно инструкциям из раздела [Приложение: ручная установка Microsoft SQL Server](#ручная-установка-microsoft-sql-server-express-edition-2005).

Для установки программы средствами ПП Айтида необходимо запустить программу **ISetup.exe**, которая находится в корневом каталоге дистрибутива системы. В окне программы установки выбрать сценарий установки «Полная установка» или «Установка по выбору».

| | |
|---|---|
|  ![](/images/admin-guide/install/2475ea48e278178de8edb86a7d796278.png)                                                                                                                  | Перед началом установки ПП Айтида необходимо закрыть все работающие приложения. Далее нажать кнопку для выбора сценария установки. |
| При выборе Полной установки необходимо указать, какие базы данных установить и нажать кнопку Выполнить полную установку. | ![](/images/admin-guide/install/2a2e2964c5fd0f96d3bf628dc38793cd.png) |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/f00a7004da445fd6b5658ddaaff2bfb4.png) | Если в процессе установки появилось сообщение о недоступности файлов, то это означает, что необходимый установочный файл MS SQL Server Express Edition не был помещен в папку Itida дистрибутива.  |
| Если на компьютере, уже установлен и запущен MS SQL Server с именем экземпляра SQLEXPRESS, то программа запросит пароль sa, для подключения баз данных Айтида. | ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/37d55f9bec5448f797aea4677221aea0.png) |
|  ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/0c124afba05d424afb5a05b18f3ae8e1.png) | В противном случае, будет запущен установочный файл MS SQL Server Express Edition. |
|  Перед закрытием диалогового окна установки дождитесь окончания установки и нажмите кнопку «Вернуться на предыдущую страницу» и затем нажмите кнопку «Закрыть».   |  ![](/images/admin-guide/install/c9a5ec9ecb2671042f9a72360fe7f17c.png) |

> При выборе полной установки, системой не всегда выдаются ошибки, которые встречаются во время установки, поэтому, если полная установка завершилась неудачно, необходимо выполнить выборочную установку. При этом, все действия системы будут согласовываться с пользователем и будут выводиться все сообщения об ошибках.
{.is-warning}


## Удаление ПП Айтида

Для удаления установленных программ необходимо воспользоваться Панелью Управления (Пуск – Панель Управления – Установка и удаление программ).

| | |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/914ba09903bf3135599843f7ec29d821.png)                                                                             | Необходимо выбрать тип удаления и нажать кнопку «Далее»                                                                                                                                           |

| Подтвердить операцию удаления кнопкой «Да».                                                                                                                                                | ![](/images/admin-guide/install/ef631cc3e65079d6cdde7f798547a883.png)                                                                                                                                                   |
> **Внимание!** Если производится деинсталляция ПП Айтида из-за возникших ошибок при первичной установке, то для повторной попытки установки ПП Айтида необходимо выполнить нижеописанные действия.
{.is-info}

| | |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| С помощью среды SQL Server Management Studio удалить базы данных ItidaRetail и ItidaRetailDemo, так как при следующей установке ПП Айтида, будут создаваться базы данных с этими именами.  |  ![2013-06-10_090220.png](/images/admin-guide/install/99e340e90db90e7b4eae48cdd85a0d2a.png)                                                                                                                             |
| ![2013-06-10_084806.png](/images/admin-guide/install/978ab2074e16324bc358b996d86acec2.png)                                                                                                                       |  Необходимо удалить папку ItidaData на диске C:\\, которая содержит файлы баз данных.                                                                                                             |
| Так же удалить папку, прописанную в реестре. После этих действий можно произвести повторную попытку установки ПП Айтида.                                                                   | ![2013-06-10_085022.png](/images/admin-guide/install/346dac0785543959b8ed261cd6d9817f.png)                                                                                                                              |

## Обновление ПП Айтида {#_Обновление_ПП_Айтида}

На интернет-странице Программного обеспечения Айтида по адресу [https://itida.ru/products/downloads](https://itida.ru/products/downloads) доступны обновления Айтида, которые позволяют при необходимости обновить предыдущие версии программы и базы данных Айтида до последних версий. Если в процессе эксплуатации последнего официального релиза Айтида выявляются ошибки, то осуществляется их исправление, после чего происходит сборка нового обновления, которое выкладывается на интернет-страницу. Перед началом обновления необходимо скачать файл с обновлением с указанного сайта.

> **Внимание!** Обновлять программу с версии 2.0 до текущей, следует в следующей последовательности: 2.0 - 2.4. - текущая версия.
{.is-info}


1.  Запустить **IUpdate.exe**, в появившемся окне и в поле Имя файла обновления выбрать загруженный файл **update_DB_ХХХ-EXEDLL_ХХХ.cab**. При этом будет автоматически сформирован список модулей, обновления для которых содержатся в выбранном файле.
2.  Выбрать SQL Server, ввести пароль, подключиться к серверу.
3.  После подключения к серверу в списке баз данных, необходимо выбрать обновляемую базу данных, например, ItidaRetail.
4.  Далее нажать кнопку «Обновить».

| | |
| --- | --- |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/c6de511c6dd735fabfd7fc5e9e848739.png)                                                                                                                                                                       | В поле «Имя сервера» необходимо указать имя ПК, на котором установлен SQL-сервер и имя самого сервера. Пример: **SERVER\\sqlexpress** или  **(local)\\SQLEXPRESS** – если SQL-сервер установлен локально. |
| В поле «Пользователь» и «Пароль» указать логин и пароль пользователя для SQL-сервера или использовать «Пароль по умолчанию». Нажать кнопку «Подключиться к серверу». Указанный пользователь должен обладать правами администратора на SQL сервере, или быть владельцем базы данных.  | ![](/images/admin-guide/install/9f296b5205c3a3d6bfd6e14bd6e1dd9c.png)                                                                                                                                                                                                                                                 |
| ![2013-04-22_140534.png](/images/admin-guide/install/53c2600dd70ea8bb7e26533cd434238a.png)                                                                                                                                                                                                                 | В области «Базы данных» отобразится список баз данных системы Айтида, которые установлены на выбранном сервере. Справа от имени базы данных, в скобках отображается версия БД Айтида. Отметьте флагом базы данных, которые требуется обновить. Флаг должен быть установлен в правой части окна. |

|                                                                                                                                                                                                                                                                                                                   
> Если на одном SQL-сервере установлены центральная база и копии филиалов, то в приложении IUpdate.exe необходимо выбирать только базу центра. Базы-копии филиалов обновятся автоматически.
{.is-info}

> При установленном флаге «Создавать резервную копию» будет создана резервная копия базы в настроенном каталоге системы, а так же копии обновляемых программ до их обновления. Это позволит в случае возникновения проблем вернуть к ранее используемой версии системы.
{.is-warning}

| | |
| --- | --- | 
|      ![2013-04-22_140724.png](/images/admin-guide/install/39f803de58b18a1dc7f8953779c23a05.png)                                                                                                                                                                                                                                                                             |       В поле Имя файла, содержащего обновление системы выберите файл с обновлением системы Айтида.                                                                                                                                                                                                                                                                   |
| После выбора файла с обновлением системы, в области «Обновить следующие объекты» по умолчанию будут установлены все флаги. При необходимости, часть флагов можно снять. Например, при обновлении клиентской части системы (на ПК установлена только программа, а SQL-сервер находится на другом ПК) необходимо установить только «Исполняемые файлы». | ![2013-04-22_140835.png](/images/admin-guide/install/9cccd5358940e414c47aa58984715a83.png)                                                                                                                                                                                                                                                                                                 |
| ![](/images/admin-guide/install/f65ac8264bd9e028f47f02c0a87cbe04.png)                                                                                                                                                                                                                                                                                                       | Нажать на кнопку «Обновить». Начнется процесс установки обновлений.                                                                                                                                                                                                                                                                                                  |
| После проведения операции появится сообщение об успешном обновлении. Нажать кнопку «ОК».                                                                                                                                                                                                                                                              | ![2013-04-22_142136.png](/images/admin-guide/install/3c93d28678906c18382bda24c7dcfb78.png)                                                                                                                                                                                                                                                                                                 |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/9e34658f05f065064229e52b7e9160ef.png)                                                                                                                                                                                                                                        | Если в процессе обновления у каких либо строк появился символ желтого квадрата, то это означает, что обновляемый файл был занят во время обновления. В этом случаем по окончании процесса обновления будет предложено перезапустить операционную систему для завершения копирования занятых файлов.                                                                  |

> После обновления рекомендуется обновить стандартные отчетные и печатные формы, а так же профили для работы с оборудованием. В случае наличия измененных/дописанных отчетных форм необходимо проверить их работу на новой базе. Все необходимые данные можно скачать с сайта [www.itida.ru](https://itida.ru/products/downloads) в разделе «Продукты - Скачать».
{.is-warning}


# Ручная установка Microsoft SQL Server

> Для продукта Айтида требуется иметь **Смешанный режим авторизации**, а также использовать имя экземпляра сервера. Следует учесть эти моменты при установке. 
![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/c0a232e816936906924caaf5300a5cb8.png)
{.is-warning}


## Ручная установка SQL Server 2008, 2008R2, 2012 и 2014 Express

> **Внимание! Работа Айтиды версии 4 совместно с MS SQL сервером версий 2005 и 2008 не поддерживается. Необходимо использовать MS SQL сервер версий 2008R2, 2012, 2014 и более поздние.**
{.is-warning}


Чтобы начать установку продукта, запустите файл [SQLEXPRWT_x86_RUS.exe](http://download.microsoft.com/download/3/A/9/3A92B0B1-D996-464E-A0C9-60C9BFA2D071/SQLEXPRWT_x86_RUS.exe) или [SQLEXPRWT_x64_RUS.exe](http://download.microsoft.com/download/3/A/9/3A92B0B1-D996-464E-A0C9-60C9BFA2D071/SQLEXPRWT_x64_RUS.exe). После распаковки файлов появится экран выбора действий.

| | |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/32ab639a4e112fe543ef5fc30af645f8.png)                                                                                                                                                                                                                                        | Следует перейти на вкладку **«Установка»**. Необходимо выбрать **«Новая установка изолированного SQL Server или добавление компонентов к существующему экземпляру»**.                                                                                                                            |
| Щелкнуть **«Далее»** для продолжения. После распаковки файлов будет выведен список возможных ошибок, необходимо их устранить прежде, чем продолжить установку.                                                                                                                                                                                        | ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/6a24876866d8d96bf8839a1fd86bbff4.png)                                                                                                                                                                                   |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/19d6986005b4fc10f1cdab5a858a0141.png)                                                                                                                                                                                                                                        | Нажать **«Далее»** и согласиться с типичным лицензионным соглашением конечного пользователя. Нажать кнопку **«Установить».**                                                                                                                                                                     |
| В зависимости от необходимости можно выбрать, какие, необходимо установить: **Management Studio Express** (заменяет Query Analyzer и Enterprise Manager из ранних версий SQL), **Database Services**. По умолчанию путь для установки комопнентов: **C:\\Program Files\\Microsoft SQL Server**, для выбора другого пути, щелкнуть кнопку **«Обзор»**. | ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/1160c867cdfd619fa9adff5411933096.png)                                                                                                                                                                                   |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/8a5903d3520b2ff10dea7698f8ea8b95.png)                                                                                                                                                                                                                                        | Необходимо дождаться установки обязательных компонентов. В зависимости от необходимости можно выбрать, какие компоненты установить и нажать кнопку **«Далее»**, когда откроется окно мастера установки SQL Server, щелкнуть **«Далее».**                                                         |
| Экземпляры в SQL Server дают возможность легкого обслуживания множества баз данных. Экземпляр по умолчанию – **SQLExpess**. Можно выбрать экземпляр по умолчанию или указать свой именованный. Щелкнуть **«Далее»** для продолжения                                                                                                                   | ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/3a0d01ce44357631939c673caff836df.png)                                                                                                                                                                                   |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/caacb4db85adfd5142a72af4b4991c45.png)                                                                                                                                                                                                                                        | Учетные записи служб используются для обеспечения лучшей безопасности SQL Server и остальной сети, в случае ее нарушения. Щелкнуть **«Далее».**                                                                                                                                                  |
|      Выбрать режим **Mixed Mode (Смешанный режим)**                                                                                                                                                                                                                                                                                                   | ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/96c55fe36af5210199f276eff9d3a49b.png)                                                                                                                                                                                   |
> **SQL Server** может авторизовать пользователей двумя способами, с помощью **Active Directory** (режим аутентификации Windows - **Windows Authentication Mode**) и, с помощью собственной базы (смешанный режим - **Mixed Mode**, авторизация **Windows Authentication** также поддерживается).
{.is-info}

| | |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/690e7c416f5fb3a4306d0aa65c32229b.png)                                                                                                                                                                                                                                        | Далее можно выбрать варианты отправки сообщений об ошибках. Для работы сервера нет необходимости включать эти опции, щелкнуть **«Далее».** После завершения установки нажать кнопку **«Готово».**                                                                                                |
| Управляется SQL Server Express Edition посредством инструмента **SQL Server Management Studio Express**, который устанавливается вместе с сервером баз данных.  Для запуска зайти в меню **Пуск – Программы – Microsoft SQL Server 20ХХ – Среда SQL Server Management Studio Express**.                                                               | ![](/images/admin-guide/install/910dd8ea938f4ad9a708d463d177cd39.png)                                                                                                                                                                                                                                                  |
| ![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/install/d909136d2a4f9de15f888d085fb5484b.png)                                                                                                                                                                                                                                        | Ввести данные пользователя и нажать кнопку **«Соединить»**. В случае успешной авторизации запуститься среда SQL.                                                                                                                                                                                 |

> Остальные, более новые редакции SQL Server (2016, 2017, 2019, 2022) устанавливаются аналогичным образом.
{.is-info}


## Удаление SQL Server

Удаления SQL Server возможно через Панель управления (**меню Пуск  Панель управления Программы**). Необходимо будет удалить все компоненты Microsoft SQL.

![2013-04-22_120139.png](/images/admin-guide/install/a2be3257b8b85b68e05e3795f9741933.png)

Если не удается удалить экземпляр SQL Server, то воспользуйтесь [пошаговой инструкцией](https://docs.microsoft.com/ru-ru/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup) базы знаний корпорации Майкрософт.
