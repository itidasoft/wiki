---
title: Распределенная база данных
description: Айтида РМК
published: true
date: 2022-08-14T21:28:24.015Z
tags: сеть магазинов, обмен рмк, загрузка продаж в сети, сеть заведений
editor: markdown
dateCreated: 2022-08-14T21:18:04.887Z
---

# Описание

Естественным требованием к работе кассового программного обеспечения является его работа в территориально удаленных друг от друга и от центрального офиса местах. При этом необходимо обеспечить стабильную работу как при наличии каналов связи между РМК и центральной базой данных, так без таковых. Для реализации этого требования в ПП Айтида предусмотрен вариант работы с распределенной базой данных.

Термин распределенная база означает, что в одном месте, в так называемом центре, установлена и работает основная учетная система с базой данных, содержащей всю информацию из работающей системы. На удаленных компьютерах РМК установлена база данных, которая позволяет осуществлять продажи локально без необходимости постоянного прямого подключения к центральной базе данных. В такой локальной базе храниться информация необходимая для осуществления продаж. Эта информация является точной копией данных в центре, но не полной, а только в необходимой части для осуществления работы РМК.

В зависимости от имеющихся ресурсов производится обмен данными между такой базой и базой центра. В процессе обмена данными из центра поступает обновленная информация о товарах, ценах, остатках, оборотах по дисконтным картам, настройки и т. п. В обратную сторону передаются накопленные продажи в виде чеков и кассовых транзакций.

Обмен может осуществляться как в ручном, так и в автоматическом режиме. Все зависит от конкретных условий и наличия связи между РМК и центром.

В случае наличия (квази)устойчивого канала связи можно настроить полностью автоматический обмен данными, при котором с заданной периодичностью будет осуществляться прямая связь РМК и центра.

В случае отсутствия такого канала связи, например и у РМК и центра связь только сеансовая, можно использовать обмен файлами через электронную почту/FTP серверы.

В случае отсутствия возможности связи на одном из узлов обмена возможен ручной обмен файлами.

Для настройки распределенной сети используется справочник **Узлов обмена**. Данный справочник нужно добавить в меню, используя команду `DO sprexchangenodes`.

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/2a34b9a67556e32a328cafb5aef5fa51.png)

Под узлом обмена понимается не конечное рабочее место кассира, а место расположения узла распределенной базы данных, к которой могут быть подключены несколько рабочих мест кассиров.

Например, это может выглядеть так.

![](/images/rmk/exchange/26bb92cbec13b764cfd540f6a5b85653.png)

В справочник узлов обмена добавляют все узлы, между которыми предполагается обмен данными.

# Узел обмена.

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/2c8e867a9054f29a3163c4217f243e28.png)

Кроме названия, для узла обмена определяются следующие параметры.

-   **Тип узла** – позволяет указать, чем является узел центром, кассовым узлом или промежуточным узлом.
    -   **Центр** – это узел, в котором ведется учет, создаются товары, назначаются цены и производятся настройки. Из центра все эти данные передаются в кассовые узлы и промежуточные узлы. Обратно получаются чеки и кассовые транзакции, которые приходят из кассовых и промежуточных узлов.
    -   **Кассовый узел** – узел, в котором осуществляются продажи. Из центра и из промежуточных узлов принимаются данные о товарах, настройках, ценах. Обратно отправляются чеки и кассовые транзакции.
    -   **Промежуточный узел** – служит для транзита данных между центром и кассовым узлом. Может представлять из себя, например, облачное хранилище. Из центра получает данные о товарах, ценах, настройках. Передает эти данные в кассовые узлы. Обратно получает и передает чеки и кассовые транзакции.
-   **Адрес сервера для online обмена** – ip адрес и номер порта для прямого обмена данными между узлами. При наличии непустых значений будут осуществляться попытки прямого доступа по указанным реквизитам. Схема прямого обмена предполагает, что инициатором обмена является кассовый узел, в котором с заданной периодичностью служба инициирует соединение с центральным или промежуточным сервером и передает сформированные файлы с данными. В этом же соединении кассовый узел получает файлы с данными из центра. Такая схема выбрана в качестве стандартной потому, потому что чаще всего у кассового узла нет статического IP адреса и из центра у нему нельзя подключиться. Поэтому, IP адрес и порт, может быть указан только для центра и для промежуточного узла.<br>   
		**Пример:**
