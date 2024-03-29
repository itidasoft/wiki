---
title: Айтида и UDS
description: Айтида РМК – интеграция с системой лояльности UDS
published: true
date: 2023-06-21T11:23:55.218Z
tags: скидки, бонусы, лояльность, uds
editor: markdown
dateCreated: 2022-12-21T10:36:25.124Z
---

# 1. Введение

Данное руководство описывает процесс интеграции программного обеспечения Айтида РМК с системой лояльности UDS. В рамках интеграции доступны такие операции в системе как:

-   Получение и отображение информации о клиенте по коду из приложения
-   Получение и отображение информации о клиенте по номеру телефона
-   Определение процента бонусов, доступных для списания в пределах суммы текущего чека, остатка баллов клиента и в пределах заданных ограничений для списания баллов в настройках бонусной программы UDS.
-   Списание бонусных баллов по коду клиента
-   Списание бонусных баллов по номеру телефона
-   Полное и частичное списание бонусных баллов
-   Начисление бонусных баллов без списания их в чеке
-   Полный и частичный возврат по операции
-   Печать ваучера на подключенной ККТ.
-   Отправка данных кассира для каждой проводимой операции для отображения статистики по продавцам в личном кабинете UDS

# 2. Настройка

Активация работы с системой UDS в модуле продаж версии 2 программного обеспечения Айтида производится в несколько этапов:

1.  Настраивается платежная система и подключается к схеме РМК.
2.  Настраивается бонусный счетчик и виртуальная карта клиента для отображения и возможности ввода бонусов в чеке
3.  Настраивается скидка UDS. Это основной триггер для активации клиента в чеке и работы с бонусами клиента

Ниже будут рассмотрены все перечисленные этапы и описаны необходимые действия для их настройки.

## 2.1. Настройка платежной системы для работы с UDS

Для настройки платежной системы требуется обновить Айтиду до версии 4.9 или выше. Далее нужно перейти в справочник торгового оборудования (Параметры – Торговое оборудование) и создать новую карточку оборудования

![Изображение выглядит как текст Автоматически созданное описание](/images/integrations/uds/2f1543ef31663ca288de42299b28e07a.png)

Заполнить в карточке оборудования следующие параметры:

**Наименование** – указать произвольное наименование оборудование (например, UDS).

**Тип оборудования** – выбрать тип «Платёжная система».

**Профиль** – скачать актуальные профили обмена с сайта и загрузить профиль под названием «Система лояльности UDS»

**Краткое имя** – UDS

**Устройство** – UDS

**Склад нахождения**, **Денежный карман**, **Юридическое лицо** – указать необходимые учетные данные.

**Вид оплаты** – выбрать «Безналичные» или «Кредит». Рекомендуется выбрать тот вид оплаты, которые меньше всего используется на данном рабочем месте.

>   Реальных платежей по данному виду оплаты производиться не будет, т. к. бонусные баллы или скидка UDS будут распределяться по позициям чека и срабатывать как обычные скидки в чеке.
{.is-info}


Созданную карточку оборудования необходимо добавить в схеме РМК для требуемых рабочих мест, на которых будет использоваться интеграция с системой UDS.

![Изображение выглядит как стол Автоматически созданное описание](/images/integrations/uds/ce1c4edbf386742055ca9add9fd170e6.png)

После добавления платежной системы UDS необходимо сохранить схему и перезапустить РМК. Если РМК работает в отдельной базе, с которой настроена синхронизация, то перезапуск РМК требуется выполнить после завершения синхронизации с узлом РМК.

## 2.2. Настройка бонусного счетчика и виртуальной карты UDS

Если настройки программы лояльности в личном кабинете UDS подразумевают начисление и списание бонусных баллов, то для реализации этой возможности в Айтида РМК требуется создать бонусный счетчик для бонусов UDS и виртуальную карту клиента UDS. Виртуальная карта UDS в данном случае требуется для работы с бонусами, их начислением и списанием для того бонусного счетчика UDS, который к этой карте привязан.

>   В данных карты никаких реальных персональных данных клиентов UDS не вводится, а бонусный счетчик не сохраняет в базе никаких итоговых значений накоплений или списаний.
{.is-info}


Чтобы создать бонусный счетчик необходимо перейти в модуль «Эксперт» (Сервис – «Айтида - Retail: Эксперт») и вызвать открытие справочника счетчиков бонусов по соответствующей кнопке модуля.

