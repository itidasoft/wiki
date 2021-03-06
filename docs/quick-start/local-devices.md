---
title: Локальное оборудование рабочего места
description: оборудование, подключенное к рабочему месту
published: true
date: 2022-04-03T11:54:43.406Z
tags: оборудование, рабочее место
editor: markdown
dateCreated: 2022-04-03T11:54:40.876Z
---

# Локальное оборудование рабочего места
Если на рабочем месте пользователя используется сканер штриховых кодов, терминал сбора данных, весы или фискальный регистратор, тогда необходимо заполнить параметры локального оборудования рабочего места.
В зависимости от того, какой тип оборудования настроен и подключен в локальном профайле заполняются и настраиваются соответствующие поля.
**Меню - Параметры – Локальное оборудование**

![local-devices.png](/images/quick-start/local-devices.png)

> **Примечание!** Для нормальной работы клавиатурного сканера его необходимо запрограммировать на генерацию префикса и суффикса (символов, которые будут автоматически добавляться к прочитанному штриховому коду в начале и в конце). Рекомендуется в качестве префикса использовать символ с кодом **0x7A** (он не встречается в самих штриховых кодах), а в качестве суффикса **0x0D** (возврат каретки).
{.is-success}


> **Внимание!** Параметры локального оборудования хранятся в файле на рабочем месте пользователя и привязаны не к пользователю системы а к его рабочему месту. Таким образом, все пользователи на одном рабочем месте могут использовать одно и тоже оборудование.
{.is-info}
