---
title: Справочник алгоритмов работы
description: Руководство администратора
published: true
date: 2022-08-09T19:12:50.925Z
tags: алгоритмы
editor: markdown
dateCreated: 2022-08-09T19:12:48.480Z
---

В справочнике алгоритмов можно описывать достаточно большие алгоритмы преобразуя их в набор последовательных шагов. При этом есть возможность для каждого шага алгоритма производить запрос дополнительных параметров у пользователя, а также выбирать следующий исполняемый шаг алгоритма в зависимости от указанных условий. Другими словами, эта возможность позволяет описывать работу произвольного мастера, который в пошаговом режиме сможет выполнять требуемые задачи, постоянно взаимодействуя с пользователем. Эта возможность реализована в виде справочника алгоритмов работы.

**Меню Сервис – Справочник алгоритмов работы в меню**

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/algorithm/a2c1ee9340c3c777f02e6ee6ca52e9de.png)

Алгоритм работы состоит из шагов, список которых отображается в дереве в левой части окна карточки. Для обеспечения более компактного отображения шаги можно объединять в группы. Группы шагов идентифицируются по названию. Для перемещения шага алгоритма в группу достаточно указать ее имя в поле «Группа».

Основным идентификатором шага является его номер. В то же время, у каждого шага есть имя, по которому к нему можно обращаться из других шагов или других алгоритмов. Условия перехода между шагами также используют имя шага для указания следующего шага.

Предусмотрена возможность задания текста справки, который будет доступен для пользователя. Текст справки будет выведен в окне запроса параметров к шагу алгоритма, поэтому, если у шага нет параметров, то текст справки не нужно задавать.

Кнопка **«Добавить в меню»** позволяет добавить пункт в любое доступное меню пользователя. Выполнение алгоритмов работы доступно во всех конфигурациях.

Параметры, передаваемые шагу алгоритма перед выполнением

**\_ДЕСКРИПТОРОКНА** — дескриптор окна запроса параметров (см. примечание).

**\_СООБЩЕНИЕПОКАЗАТЬИНДИКАТОР —** отправка этого сообщения окну параметров отобразит индикатор в нижней части окна. У данного сообщения должно быть 2 параметра:

1.  База индикатора (число, соответствующее полностью заполненному индикатору).
2.  Заголовок индикатора. Строка, которая будет отображена полужирным шрифтом над индикатором.

**\_СООБЩЕНИЕОБНОВИТЬИНДИКАТОР —** отправка этого сообщения окну параметров изменит состояние отображенного ранее индикатора. У данного сообщения должно быть 2 параметра:

1.  Значение индикатора (число, соответствующее текущему размеру индикатора).
2.  Подзаголовок индикатора. Строка, которая будет отображена как подзаголовок у индикатора.

**\_СООБЩЕНИЕУДАЛИТЬИНДИКАТОР —** отправка этого сообщения окну параметров удалит индикатор.

**\_СООБЩЕНИЕПОКАЗАТЬСООБЩЕНИЕ —** отправка этого сообщения окну параметров отобразит информационное окно для информирования пользователя о текущем состоянии исполнения алгоритма. У данного сообщения должен быть 1 параметр: Текст отображаемого сообщения.

**\_СООБЩЕНИЕУБРАТЬСООБЩЕНИЕ —** отправка этого сообщения окну параметров удалит информационное окно. Параметры, определенные для ввода пользователем (для данного шага) произвольные список параметров, значение которых было запрошено у пользователя.