![](/images/rmk/exchange/85bdfcc105414ada087c25b9993da63f.png)

Для такой схемы создаются карточки узлов обмена, как на следующих рисунках. <br>

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/1959001c3d1ff906eeaeca7d5e218f09.png)

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/2c8e867a9054f29a3163c4217f243e28.png)
		
> Центральный офис содержит адрес для прямого обмена.
{.is-info}

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/87c715bd77d452f3cb204fb033c45c7b.png)
    
> Кассовые узлы не содержат адреса.		
{.is-info}
		
-   **Объекты для передачи** – вызывает окно для настройки объектов, которые необходимо передавать на кассу и получать из кассы. <br>
    ![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/396dc1e20859e806847dc09387f9dc25.png)

    По умолчанию передаются и принимаются все допустимые объекты. При необходимости уменьшить объем передаваемых данных, можно с некоторых объектов снять признаки. Например, если не нужно на кассе отслеживать остатки товаров, то можно не передавать туда остатки. Если нет необходимости в кассовых транзакциях, или самих чеках, то можно их не получать из кассового узла. Настройка доступна для кассовых и промежуточных узлов. При отправке данных из центра в кассовый узел используются данные из карточки узла получателя (кассы). При отправке данных из кассового узла в центр используются данные узла кассы. Таким образом, для каждого узла может быть настроен свой список объектов для обмена.

-   **Отправка данных** – раздел позволяет задать способ доставки для автоматической передачи файлов с данными узлу обмена. Если будут заданы E-mail адрес и/или тема сообщения, то эти значения будут использованы вместо тех, которые заданы в способе доставки.
-   **Дата отправки данных** – позволяет вручную изменить дату отправки данных в узел обмена. Изменение даты позволит повторно отправить данные, в случае утери из в узле обмена. Если будет указана пустая дата, то при ближайшем обмене будет сформирован файл со всеми данными. Это означает, что при приеме такого файла перед загрузкой имеющиеся справочники (в РМК) будут очищены и заменены пришедшими данными. Первоначальная выгрузка из центра производится именно в таком виде.
-   **Получение данных** – позволяет указать способ доставки, который будет выполняться перед загрузкой данных.
-   **Дата получения данных** – позволяет изменить дату получения данных. Данные принимаются только в том случае, если дата приема данных раньше, чем дата принимаемых данных. Поэтому, для повторного приема данных необходимо отодвинуть эту дату в прошлое, на необходимо количество времени.
-   **Каталог для обмена файлами с данными** – необходимо указать доступный каталог, в который будут записывать формируемые и промежуточные файлы.
-   **Признак Только принимать данные** – укажет системе, что не нужно отправлять данные никому.

# Служба обмена данными.

Непосредственно формированием (загрузкой, выгрузкой и доставкой) данных занимается служба Айтиды. Настройка производится в программе ISConfig.exe.

На первой закладке необходимо последовательно заполнить следующие поля.

-   **Имя исполняемого файла службы** – необходимо выбрать файл IDMService.exe.
-   **Имя службы** – если на компьютере запускается несколько экземпляров службы для разных целей, то необходимо задать имя для службы.
-   **Имя файла журнала сообщений и ошибок** – желательно задать имя файла, в который будет записывать журнал сообщений и ошибок. Журнал будет автоматически архивироваться при достижении размера 10 Мб.
-   **Параметры подключения к серверу –** необходимо выбрать SQL сервер с рабочей базой данных Айтиды и указать параметры для подключения к нему.

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/6f3e2e5c0a9d33d65d5d56f9231a53ca.png)

На закладке **Прочее** необходимо заполнить параметры обмена.

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/7ff326322073cfff27d11571f9af2476.png)

