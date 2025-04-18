---
title: Подключение ККТ Вики Принт к Айтиде
description: ККТ Вики Принт от Дримкас
published: true
date: 2024-12-08T21:00:37.476Z
tags: ккт, онлайн-касса, фискальный регистратор, вики принт, дримкас
editor: markdown
dateCreated: 2024-12-04T12:34:59.956Z
---

# Установка драйвера
Для работы с **ККТ Вики Принт** необходимо установить VikiDriver.
VikiDriver это драйвер для работы Вики Принт 57Ф, Вики Принт 57Ф Плюс, Вики Принт 80 и Пирит 2Ф. Используется для автоматического и ручного подключения кассы по USB, COM и TCP/IP и для работы по API.

> **Минимальные требования**
> 32 или 64-битная версия Windows 7 с пакетом обновления (SP 1)
{.is-info}

Перейдите по ссылке: [https://help.dreamkas.ru/kb/zagruzki/](https://help.dreamkas.ru/kb/zagruzki/viki-print-57-f-viki-print-57-plyus-f-viki-print-80-plyus-f-/) и скачайте дистрибутив с той версией VikiDriver, которая подходит для вашей операционной системы.

Подключите Вики Принт к компьютеру.

> **Информация**
> Если вы ранее использовали Вики Принт вместе с службой ComProxy, то удалите её [по инструкции](https://help.dreamkas.ru/kb/viki-printy/obsluzhivanie-kassy-viki-print/udalit-sluzhbu-comproxy/?sphrase_id=25615)
{.is-success}

Запустите файл и нажмите кнопку **«Далее»** → Следуйте подсказкам установщика пока не начнётся установка компонентов.

![6ovx3jya9e2e2sng6eyfh5g3gyte0de2.png](/images/integrations/kktvikiprint/6ovx3jya9e2e2sng6eyfh5g3gyte0de2.png){.align-center}

Нажмите **«Завершить»**

VikiDriver установлен. Он запустится как служба Windows, иконка отобразится в системном трее.

# Подключение Вики Принт к Viki Driver
Viki Driver при запуске сканирует сеть и сам находит все доступные Вики Принты, но есть возможность найти кассу вручную.
При запуске Viki Driver выберите **Подключить ККТ вручную**

![1fbc2cmkhctjvwe6vzduor2wtsar3hoh.png](/images/integrations/kktvikiprint/1fbc2cmkhctjvwe6vzduor2wtsar3hoh.png){.align-center}

В зависимости от того как вы хотите подключить Вики принт выберите тип подключения:

**Если по СOM-порту**, то выберите способ подключения "**СОМ-порт**", а затем нужный вам порт, например, СОМ-10 → Нажмите кнопку **Подключить**.

![lbx9d236pxceze4320bnfr8zqk7doz7b.png](/images/integrations/kktvikiprint/lbx9d236pxceze4320bnfr8zqk7doz7b.png){.align-center}

**Если по TCP/IP** (доступно для Вики Принт с WI-Fi модулем), то выберите способ подключения "**TCP/IP**" → Укажите IP-адрес Вики Принт → Нажмите кнопку **Подключить**.

Присутствует так же способ поиска ККТ по mDNS (доступно для Вики Принт с WI-Fi модулем).
Если у вас в одной сети работает несколько Вики Принтов, то включите тумблер "**Поиск ККТ по сети**".

![cmi8a33gpeap8i1jedwjccxjf3d8d884.jpg](/images/integrations/kktvikiprint/cmi8a33gpeap8i1jedwjccxjf3d8d884.jpg){.align-center}

Viki Driver найдет все, которые есть и выведет список устройств

![gv3vv9cd8jablxe733tajw0vwhe6vw25.png](/images/integrations/kktvikiprint/gv3vv9cd8jablxe733tajw0vwhe6vw25.png){.align-center}


# Настройка торгового оборудования в Айтиде
Подключение оборудования в Айтиде осуществляется через справочник торгового оборудования, который можно открыть через пункт меню Параметры - Торговое оборудование. В справочнике необходимо создать новую карточку оборудования по следующему шаблону.

![2024-12-05_14-27-36.png](/images/integrations/kktvikiprint/2024-12-05_14-27-36.png){.align-center}

**Наименование** - указать произвольное название оборудования
**Тип оборудования** - выбрать "Фискальный регистратор"
**Профиль** - выбрать профиль для работы из следующего списка:
 - **Библиотека ФР. Профиль ФР Вики Принт (ФН, ФФД 1.2, VikiDriver)** - для работы с ККТ Вики Принт по формату фискальных данных 1.2.
 
**Отсоединяться от устройства после окончания операции** - для данной модели ККТ и драйвера роли не играет, поскольку отправка команд происходит посредством http и соединение с ККТ разрывается и так после каждой команды.

Вкладка **Печать чека/ ФОД/ ПС** 

![2024-12-05_14-29-51.png](/images/integrations/kktvikiprint/2024-12-05_14-29-51.png){.align-center}

**Использовать ФР для печати чеков платежной системы** - флаг используется только в МРП1 для определения на каком ФР печатать слипы платежной системы, если их подключено несколько, а направить печать всех сливов нужно на один ФР. При снятом флаге слипы печатаются на ФР, привязанных к тем же группам печати (кодам ФР), что и подключенная платежная система.
**Выполнять проверку КМ на этом ФР** - при работе с ККТ, зарегистрированной для работы с ФФД 1.2 установка флага активирует проверку кода маркировки через подключенную ККТ (проверка через ОИСМ). По результатам проверки будет выведено уведомление кассиру с выбором действия по разрешению пробития или отклонения сканируемого кода маркировки при отрицательном результате проверки. Если флаг не установлен, то коды маркировки будут добавляться в чек без предварительной проверки.
**Номер платежной системы в драйвере** - параметр используется только в МРП1 и определяет номер логического устройства в драйвере платежных систем Атол (при использовании спец.профиля для ФР), на котором производить операцию оплаты по банковской карте. Для МРП2 (РМК) не используется, т.к. в МРП2 используется иной механизм подключения платежных систем.
**Система налогообложения** - указывается система налогообложения, которая будет передаваться в составе реквизитов чека. Если значение на выбрано, то в чеках будет использоваться значение из настроек ККТ по умолчанию.

# Подключение ККТ к модулю РМК

Для добавления созданной карточки оборудования к перечню оборудования рабочего места РМК необходимо в рабочей схеме РМК для нужного рабочего места добавить карточку ФР на вкладке **РМК/Кассиры** - **Оборудование**.

![2024-12-05_14-31-41.png](/images/integrations/kktvikiprint/2024-12-05_14-31-41.png){.align-center}

После этого можно перейти в РМК, открыть параметры РМК и по кнопке **"Настройка оборудования"** перейти к списку подключенного к рабочему месту торгового оборудования.

![рм-настройка-оборудования.png](/images/integrations/kktatol/рм-настройка-оборудования.png){.align-center}

Выбрать из списка карточку ФР и нажать на кнопку с тремя точками для вызова диалога настроек параметров связи.

![2024-12-05_14-32-31.png](/images/integrations/kktvikiprint/2024-12-05_14-32-31.png){.align-center}

![2024-12-05_14-33-08.png](/images/integrations/kktvikiprint/2024-12-05_14-33-08.png){.align-center}

В открывшемся диалоге настроек необходимо заполнить параметры связи и параметры работы ККТ.

**IP-адрес** - указать IP адрес ПК, на котором установлен VikiDriver и подключена ККТ.
**IP-порт** - указать IP порт подключения к VikiDriver по API. По умолчанию равен 8088.
**Заводской номер кассы** - необходимо указать заводской номер подключенной ККТ. По заводскому номеру происходит определение драйвером, для какой ККТ адресован запрос по API. Без заводского номера интеграция работать не будет.

Для сохранения установленных параметров связи с ККТ необходимо воспользоваться зеленой кнопкой "**Продолжить**" в диалоге настройки параметров связи с ККТ.