![](/images/integrations/uds/67369f1ab4460707af809b734625431d.png)

В открывшемся справочнике создать новую карточку счетчика бонусных баллов.

![](/images/integrations/uds/e8988201a04ae8d9cb2beeb470508b0a.png)

Указать следующие параметры:

1.  **Наименование** – любое произвольное наименование для счетчика бонусов, например «UDS бонусы»
2.  **Тип бонуса** – указать UDS (как на рисунке).

>   Внимание!!! Указание иного значения, отличного от UDS, для типа бонуса недопустимо и приведет к неработоспособности механизмов списания бонусных баллов клиентов в чеках.
{.is-warning}


3.  **Выражение для начисления суммы начисления:**

```js
RETURN RESTAPI.UDS_СкриптРасчетаСуммыНачислений("","", ВСЕГОНАЛ + ВСЕГОБЕЗНАЛ, 0);
```

![](/images/integrations/uds/47820ad6e4216e7deec2d221fe61f40c.png)

4.  **Выражение для расчета максимальной суммы оплаты:**

```js
RETURN RESTAPI.UDS_СкриптРасчетаМаксимальнойСуммыОплаты();
```

5.  **Не записывать баллы автоматически** – установить флаг, для того чтобы указать системе, что начисления и списания бонусов не будут происходить автоматически, а будет использован свой механизм начислений и списаний.
6.  **Скрипт расчета**: указать следующий скрипт взаимодействия с системой UDS

```js
RETURN RESTAPI.UDS_СкриптРасчетаБонусов( "", "", _СУММАКОПЛАТЕ, 0);
```

![Изображение выглядит как текст Автоматически созданное описание](/images/integrations/uds/f9e8820af886b89439c3701dbe35c885.png)

После установки необходимых параметров и вставки требуемых скриптов, карточку счетчика бонуса нужно записать и перейти к созданию виртуальной карты клиента. Виртуальной она в данном контексте считается потому, что реально выданной карты с таким номером не существует на руках клиентов или сотрудников торговых точек.

Для создания такой карты нужно в модуле «Эксперт» (Сервис – «Айтида - Retail: Эксперт») вызвать открытие справочника карт клиентов.

![](/images/integrations/uds/b99b3dc6c17fb58daae6ce8ecb629b22.png)

Создать новую карту по следующему шаблону:

![Изображение выглядит как текст Автоматически созданное описание](/images/integrations/uds/2c7970a570355f9b3ade5dec24f2475d.png)

**Наименование** – любое произвольное наименование карты, например, «Карта UDS»

**Номер карты** – Указать уникальное значение номера карты, не совпадающее ни с одним номером выданной карты в рамках других, используемых на данном предприятии, программ лояльности. Например, 999999999.

**Тип карты** – дисконтная / бонусная карта

**Счетчик бонусов** – выбрать созданные на предыдущем шаге бонусный счетчик UDS

После указания всех вышеперечисленных параметров нужно записать карточку дисконтной карты.

## 2.3. Настройка скидки UDS

Шаг по настройке скидки UDS является обязательным, независимо от того, будет ли начисляться скидка в рамках настроенной программы лояльности в личном кабинете UDS. Через применение скидки в чеке вызываются все остальные механизмы по запросу кода или телефона клиента, применение скидки (если разрешено), отображение информации о клиенте, замене клиента в чеке, очистке данных клиента в чеке.

![](/images/integrations/uds/bca8598d011ecd1676a3204e64dbe213.png)

Для создания такой скидки нужно перейти в справочник скидок в модуле «Эксперт» (Сервис – «Айтида - Retail: Эксперт») и создать новую карточку скидки по шаблону.

![](/images/integrations/uds/c33bbedcef8c7f7224065f5d2a2a5f20.png)

**Наименование** – любое произвольное название скидки. Например, «Скидка UDS».

**Текст для чека** – UDS

**Значение**: указать выражение

```js
RETURN RESTAPI.UDS_СкриптРасчетаСкидки();
```

**Тип значения** – «-\$» (минус сумма)

**Состояние карты** – любое

После указания параметров необходимо записать карточку скидки.

## 2.4. Настройка параметров РМК

Для реализации возможности ввода кода или номера телефона клиента, для поиска в системе UDS необходимо загрузить в базу дополнительные параметры. Сами параметры можно скачать с сайта в архиве с актуальными параметрами системы. Загрузить четыре параметра из архива с параметрами в справочник параметров системы (Сервис – Настройка системы – Настройка параметров системы). Названия требуемых параметров:

