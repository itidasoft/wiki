---
title: Основные сведения о справочниках
description: Руководство администратора
published: true
date: 2022-08-04T22:40:04.670Z
tags: справочники
editor: markdown
dateCreated: 2022-08-04T22:38:53.558Z
---

Справочники в системе Айтида используются для ввода, хранения и отображения информации об объектах учета.

Перед началом эксплуатации системы Айтида необходимо настроить не только параметры системы и пользователей, а также обязательные для работы справочники.

![2013-04-04_162334.png](/images/admin-guide/directories/main/ed8d5b2588d6ef4a3a566a2af1e17e3f.png)

Справочники можно заполнять в процессе работы с программой, тем не менее, некоторые из них целесообразно заполнить заранее. К основным справочникам относятся: **«Филиалы», «Фирмы», «Склады», «Денежные карманы», «Расчетные счета», «Банки», «Сотрудники**».

# Общие правила работы со справочниками

Справочники в программе следует заполнять в порядке следования реквизитов.

Структура справочников может содержать в себе папки, подпапки и элементы.

Структура определяется назначением справочника.

Реквизиты элемента справочника могут быть числами, строками, датами, признаками, флагами или ссылками на элементы других справочников.

Если пользователь не заполнил какие-либо обязательные реквизиты, в момент записи элемента программа выдаст сообщение с предупреждением.

Чтобы выполнить любое групповое действие с элементами справочника, предварительно необходимо отметить список в справочнике для дальнейшей обработки.

Чтобы создать новый элемент справочника необходимо нажать кнопку «Новая карточка» на панели инструментов справочника или клавишу <kbd>Insert</kbd> на клавиатуре.

Чтобы отметить весь список, необходимо нажать сочетание клавиш <kbd>Ctrl</kbd>+<kbd>A</kbd>.

Чтобы отметить диапазон списка, необходимо щелкнуть левой кнопкой мыши в начале диапазона и удерживая клавишу <kbd>Shift</kbd> щелкнуть мышью в конце диапазона.

Чтобы снять флаги, необходимо нажать сочетание клавиш <kbd>Ctrl</kbd>+<kbd>О</kbd>.

Отображение отдельных колонок в справочнике настраивается в точке зрения.

Чтобы изменить порядок следования колонок, надо захватить заголовок колонки левой кнопкой мыши и перенести ее влево или вправо.

Щелчок левой кнопкой мыши по заголовку колонки, когда курсор примет вид черной стрелки вниз, инициирует сортировку записей в этой колонке.

Щелчок правой кнопкой мыши по заголовку колонки, когда курсор примет вид черной стрелки вниз, инициирует вызов фильтра для ввода искомых значений.

У каждого справочника есть панель инструментов, состоящая из нескольких кнопок в зависимости от типа справочника.

Справка о сочетаниях клавиш для работы с помощью клавиатуры вызывается нажатием клавиш <kbd>Ctrl</kbd>+<kbd>F1</kbd> в открытом окне справочника.

Система Айтида поддерживает единообразие при заполнении всех справочников.

При правильном ведении учета сначала заполняются вспомогательные дополнительные справочники, данные из которых затем используются другими справочникам.

Настроить сочетания «Горячих клавиш» для большего удобства работы пользователя в системе Айтида можно в [Параметрах пользователя](/docs/admin-guide/settings#_Параметры_пользователя). Ниже приведены правила заполнения некоторых из справочников.

# Установка общих реквизитов {#установка-общих-реквизитов}

В системе Айтида решена проблема установки одинакового значения для одного или нескольких реквизитов для группы элементов справочников. Пользователю необязательно производить вручную настройку каждого элемента справочника, это можно реализовать несколькими кликами с помощью функционала **«Установки общих реквизитов»**.

Форма **«Установки общих реквизитов»** имеет два варианта взаимодействия. Первая - стандартная **«Установки общих реквизитов»**, с предопределенным набором полей общих реквизитов, вторая - **«Расширенной установки общих реквизитов»,** функционал для присваивания особых реквизитов для группы элементов справочника.

> **Примечание!** *Выбор группы элементов справочников можно осуществить с помощью кнопки мыши и клавиши* **Shift,** *выбрав первый элемент списка и зажав соответствующую клавишу, щелкнуть кнопкой мыши на последнем элементе справочника в списке. Так же можно вручную установить флаги напротив нужных элементов списка.*
{.is-info}


![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/fea53d9ece72c073e12e1a04d2b66909.png)

Вызов формы производится из панели инструментов справочников.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/018f19972db62cdba7d0fa5108249861.png)

В форме **«Установки общих реквизитов»** есть две вкладки предопределенного набора свойств, которые можно присвоить группе элементов справочников.

