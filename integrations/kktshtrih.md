---
title: Подключение ККТ Штрих к Айтиде
description: ККТ Штрих от компании Штрих-М
published: true
date: 2024-12-05T08:53:23.671Z
tags: штрих, ккт, онлайн-касса, фискальный регистратор
editor: markdown
dateCreated: 2024-12-04T12:31:59.028Z
---

# Установка драйвера
Для работы с ККТ Штрих необходимо установить драйвера ККМ от компании ШТРИХ-М версии 5.Х, которые можно скачать по ссылке: [http://www.shtrih-m.ru/support/download](https://www.shtrih-m.ru/support/download/?section_id=471&product_id=all&type_id=156&searchDownloads=).

Актуальная версия драйверов Штрих на 05.12.2024 - 5.17.0.989.
У производителя ККТ присутсвует вариант 32х-разрядного драйвера и 64х-разрядного. Нужно выбрать 32x разрядный драйвер.

![2024-11-10_20-37-18.png](/images/integrations/kktshtrih/2024-11-10_20-37-18.png){.align-center}

Установить драйвера Штрих со стандартными параметрами, нажимая далее в процессе установки. 

![](/images/integrations/kktshtrih/2024-11-10_20-38-57.png){.align-center}

![](/images/integrations/kktshtrih/2024-11-10_20-39-46.png){.align-center}

По окончании установки драйвера Штрих, установить и настроить связь ККМ с ОФД. Настройку связи с ОФД можно произвести по [инструкции](https://teletype.in/@shtrih-support/ofd).

# Настройка торгового оборудования в Айтиде
Подключение оборудования в Айтиде осуществляется через справочник торгового оборудования, который можно открыть через пункт меню Параметры - Торговое оборудование. В справочнике необходимо создать новую карточку оборудования по следующему шаблону.

![2024-12-05_11-42-14.png](/images/integrations/kktshtrih/2024-12-05_11-42-14.png){.align-center}

**Наименование** - указать произвольное название оборудования
**Тип оборудования** - выбрать "Фискальный регистратор"
**Профиль** - выбрать профиль для работы из следующего списка:
 - **Библиотека ФР. Профиль ФР Штрих (ФН, ФФД 1.05, ДККТ 4.Х-5.Х)** - для работы с ККТ Штрих по формату фискальных данных 1.05.
 - **Библиотека ФР. Профиль ФР Штрих (ФН, ФФД 1.2, ДККТ 5.Х)** - для работы с ККТ Штрих по формату фискальных данных 1.2.
 
**Отсоединяться от устройства после окончания операции** - установить или снять признак, в зависимости от того, требуется ли удерживать связь с ККТ после выполнения каждой операции с кассой (после каждого пробития чека).

Вкладка **Печать чека/ ФОД/ ПС** 

![2024-12-05_11-45-53.png](/images/integrations/kktshtrih/2024-12-05_11-45-53.png){.align-center}

**Использовать ФР для печати чеков платежной системы** - флаг используется только в МРП1 для определения на каком ФР печатать слипы платежной системы, если их подключено несколько, а направить печать всех сливов нужно на один ФР. При снятом флаге слипы печатаются на ФР, привязанных к тем же группам печати (кодам ФР), что и подключенная платежная система.
**Выполнять проверку КМ на этом ФР** - при работе с ККТ, зарегистрированной для работы с ФФД 1.2 установка флага активирует проверку кода маркировки через подключенную ККТ (проверка через ОИСМ). По результатам проверки будет выведено уведомление кассиру с выбором действия по разрешению пробития или отклонения сканируемого кода маркировки при отрицательном результате проверки. Если флаг не установлен, то для ККТ Штрих коды маркировки будут добавляться в чек без проверок, а ККТ сама будет формировать Запрос о КМ без возможности выбора действия по отклонению некорректных КМ. В чеке в таком случае будет напечатана буква \[М] для таких позиций без предварительной проверки.
**Номер платежной системы в драйвере** - параметр используется только в МРП1 и определяет номер логического устройства в драйвере платежных систем Атол (при использовании спец.профиля для ФР), на котором производить операцию оплаты по банковской карте. Для МРП2 (РМК) не используется, т.к. в МРП2 используется иной механизм подключения платежных систем.
**Система налогообложения** - указывается система налогообложения, которая будет передаваться в составе реквизитов чека. Если значение на выбрано, то в чеках будет использоваться значение из настроек ККТ по умолчанию.

# Подключение ККТ к модулю РМК

Для добавления созданной карточки оборудования к перечню оборудования рабочего места РМК необходимо в рабочей схеме РМК для нужного рабочего места добавить карточку ФР на вкладке **РМК/Кассиры** - **Оборудование**.

![2024-12-05_11-48-36.png](/images/integrations/kktshtrih/2024-12-05_11-48-36.png){.align-center}

После этого можно перейти в РМК, открыть параметры РМК и по кнопке **"Настройка оборудования"** перейти к списку подключенного к рабочему месту торгового оборудования.

![рм-настройка-оборудования.png](/images/integrations/kktatol/рм-настройка-оборудования.png)

Выбрать из списка карточку ФР и нажать на кнопку с тремя точками для вызова диалога настроек параметров связи.

![2024-12-05_11-51-02.png](/images/integrations/kktshtrih/2024-12-05_11-51-02.png){.align-center}

В открывшемся диалоге настроек необходимо заполнить параметры связи и параметры работы ККТ и сохранить их по кнопке **ОК**.

![2024-12-05_11-51-44.png](/images/integrations/kktshtrih/2024-12-05_11-51-44.png){.align-center}