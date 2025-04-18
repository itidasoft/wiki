---
title: Настройка модуля ЕГАИС
description: Руководство по модулю ЕГАИС
published: true
date: 2025-04-16T07:12:58.389Z
tags: егаис, настройка модуля
editor: markdown
dateCreated: 2022-07-25T21:57:52.969Z
---

# Введение

За время, прошедшее с начала действия ЕГАИС для розничной торговли, сменилось несколько версий формата обмена данными с этой системой. По этой причине, в модуль ЕГАИС Айтиды были внесены существенные изменения, адаптирующие его работу к текущим требованиям. В данном руководстве собраны наиболее существенные и часто используемые методы работы с модулем ЕГАИС в Айтиде.

# Предварительные настройки

ЕГАИС ИД – это идентификатор подразделения организации в ФС РАР.

Узнать ЕГАИС ИД можно на странице УТМ в любом браузере.

.

## ЕГАИС-ИД {#егаис-ид}

Чтобы узнать свой ЕГАИС ИД через аппаратный ключ, необходимо подключить к ПК носитель с криптографической электронной подписью (КЭП), открыть утилиту для работы с аппаратными носителями и перейти на вкладку «Ключи и сертификаты». При этом потребуется ввести пароль пользователя RSA-ключа (как это показано на картинке ниже):

![](/images/egais/settings/31d3f0d9d3e20ddfb30f2ecb25a66d92.png)

После того, как пароль введён, в окне утилиты необходимо кликнуть двойным щелчком мыши по иконке с сертификатом (откроется сам сертификат), перейти на вкладку «Состав» в окне «Сертификат», затем выбрать поле «Субъект».

Значение «CN» тут и будет искомым идентификатором (см. картинку ниже):

![](/images/egais/settings/d509d7891adcb65b3875328294391921.png)

ЕГАИС-ИД можно узнать также в браузере, на странице УТМ в разделе сертификатов RSA:

![Изображение выглядит как текст Автоматически созданное описание](/images/egais/settings/fc4c114ba9b02b79e6eb6d31eab118bf.png)


# Подключение и настройка модуля ЕГАИС

Для подключения модуля ЕГАИС необходимо добавить в систему меню программы пункт *Модуль ЕГАИС* (название пункта может быть изменено партнёром по его усмотрению). В дистрибутивной базе данный пункт расположен в меню Сервис. Для самостоятельного подключения этого пункта необходимо использовать команду *DO FORM egaisform*.

![Изображение выглядит как текст Автоматически созданное описание](/images/egais/settings/02da068263182f3647e3229db8d9d7bf.png)

Для отображения добавленного пункта в меню необходимо перезапустить систему Айтида. Так же, необходимо добавить пункт меню для вызова формы сопоставления товаров с алкокодами ЕГАИС. Для этого необходимо использовать команду `DO FORM egaissubst.`

Сопоставления товаров из справочника с алкокодами необходимо, т.к. все данные, приходящие из ЕГАИС содержат в качестве идентификатора товара алкокод. Для перевода алкокода в товар из справочника необходимо связать его с карточкой товара. С одной карточкой товара может быть связано несколько алкокодов. В этом случае, продукция с разыми алкокодами будет идентифицироваться в Айтиде с одним товаром. Такие связи часто нужны для пивной продукции, для которой существует несколько производителей. У каждого производителя или каждого завода одного производителя, свой алкокод для продукции. А в продаже это один товар.

![Изображение выглядит как текст Автоматически созданное описание](/images/egais/settings/9fb933c5e069bf2b36c0af21d16c4fda.png)

Первый запуск модуля необходимо произвести от имени пользователя с правами администратора. В этом случае будет доступен функционал по настройке модуля:

![Изображение выглядит как стол Автоматически созданное описание](/images/egais/settings/d8f2ddea158c6ac765fc81153232e449.png)

Для корректной работы с модулем в параметрах системы необходимо установить признак **Колонки для работы с ЕГАИС**.

![Изображение выглядит как текст Автоматически созданное описание](/images/egais/settings/5a966d49748e12d3fb02b009ca58e236.png)

Настройка модуля производится для каждого склада (торговой точки), на которых предполагается обмен данными с ЕГАИС. В окне настройки можно указать следующие параметры:

![Изображение выглядит как текст Автоматически созданное описание](/images/egais/settings/36581de275ab70f4110e274891b49723.png)

