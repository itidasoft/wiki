---
title: Подключение ККТ Атол к Айтиде
description: ККТ и ФР Атол
published: false
date: 2024-12-04T13:29:03.230Z
tags: атол, ккт, онлайн-касса, фискальный регистратор
editor: markdown
dateCreated: 2024-12-04T12:31:05.056Z
---

# Установка драйвера
Для работы с **ККТ Атол** необходимо установить комплект драйверов Атол, который можно скачать по ссылке http://fs.atol.ru/SitePages/Центр%20загрузки.aspx в разделе "Программное обеспечение" -> "ДТО" -> "10.х"

> Необходимо скачать 32х разрядную версию драйвер ККТ Атол версии 10.
{.is-info}

![2024-11-10_20-46-31.png](/images/integrations/kktatol/2024-11-10_20-46-31.png)

Если скачали не исполняемый файл установки, а полный архив драйвера, то необходимо распаковать скачанный архив и из каталога \\installer\\exe запустить установочный файл драйвера.

**Для 32х битной платформы устанавливать: KKT10-10.X.X.X-windows32-setup.exe**

## Атол. Служба удаленных подключений (удаленная связь с ККТ Атол средствами драйвера 10)

Для удаленного подключения к ККТ в комплекте драйвера 10 присутствует компонент **"Служба удаленных подключений"**, который позволяет использовать одну ККТ на нескольких рабочих местах. Этот вариант работает только тогда, когда на всех подключающихся к ККТ рабочих местах установлен драйвер версии 10, а на ПК с физическим подключением кассы установлен указанные компонент ("Служба удаленных подключений"). При необходимости использования такого функционала, необходимо при установке отметить соответствующий пункт.

![2024-11-10_19-51-00.png](/images/integrations/kktatol/2024-11-10_19-51-00.png)

# Настройка торгового оборудования в Айтиде
Подключение оборудования в Айтиде осуществляется через справочник торгового оборудования, который можно открыть через пункт меню Параметры - Торговое оборудование. В справочнике необходимо создать новую карточку оборудования по следующему шаблону.

![карточка-фр.png](/images/integrations/kktatol/карточка-фр.png)

**Наименование** - указать произвольное название оборудования
**Тип оборудования** - выбрать "Фискальный регистратор"
**Профиль** - выбрать профиль для работы из следующего списка:
 - **Библиотека ФР. Профиль ФР Атол (ФН, ФФД 1.05, ДТО 10)** - для работы с ККТ Атол по формату фискальных данных 1.05.
 - **Библиотека ФР. Профиль ФР Атол (ФН, ФФД 1.2, ДТО 10)** - для работы с ККТ Атол по формату фискальных данных 1.2.
 
**Отсоединяться от устройства после окончания операции** - установить или снять признак, в зависимости от того, требуется ли удерживать связь с ККТ после выполнения каждой операции с кассой (после каждого пробития чека). Для моделей касс, поддерживающих связь с ОФД только по протоколу **EthernetOverTransport** требуется установить флаг, т.к. иначе канал передачи будет закрываться после каждого чека и чеки не будут успевать передаваться в ОФД.

Вкладка **Печать чека/ ФОД/ ПС** 

![карточка-фр-2.png](/images/integrations/kktatol/карточка-фр-2.png)

**Использовать ФР для печати чеков платежной системы** - флаг используется только в МРП1 для определения на каком ФР печатать слипы платежной системы, если их подключено несколько, а направить печать всех сливов нужно на один ФР. При снятом флаге слипы печатаются на ФР, привязанных к тем же группам печати (кодам ФР), что и подключенная платежная система.