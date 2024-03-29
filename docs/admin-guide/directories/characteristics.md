---
title: Справочник характеристик товаров
description: Руководство администратора
published: true
date: 2022-08-08T18:48:48.550Z
tags: разрезы, характеристики
editor: markdown
dateCreated: 2022-08-08T18:45:48.395Z
---

# Разрезы

В ПП Айтида реализована возможность работы с товарами в разрезе свойств, характеристик.

Товар можно классифицировать по характеристикам и свойствам, это дополнительная классификация товаров, более обобщенная, чем группа ресурсов товара. Для более детальной классификации можно использовать несколько видов характеристик и свойств, имеющих одну и ту же группу ресурсов.

![](/images/admin-guide/directories/characteristics/906b189410b89571a50b1dd191edd950.png)

## Создание карточки характеристики

Для работы с товарами в разрезе характеристик необходимо задать характеристики товаров.

**Меню Справочники – Классификаторы - Характеристики**

![2013-04-05_122732.png](/images/admin-guide/directories/characteristics/6fd26e5678944db55d5bdfdcc1ff8752.png)

Необходимо создать одну или несколько характеристик в справочнике и заполнить обязательные реквизиты.

![2013-04-05_122822.png](/images/admin-guide/directories/characteristics/25780880c9d8fe17004583470af56f8f.png)

**Код —** код карточки характеристики товаров в системе.

**Дополнительный код —** код характеристики из других баз данных.

**Наименование —** название характеристики. Например: вкус, высота, длина, размер, способ приготовления, цвет.

**Выпадающий список «Тип данных» —** становится доступным, если выбрать «Тип Данных» - Аналитика. Это позволяет установить флаги «Выбрать существующую аналитику» и «Создать новую аналитику». Позволяет выбрать способ хранения и обработки характеристики. Символьный (буквы), Число/Целое (целые числа), Число/Вещественное (дробные числа), Аналитика (ввод новых свойств товара). Например, Характеристика - Цвет: Красный, Синий, Зеленый, Черный и т. д.

**Выбрать существующий справочник —** можно выбрать аналитику из имеющихся типов аналитик, для этого нажмите кнопку «Выбрать тип аналитики».

**Создать новый справочник —** сначала требуется ввести название новой аналитики в поле Аналитика, а затем нажать кнопку «Сохранить» и создать новую аналитику

**Кнопка «Добавить в меню» —** позволяет добавить в меню вызов справочника, для ввода значений характеристик.

**Кнопка «Вызвать справочник» —** открывает справочник для выбранной характеристики, где можно добавить новое значение.

**Флаг «Выбирать через Combobox» —** позволяет выбирать конкретные значения характеристики из выпадающего списка. Если значение не стоит, то выбор доступен через кнопку.

## Присвоение характеристики группе ресурсов

Созданную характеристику можно добавить к товару, но только к тому, который относится к определенной группе товаров (**«Группе Ресурсов»**).

**Меню Справочники – Классификаторы – Группы ресурсов**

**![2013-04-05_125025.png](/images/admin-guide/directories/characteristics/968c4d50e03fa7157870a64d5626a30d.png)**

Добавить характеристику к карточке групп ресурсов можно на вкладке **«Дополнительные характеристики»,** подвкладка **«Характеристики»**. Для этого необходимо нажать кнопку **«Добавить характеристику»,** которая откроет справочник для выбора характеристики.

## Создание карточки товара с характеристикой

При создании Карточки ТМЦ необходимо выбрать группу ресурсов, в которой указаны характеристики для дальнейшего указания характеристик этого товара.

**Меню Справочники – Товары – Карточка ТМЦ**

**![](/images/admin-guide/directories/characteristics/c87c2890422163ff14fccd852374bd30.png)**

В Карточке ТМЦ на вкладке **«Цены, комплектация и дополнительная информация»** нажать кнопку **«Характеристики»**. В диалоговом окне **«Допустимые комбинации характеристик ресурса»** добавить новую характеристику, нажатием одноименной кнопки затем кнопку **«Записать»**.

**![2013-04-05_125405.png](/images/admin-guide/directories/characteristics/b3d620b0eb55509c18c97849fd27d35b.png)**

Карточка ТМЦ, имеющая характеристику, может быть открыта двойным щелчком, при этом все подчиненные элементы будут отображены списком. Таким же образом можно открыть подчиненный элемент Карточки ТМЦ с характеристикой.

> Для просмотра карточки подчиненного элемента необходимо выделить его в списке и нажать кнопку Просмотр
{.is-info}


**![](/images/admin-guide/directories/characteristics/0e650e2347adc50c51991a0c9124a254.png)**

# Настройка групп печати

> **Внимание!** *Необходимо использовать один из профилей обмена, которые доступны для скачивания на сайте Айтида по* [*ссылке*](http://itida.ru/partners/download/index.php?sid=625)*. Подробнее о загрузке профилей оборудования можно узнать в разделе* [*Использование профилей оборудования*](#_Использование_Профилей_обмена)*.*
{.is-warning}


Присвоить код группы печати товару или группе товаров.

**Меню Справочники – Карточка ТМЦ – Дополнительные свойства**

![](/images/admin-guide/directories/characteristics/0ad2d7e29f845dd40087d38f1f359244.png)

> **Примечание!** *Присвоить «***Код Группы Печати»** *сразу нескольким товарам можно с помощью кнопки на панели инструментов справочника ТМЦ* **«Расширенная установка общих реквизитов»***. Подробнее об этом можно узнать в разделе* [*Установка общих реквизитов*](/docs/admin-guide/directories/main#установка-общих-реквизитов)*.*
{.is-success}


![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/characteristics/55eee01505c21b7049aeb3944b1f0c62.png)

# Формирование документов из справочника.

В справочнике товаров предусмотрена возможность формирования документов по списку отмеченных товаров. Для этого необходимо отметить необходимые товары/папки и в кнопке «Создать документ со списком выбранных товаров» выбрать необходимый тип документа. Система создаст новый документ и заполнит его выбранными товарами.