1.  Раздел **Системные параметры** заполняется автоматически при установке обновления системы Айтида и содержит тексты обработок, выполняющих необходимые функции по взаимодействию с транспортным модулем ЕГАИС. Раздел доступен при запуске системы в режиме конфигурации при наличии NFR лицензии/сублицензии.
2.  Кнопки **Добавить УТМ** **в список, Изменить название УТМ в списке** и **Удалить УТМ** **из списка** позволяют формировать список УТМ для работы.
3.  **IP Адрес** и **порт доступа** транспортного модуля ЕГАИС. В этих полях необходимо указать IP адрес компьютера, на котором установлен транспортный модуль, и порт доступа к нему. Если транспортный модуль установлен на том же компьютере, что и Айтида, и других рабочих мест нет, то можно указать значение 127.0.0.1.
4.  В поле **ЕГАИС ИД** необходимо указать идентификатор в системе ЕГАИС для используемого УТМ (см. раздел [**ЕГАИС-ИД**](#егаис-ид)).
5.  В поле **Время отклика** можно задать максимальное время ожидания ответа УТМ в секундах. По умолчанию, если значение не указано, то время ожидания ответа составляет 100 секунд. Обычно, этого времени УТМ достаточно для обработки больших документов. Если за указанное время ответ от УТМ не был получен, то в Айтиде не будет определен результат операции и будет выведено сообщение об ошибке "**Ответ сервера не был распознан**". В этой ситуации необходимо почистить базу данных УТМ. Возможно, что придется переустановить УТМ и/или увеличить время ожидания ответа от УТМ.
6.  В разделе **Папки** **для создания новых объектов** необходимо выбрать папки справочников, в которых будут создаваться новые товары и контрагенты. Данные, загружаемые из транспортного модуля, содержат в себе не только накладные поставщиков, но и необходимые реквизиты производителей, импортёров, поставщиков товаров, а также описание самих товаров. При загрузке неопознанные контрагенты и товары будут созданы в указанных папках. При создании новых карточек товара будет учитываться, какая группа ресурсов указана в выбранной папке. В новые карточки будет перенесена информация заданная в группе ресурсов, так. Как если бы эта группа была выбрана в карточке товара интерактивным путем.

![Изображение выглядит как текст Автоматически созданное описание](/images/egais/settings/1dcdaac33aa9943d837001e07e83e6e4.png)

7.  В разделе **Параметры создаваемых документов** необходимо выбрать **Организацию** и **Склад**, на которые будут создаваться приходные накладные. Если эти параметры не будут выбраны, то в процессе создания документов значения будут подставлены из настроек пользователя, осуществляющего операцию загрузки.
8.  В **Прочих параметрах** можно изменять работу алгоритма загрузки:
9.  Установка флага **Изменять карточки контрагентов**  позволяет производить автоматическое обновление реквизитов контрагентов в процессе загрузки данных. Идентификация загружаемых контрагентов (производителей/импортёров/поставщиков) производится по идентификатору ЕГАИС, а в случае его отсутствия по ИНН и КПП.
10.  При установленном флаге **Пересоздавать не проведенные накладные** при повторной загрузке данных имеющиеся в Айтиде документы будут удалены и добавлены снова. Если флаг не установлен, такие документы будут оставлены без изменений, и новые созданы не будут. При этом, пользователь увидит сообщение, что документ присутствует в системе, но пересоздан не был.

>   Внимание! При удалении документа будут удалены также и все изменения, внесённые в документ после его загрузки из ЕГАИС.
{.is-warning}


11.  Если установлен флаг **Удалять успешно загруженные данные**, после загрузки файлы из транспортного модуля будут удаляться. Удаление загруженных файлов позволяет уменьшить размер базы данных транспортного модуля и не загружать повторно данные в Айтиду.
12.  Если установлен флаг **Сопоставлять товары после загрузки данных**, то в случае, если после загрузки данных добавились новые товары, которых еще нет в справочнике товаров Айтиды, будет выведено окно для осуществления сопоставления/создания карточек товаров с алкокодами, пришедшими из ЕГАИС. Если флаг не установлен, тогда форма сопоставления не будет выведена. В этом случае, сопоставление можно будет выполнить позже – при проверке загруженных накладных, или вызвав форму сопоставления из меню.
13.  Если установлен флаг **Использовать формат обмена с ЕГАИС версии 4**, то исходящие ТТН будут передаваться в четвертом формате ЕГАИС.
14.  Флаг **Ожидать подтверждения отправки перемещения по приходной накладной**, не используется.
15.  Флаг **Включать маркированный алкоголь в акты списания по ДКС и ВТ** не используется.

- Следующая тема: [:blue_book: Работа с модулем ЕГАИС](/egais/working)
{.links-list}