-   UDS_ДанныеКлиента – используется для хранения в чеке данных по клиенту.
-   UDS_ДанныеОперации – используется для хранения в чеке данных по операции списания/начисления бонусов в системе UDS
-   UDS_КодКлиента – используется для вызова диалога ввода кода клиента из приложения или поиска клиента по номеру телефона
-   UDS_ИнформацияОКлиенте – используется для отображения информации по клиенту, уже выбранному в рамках операции пробития чека при перезаписи или отмене клиента.

![Изображение выглядит как текст Автоматически созданное описание](/images/integrations/uds/45b4174058d9de140462e45661ffd0a8.png)

После загрузки параметров, необходимо в схеме РМК перейти на вкладку «Печать/Операции» - «Доп. Свойства» и добавить два свойства: UDS_ДанныеКлиента и UDS_ДанныеОперации

![Изображение выглядит как стол Автоматически созданное описание](/images/integrations/uds/8304517105a2df05effd2ea43449a85a.png)

Далее в схеме РМК перейти на вкладку «Прочее» - «Интерфейс» и в поле «Строки подвала» активировать отображение пятой строки подвала, в которой будут отображаться данные по клиенту после поиска его по коду или номеру телефона. Активация отображения строк подвала происходит путём перечисления через запятую номеров строк, которые должны отображаться в подвале интерфейса. Пример активации отображения указан на рисунке ниже.

![Изображение выглядит как текст Автоматически созданное описание](/images/integrations/uds/9cfabfcf09af18b363f44f6cbe6197c4.png)

В данном примере активированы все пять строк подвала

После установки отображения можно сохранить схему РМК и продублировать настройку для всех схем РМК, в которых будет применяться работа с системой UDS.

По завершению можно перейти к работе с системой UDS в интерфейсе кассира.

# 3. Работа с системой лояльности в РМК.

## 3.1. Поиск клиента по коду/телефону и активация работы с UDS в чеке

Для активации работы с системой UDS в интерфейсе кассира необходимо выбрать пункт меню «Скидки %» - «Скидки на чек» (или клавиатурную функцию «Применить ручную скидку»).

>   Данную скидку требуется применять после добавления всех позиций в чек и после применения прочих скидок, действующих в предприятии.
{.is-info}


![](/images/integrations/uds/9be52ae1095817ec404bffbb72916765.png)

![Изображение выглядит как стол Автоматически созданное описание](/images/integrations/uds/0846eb803274642800371299e11ac5cd.png)

В открывшемся окне выбора скидки для применения выбрать скидку UDS.

![](/images/integrations/uds/229a5320421e72f8d2c94685cbbe8f1f.png)

После выбора скидки будет предложено ввести код клиента или его номер телефона.

![](/images/integrations/uds/ecc3a421655af1b6d6a8f5de0eb6de91.png)

В данном поле ввода поддерживается ввод с клавиатуры или чтение QR кода клиента сканером штрихкодов. Ввод кода клиента или телефона клиента требуется подтвердить нажатием кнопки «Продолжить» в данном окне или нажатием Ctrl+Enter на клавиатуре.

При успешном поиске клиента в пятой строке подвала отобразится информация о клиенте и его бонусах.

![](/images/integrations/uds/20e1c31cf541fce57436305aad7fec1c.png)

Так же вместе с отображением клиента произойдут следующие автоматические действия:

1.  В чек добавится виртуальная карта, созданная при осуществлении настройки интеграции
2.  Если в настройках программы лояльности в кабинете UDS разрешено применение скидки, то эта скидка автоматически применится к чеку.
3.  Станет доступно списание бонусных баллов в чеке, указанных в поле «Доступно» информации о клиенте. Сумма доступных для списания баллов рассчитывается исходя из суммы текущего чека и настроек программы лояльности в личном кабинете UDS.

## 3.2. Продажа с указанием клиента и без списания баллов

Для начисления бонусных баллов клиенту, необходимо добавить клиента через скидку UDS (см. пункт 3.1.) в чек и осуществить продажу без ввода бонусных баллов. В этом случае клиенту сработает только начисление, а текущие баллы не спишутся.

## 3.3. Продажа с указанием клиента и со списанием баллов