-   **Порт сервера обмена –** номер свободного порта на компьютере. Например, 9501. Если номер порта не указан, то сервер, принимающий подключения от других узлов, не будет запущен. Для кассовых узлов такой сервер не нужно запускать. Кассовые узлы сами связываются с центральным узлом. Поэтому, в кассовых узлах это поле необходимо оставить пустым или указать значение 0.
-   **Интервал обмена с центром –** задается интервал, по истечении которого служба кассового или промежуточного узла будет пытаться связаться с “вышестоящими” узлами. Для кассового узла вышестоящий узел – это промежуточный либо центральный узел. Для промежуточного узла – центральный узел.
-   **Интервал доставки данных –** задается интервал получения данных способами доставки. Доставка осуществляется способом, указанным в карточке текущего узла обмена.
-   **Код узла обмена –** код карточки узла обмена, к которому принадлежит текущий узел.
-   **Папка для файлов –** путь к папке, из которой будут браться файлы для обработки. В эту папку необходимо положить файл с начальными данными, при формировании нового кассового узла.
-   **Удалять обработанные файлы –** установка признака укажет службе на необходимость удалять обработанные файлы. Иначе, обработанные файлы будут переименованы, но сохранены. Сохранять файлы имеет смысл на начальном этапе запуска для контроля процесса обмена. Потом их лучше удалять, чтобы не занимали место.

После заполнения всех параметров необходимо нажать кнопку **Сохранить**. На закладке **Служба и подключения** нажать кнопки **Установить службу** и **Запустить службу**. Служба обмена начнет свою работу.

# Порядок формирования ДКС в базе центра.

При работе с распределенной базой данных документы кассовой смены должны формироваться не в базе кассового узла, а в базе центрального офиса. Все необходимые для этого данные в базе центра будут сразу после завершения обмена данными с кассовым узлом.

Стандартным вариантом автоматизации процесса формирования ДКС в базе центра является настройка задания для планировщика «**Загрузка данных из РМК**».

Задание необходимо настроить на запуск, когда заведомо должны завершиться процессы получения итоговых данных из кассовых узлов. Например, так

![Изображение выглядит как текст Автоматически созданное описание](/images/rmk/exchange/9ec92149032e1d9ed20937fd14ce8deb.png)

При необходимости обеспечить ручную загрузку данных можно добавить кнопку в панель управления пользователя. Текст исполняемого скрипта можно взять из задания «**Загрузка данных из РМК**».

![](/images/rmk/exchange/07546952d0c29603b3e57637d4292af1.png)

```js
ЗАПРОС( "SET DATEFORMAT DMY" );
ДОБАВИТЬКОНТЕКСТ( "SELECT DISTINCT code, rmk FROM specrmkschem WHERE rmk <> ''", "СписокРМК" );
WHILE ( !КОНЕЦКОНТЕКСТА( "СписокРМК" ) )
{
	Сервис.РМКСоздатьДокументы( СписокРМК.code, СписокРМК.rmk );
	ПРОПУСТИТЬ( 1, "СписокРМК" );
}
УДАЛИТЬКОНТЕКСТ( "СписокРМК" );
```

# Порядок формирования базы данных нового кассового узла.

Для формирования базы данных нового кассового узла необходимо выполнить следующие шаги.

1.  В центре при запущенной службе обмена добавить новую карточку узла обмена и заполнить её поля.
2.  Дождаться интервала, заданного в параметре службы **Интервал обмена с центром**. С этим же интервалом служба в центре сформирует данные для нового узла обмена. Так как в новой карточке поле **Дата последней выгрузки** будет пустое, то служба сформирует первый полный файл со всеми данными. Файл будет называться:

    [КодУзлаЦентра]_[КодКассовогоУзла]_[ДатаИВремя].dex

3.  В кассовом узле развернуть чистую базу из дистрибутива.
4.  Настроить службу обмена согласно описанию выше.
5.  В каталог, указанный в настройках службы положить файл, сформированный в центре.
6.  Через указанное время служба начнет загрузку файла. Как только файл будет переименован или удален, это будет означать, что данные загружены и можно запускать МРП 2.