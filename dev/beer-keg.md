---
title: Работа с разливной пивной продукцией
description: 
published: true
date: 2023-12-08T12:41:06.537Z
tags: 
editor: markdown
dateCreated: 2023-12-07T13:58:29.983Z
---

Айтида: Работа с разливной пивной продукцией.

# Введение

В соответствии с [Постановлением Правительства РФ № 2173](https://xn--80ajghhoc2aj1c8b.xn--p1ai/upload/%D0%9F%D0%BE%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%9F%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%B0%20%E2%84%962173.pdf) от 30.11.2022 с 15 января 2024 года розничным магазинам, HoReCa и другим предприятиям торгующим разливным пивом и слабоалкогольными напитками из кег нужно:

-   Не позднее следующего рабочего дня передавать в систему маркировки «Честный знак» сведения о подключении каждого кега к оборудованию для розлива;
-   При розничной реализации пива и слабоалкогольных напитков из кег в розлив необходимо передавать в систему маркировки сведения о частичном выбытии из оборота с использованием онлайн-касс.

# Штрафы за нарушения правил работы с маркированной продукцией

В соответствии со статьей 15.12 Кодекса РФ об административных правонарушениях за отсутствие регистрации в системе маркировки в установленные сроки, а также за нарушение работы с товаром, подлежащим маркировке, предусмотрена административная и уголовная ответственность.

На должностных лиц: от 1 000 до 10 000 рублей

На юридических лиц: от 50 000 до 300 000 рублей

Полная информация размещена на сайте честныйзнак.рф/penalties/

# Требования к РМК при работе с пивными кегами с целью отражения операции «Постановка на кран»

- Предоставлять простой и удобный интерфейс привязки разливной пивной продукции из справочника товаров и кода маркировки к оборудованию для розлива (далее кранам). Сами краны могут предварительно формироваться в отдельном справочнике в товароучетном приложении. При формировании «Постановки на кран»
- При постановке на кран запрашивать:
	1. КМ кега
	2. Объем кега (можно брать из карточки или запрашивать и значение по умолчанию выводить из карточки товара, выбранной для привязки)
	3. Срок годности (датой)
  
- Не позволять привязывать к одному крану более одного товара c КМ
- Разрешать подключать одинаковые карточки разливного пива к разным кранам (несколько кег одинакового пива)
- Если при формировании «Постановка на кран» в справочнике нет ни одного крана или ко всем кранам уже подключены кеги, то выдавать сообщение «Нет свободных кранов для подключения».
- Позволять формировать операцию «Снятие с крана» кассиром. При снятии с крана этот кран становится доступным(свободным) для новой Постановки на кран. Возможно так же снятие с крана не полностью распроданной кеги. Отдельных документов снятия с крана формировать не требуется, но для истории действий будет полезно отражать такую операцию (или записывать дату снятия в документ постановки на кран).
- Контролировать, чтобы объем проданного количества в порциях не превышал объем кеги. Для того чтобы не забывали снимать с крана и подключать новую кегу с новым КМ.
- Дополнительно (когда будет iMark) - нужно будет добавить проверку статуса КМ в iMark и уведомлять или предупреждать о статусе КМ после сканированием и перед привязкой к крану. Возможные ситуации при проверке в iMark: 
	1. КМ числится в статусе «Выбыл», 
	2. КМ не зарегистрирован в iMark, 
	3. Объем продукции в ЧЗ отличается от указанного в карточке товара. По данным ответа от iMark может быть принято автоматическое действие по блокировке постановки на кран. Так же через iMark можно будет получать объем продукции (возвращает метод codes/check), если в карточке заполнили некорректное значение или вовсе незаполнили и фиксировать правильное количество в операции постановки на кран
- Печатать на ККТ нефискальный документ с данными о постановке на кран и снятии с крана:

    1. имя пользователя
    2. название документа
    3. номер смены
    4. дата и время операции
    5. наименование товара
    6. код маркировки
    7. номер крана
    8. литраж кеги
    
# Требования к товароучетной программе Айтида

- Не позднее следующего рабочего дня передавать в систему маркировки «Честный знак» сведения о подключении каждого кега к оборудованию для розлива;

> Поскольку "Подключение к крану" будем получать не только из РМК, но и из Фронтолов (6 и xPOS3), то нужно уметь отправлять такой документ универсальным способом для всех Фронт-офисных решений. 
> Из-за ограничения времени на отправку постановки на кран (не позднее следующего для, т.е. сутки с момента постановки) нужно уметь отправлять постановки автоматическим заданием.
{.is-info}


## Условия подачи сведений о подключении кега
- КИ в статусе "В обороте" или "Выбыл"
- Тип упаковки "Единица товара"
- в карточке товара в «Национальном каталоге» в атрибуте "Характеристика упаковки" указано значение "КЕГ", состояние такой карточки "Готова к вводу в оборот";
- Заводской срок годности КМ больше, чем дата подключения кега к оборудованию для розлива
- ИНН и место осуществления деятельности отправителя не заблокированы в ЕГАИС.

## Реквизиты документа подключения кега для отправки в Честный знак
> Требуется наличие ЭЦП на рабочем месте, с которого будет происходить отправка сведений в честный знак.
{.is-warning}

**Для документа "Подключение кега к оборудованию для розлива" передаются:**
- ИНН участника оборота товаров, формирующего документ
- КПП торговой точки (Обязательно заполнен для юридических лиц. Строго не заполнен для индивидуальных предпринимателей )
- Идентификатор ФИАС (Обязательно заполнен для индивидуальных предпринимателей. Строго не заполнен для юридических лиц )

**Далее в документе перечисляется перечень подключенных кег**.
**Для каждого кега указывается:**
- КИ 
- Дата подключения кега к оборудованию для розлива
- Дата истечения срока годности. В параметре указывается дата предельного срока реализации продукции в кеге после его подключения к оборудованию. Диапазон допустимых значений: больше даты, указанной в параметре «connectDate» («Дата подключения кега к оборудованию для розлива»)


**После успешной обработки документа:**
- КИ присваивается особое состояние «CONNECT_TAP» («Подключён к оборудованию для розлива») — КИ с таким состоянием недоступен для агрегации и движения (перемещения);
- владельцем КИ становится отправитель документа, если в документе был указан КИ, принадлежащий не отправителю документа;
- агрегат расформировывается (без смены владельца), если в документе указан вложенный в агрегат КИ;
- для КИ сохраняются идентификатор текущего места осуществления деятельности, дата установки кега на кран, дата истечения срока годности, указанные в документе.

# Требования к РМК при розничной реализации разливного пива

-   При продаже разливного пива, если для данной продукции была сформирована операция постановки на кран, то устанавливать КМ для позиции из данных постановки на кран.
-   Если пиво было привязано к нескольким кранам, то запрашивать выбор крана из списка, из которого будет получен КМ и происходить розлив пива.
-   Производить стандартную проверку КМ через ККТ.
-   Дополнительно (когда будет iMark) – проверять КМ через iMark до проверки через ККТ.
-   Дополнительно (в профилях) проверять параметры регистрации ККТ и что при регистрации позиции с типом «Разливное пиво» используется ККТ с ФФД 1.2 (Исключение ошибок при розничном выбытии через чек).