Для списания бонусных баллов в чеке, необходимо добавить клиента в чек через скидку UDS (см. пункт 3.1.) и перед вводом оплат вызвать функцию ввода бонусных баллов.

![Изображение выглядит как стол Автоматически созданное описание](/images/integrations/uds/5e8c969f286c899e708802d0a1a9a6b5.png)

В следующем окне распределения бонусных баллов ввести сумму списываемых баллов в пределах доступных и нажать «Продолжить».

![](/images/integrations/uds/3fa3af94580f87de74d9c69c7c01d6b1.png)

Далее ввести остальные виды оплаты и пробить чек.

Перед фискализацией чека будет произведена отправка операции в систему UDS и при успешном её выполнении напечатан кассовый чек и списаны, а также начислены, баллы клиенту согласно настроенной программе лояльности в кабинете UDS.

Если же провести операцию списания баллов не удалось по каким-либо причинам, то будет выведено сообщение об ошибке и пробитие чека прервано для устранения этой ошибки.

## 3.4. Продажа без указания клиента, печать ваучера

Если пробить чек с настроенной интеграцией с системой UDS без указания клиента в чеке, то перед печатью кассового чека будет напечатан ваучер, который можно передать клиенту для ручного начисления баллов через приложение.

Применение механизма ваучеров удобно для ситуаций, когда клиент забыл взять с собой телефон и совершил покупку.

>   Для отключения механизма печати ваучеров необходимо в настройках констант системы создать константу **_UDS_ПЕЧАТАТЬВАУЧЕРЫ** и установить для неё значение логического типа «Ложь».
{.is-info}


## 3.5. Замена клиента в чеке

Для замены уже введенного в чеке клиента необходимо повторно применить скидку UDS (см. пункт 3.1) в чеке и в открывшемся окне ввести данные нового клиента в поле ввода кода или телефона

![Изображение выглядит как текст Автоматически созданное описание](/images/integrations/uds/808de217b966a0ddfc5d88ab6689cbf8.png)

## 3.6. Очистка клиента в чеке

Для очистки клиента в чеке и пробития чека без клиента UDS необходимо повторно вызвать применение скидки UDS (см. пункт 3.1.) и в открывшемся окне ввода (см. пункт 3.5.) нажать кнопку «Отмена».

## 3.7. Возврат по чеку.

Для пробития полного или частичного возврата по чеку необходимо вызвать операцию «Чек на основании»

![Изображение выглядит как стол Автоматически созданное описание](/images/integrations/uds/50853893e080714d610bc832827a7acb.png)

В открывшемся окне выбора чека, по которому делается возврат, найти и выбрать чек по номеру/смене/дате вручную или чтением QR кода с чека продажи.

Если при выборе чека, на основании которого делается возврат, получили сообщение о необходимости повторного применения скидки UDS, то применяем скидку в чеке возврата UDS согласно пункту 3.1.

![](/images/integrations/uds/5e44460cb03b01b396e301fb3a520f68.png)

Далее, в случае частичного возврата требуется отредактировать позиции, оставив только возвращаемые. Либо оставить все позиции как есть, в случае полного возврата.

![Изображение выглядит как стол Автоматически созданное описание](/images/integrations/uds/6dd0ea7783bea37907b88e4015f6fab4.png)

Перед вводом оплат чека вызвать функцию ввода бонусных баллов и в открывшемся окне распределения баллов будет загружена сумма баллов к возврату из чека продажи автоматически.

![](/images/integrations/uds/f24df6e2e34dfd72927b7a13ab1e6d27.png)

Остальные оплаты в чеке распределить согласно чеку продажи и пробить чек.

Перед пробитием чека информация о возврате будет отправлена в систему UDS.

## 3.8. Изменение состава чека после ввода клиента в чеке

Сумма баллов, доступных к списанию в чеке рассчитывается на основе суммы текущего чека и настроек программы лояльности в личном кабинете UDS. Исходя из этого, применение клиента в чеке рекомендуется делать после того, как ввели и отредактировали все позиции в чеке.

Если все же происходит так, что после ввода клиента в чек, отредактировали состав чека и требуется пересчитать доступный остаток бонусов исходя из новых сумм чека, то для такого пересчета достаточно применить скидку UDS (см. пункт 1) в чеке повторно и в окне подтверждения клиента (см. пункт 3.5) нажать кнопку «Продолжить» для повторного применения текущего клиента в чеке и перезапроса из UDS актуальных данных по клиенту.