После выбора необходимых общих реквизитов следует нажать кнопку **«Выполнить»**, чтобы к выбранной группе элементов справочников присвоились новые реквизиты.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/576a35ca1c59feb81c4d40cb36eb2a8a.png)

В форме **«Расширенной установки общих реквизитов»** имеется возможность вывода дополнительных свойств для присваивания группе элементов справочников реквизитов, которые отсутствуют в стандартной форме**,** и в дальнейшем сохранить эти поля для быстрого доступа в форме **«Расширенной установки общих реквизитов».**

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/6b90d2c423e4b0d2d54b6186593a2763.png)

Кнопка **«Настройка»** открывает форму для настройки доступных к установке значений реквизитов. Добавление полей осуществляется при нажатии кнопки **«Добавить».** В появившемся списке необходимо отметить интересующие поля и нажать кнопку «Записать».

![Изображение выглядит как стол Автоматически созданное описание](/images/admin-guide/directories/main/b4f68b8ed2057cd165bfa174bcd33aee.png)

После окончания необходимо записать настройки и снова открыть форму **«Расширенной установки общих реквизитов».** В открывшейся форме будут выведены поля для ввода значений для выбранных ранее полей. При нажатии на кнопку **«Записать»** введенные значения будут присвоены реквизитам карточек справочника.

![](/images/admin-guide/directories/main/c624d48a542f23b8a27c6fba8d953dac.png)

После успешного выполнения операции появится соответствующее сообщение.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/6225f9037d8fe8a7c589be70a8fe1747.png)

# Работа с группами весов

Для ввода **PLU** у товаров необходимо в Справочнике ТМЦ вызвать опцию **«Работа с группами весов»**.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/a497823f513665b73d2a201bf7a2cb73.png)

Откроется окно **«Ввод PLU для товаров и весов»**. В левой части окна создаются группы весов, с перечнем весов в каждой группе. В правой, табличной части перечисляются товары, ассоциированные с определёнными весами, для каждого из которых необходимо сгенерировать **PLU**.

![](/images/admin-guide/directories/main/222fcb639b8ac83aa6bfe60563a7c36f.png)

Так же можно обновить данные по **PLU** пересчитав их для всех записей, путем нажатия кнопок из выпадающего списка: **«Очистить PLU у всего списка»** и **«Сгенерировать PLU для всех записей»**.

Для сохранения нажать кнопку **«Записать».**

![Изображение выглядит как стол Автоматически созданное описание](/images/admin-guide/directories/main/b6631a9cd17f28aada7dcb20d516663f.png)

# Настройка двух печатающих устройств и «Групп печати» для товаров

В системе Айтида имеется возможность реализовать печать определенного товара на один ФР и других - на другой. Для этого требуется создать **«Группы печати»** в фронт системе и присвоить каждой свой код, в дальнейшем, в соответствии с настройками фронт системы и системы Айтида, эти коды будут идентифицироваться под свою **«Группу печати»** у товара.

> **Внимание!** *Необходимо использовать* **«Профиль обмена (релиз 2.2)»***, которые доступны для на сайте* [*Itida.ru*](http://itida.ru/partners/download/index.php?sid=625).
{.is-warning}


1.  Загрузить в базу профиль «Обмен данными с Фронтол. WIN32 V2».<br>

    **Меню Параметры - Справочник профилей оборудования**

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/22ed84c98c2f7c45ae12b0a1f69d2fb0.png)

1.  В меню Параметры - Параметры пользователя снять флаг **«Использовать форму обмена 2.1»**.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/c662efe657f0c1f30caabb390eed0264.png)

1.  Меню **Параметры – Торговое оборудование,** в карточке торгового оборудования выбрать профиль из выпадающего списка.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/9fa3a4b75e68da2d9b56a22369211e2c.png)

1.  Таким образом, при запуске формы **«Обмен данными с оборудованием»** будет использоваться форма релиза 2.2.

![Изображение выглядит как текст Автоматически созданное описание](/images/admin-guide/directories/main/f3136bd6fe3ffe0193205b229131fa2e.png)

1.  В меню **Справочники – Товары**, в карточке ТМЦ открывается вкладка **«Дополнительно»**, где указываются группы печати для вывода на печать на нужное устройство.

![](/images/admin-guide/directories/main/bbf16940c8ed3186e8303be060b2cdb3.png)

> **Внимание!** *Если перечень товаров очень большой, то имеется возможность установить для группы товаров значение* **«Группы печати»** *в несколько кликов, используя функционал* **«Расширенная установка общих реквизитов»***. Подробнее об этом можно узнать в разделе* [*Установка общих реквизитов*](#установка-общих-реквизитов)*.*
{.is-warning}

