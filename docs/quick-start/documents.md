---
title: Документы
description: 
published: true
date: 2022-09-22T15:11:57.302Z
tags: документы, приходная накладная, переоценка, кассовая смена, продажи через кассу, поступление
editor: markdown
dateCreated: 2022-04-03T22:41:26.522Z
---

Документы в ПП Айтида используются для ввода, хранения и отображения информации о совершаемых хозяйственных операциях, которые влекут за собой движение и изменение ресурсов и/или взаиморасчетов. При помощи документов организуется ввод информации, а также ее просмотр и, при необходимости, корректировка.

Ввод документов на примере оформления прихода товара на склад «Торговый зал» по накладной поставщика.

|     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
| Организация | ОАО “Лианозовский молочный комбинат" |     |     |     |     |     |
| ИНН | 5047040960 |     |     |     |     |     |
| **Расходная накладная № 5** |     |     |     |     |     |     |
| **от 29 января 2021 г** |     |     |     |     |     |     |
| Склад | На Севастопольской |     |     |     |     |     |
| **№ п.п.** | **Наименование** | **Ед. изм.** | **НДС** | **Цена** | **Кол-во** | **Сумма** |
| 1   | Молоко “Домик в деревне”, 3.2%, 1 л. | шт. | 18% | 15,00 | 1000 | 15000,00 |
| 2   | Кефир “Домик в деревне”, 3.2%, 1 л. | шт. | 18% | 17,00 | 500 | 8500,00 |
| 3   | …   |     |     |     |     |     |
| 4   | …   |     |     |     |     |     |
|     |     |     |     |     |     |     |
|     |     |     |     |     | Итого | 23500,00 |
| Принято ценностей на сумму: |     |     |     |     |     |     |
| _Двадцать три тысячи пятьсот рублей 00 коп._ |     |     |     |     |     |     |
|     |     |     |     |     |     |     |
| Принял | \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ | Сдал |     | \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |     |     |
|     | (подпись и ФИО) |     |     | (подпись и ФИО) |     |     |

# Приходная накладная

> **Внимание!** Процесс формирования приходных накладных, в случае получения данных из ЕГАИС, описан в [Айтида модуль ЕГАИС](/egais). 

 «Приходная накладная» является основным документом, с помощью которого осуществляется поступление товаров на склад. Это может быть как обычное поступление нового товара, так и ввод начальных остатков. 

**Меню - Документы - Приходные накладные**

## Вкладка «Основные реквизиты»

![](/images/quick-start/income-main.png)

-   **Кнопка Ф (фирма)** – позволяет выбрать организацию, от имени которой оформляется документ. Обычно, этот реквизит заполняется автоматически либо из настроек значений по умолчанию из точки зрения, либо из параметров пользователя.
-   **Контрагент** – в поле необходимо выбрать контрагента, от которого поступил товар. Контрагент может быть выбран несколькими способами:
    -   **Вводом части названия или ИНН в текстовое поле** – выбором из справочника контрагентов – кнопка справа от поля.
    -   **Сканером штриховых кодов**, если контрагенту присвоен штриховой код.
-   **Договор** – может быть указан договор с контрагентом. Система позволяет вести учет договоров с контрагентами. В договоре могут быть указаны товары и цены, которые могут быть проконтролированы при вводе приходной накладной.
-   **Склад** – необходимо указать склад, на который будет оприходован товар. Без указания склада документ не будет проведен.
-   **Без НДС** – признак предназначен для удобства заполнения документа. Если он установлен, то в документ нужно вводить цену и суммы ТМЦ и услуг без НДС. В момент записи система автоматически начислит НДС в соответствии с присвоенным в карточках списком налогов и снимет этот признак.

## Дополнительные реквизиты

![](/images/quick-start/income-extra.png)

-   **Срок оплаты** – указывается предполагаемый срок оплаты документа. На основании данных этого поля моет быть построен отчет «График платежей».
-   **Вид** – указывает вид поставки. Возможные значения:
    -   **Закупка** – основной вид поставки.
    -   **Бонус** – поставка осуществляется как бонус поставщика. Такие документы могут быть отдельно проанализированы в отчете по бонусам.
    -   **Прочее** – любые корректирующие документы.
    -   **Комиссия** – прием товаров на комиссию.

Выбор вида поставки может иметь существенное значение при учете партий товаров (см. «Окружения»).

-   **Тара в залог** – тара, принятая к учету на основании товаросопроводительных документов поставщиков, отмечается флагом в колонке «Тара» в приходных и расходных документах. Для учета стоимости тары в общей сумме документа в параметрах системы на закладке «Прочее» необходимо включить флаг «Сумма тары в том числе».
-   **Скидка** – позволяет указать общую скидку на документ и пересчитать закупочные цены.
-   **Распределить стоимость услуг по ТМЦ** – установка флага предписывает системе выделить в документе услуги, посчитать их сумму и при проведении распределить ее между товарами пропорционально их стоимости.
-   **Не учитывать стоимость услуг в сумме документа** – установка признака позволяет не учитывать стоимость услуг во взаиморасчетах с поставщиком. Например, когда поставщик товаров и транспортная компания — это разные фирмы и по ним ведется раздельный учет взаиморасчетов, тогда в приходной накладной на закладке на сумму стоимости услуг, можно создать документ «Акт услуг входящий».
-   **Кнопка «Дополнительно»** – позволяет указать номер и дату накладной поставщика, номер и дату счета-фактуры поставщика.
-   **Кнопка «Информация для ЕГАИС»** – позволяет просмотреть/задать параметры необходимые для обмена с ЕГАИС. Подробнее см. [Айтида модуль ЕГАИС.](/egais)

После заполнения реквизитов шапки документа можно нажать **«Записать»**, но отказаться от проведения документа.

## Заполнение спецификации документа.

Спецификация накладной может быть заполнена различными способами, также допустима любая их комбинация:

-   С использованием сканера штриховых кодов. На приеме товара отбираются образцы товаров, а затем оператор создает электронную накладную, сканируя отобранные образцы товаров.
-   С использованием терминала сбора данных. Менеджер на приеме товара сканирует полученные образцы товаров и вводит их количество в терминал. Удобнее использовать терминалы сбора данных, позволяющие загружать справочник товаров из информационной базы в терминал, что позволяет отследить наличие учетных карточек на товар, остатки и цены поставщика на этапе приемки товара.
-   Ручной ввод кодов/артикулов или штрих-кодов товаров. Ввод выполняется либо путем выбора товара из справочника, либо прямым вводом штрих-кода или кода/артикула товара.
-   Спецификация накладной может быть детализирована по характеристикам товаров.
-   Спецификация может быть скопирована из любого другого документа.
-   Спецификация может быть загружена из договора с контрагентом.

# Переоценка ТМЦ

После оформления прихода товара на склад, чаще всего необходимо назначить для этого товара цену продажи. Для нового товара заведомо необходимо определить цену продажи, потому что, в противном случае, система не даст провести «Приходную накладную». Для определения новой цены товара необходимо оформить документ **«Переоценка ТМЦ»**. 

Самый простой способ создать документа **«Переоценка ТМЦ»** из **«Приходной накладной»** – это нажать кнопку **«Сформировать переоценку»** в панели инструментов **«Приходной накладной»**. 

![](/images/quick-start/revaluation-fromincome.png)

При этом система отобразит окно, в котором позволит отметить необходимые для переоценки товары.

![](/images/quick-start/revaluation-prepare.png)

Система «выделяет» для переоценки розовым цветом товары, у которых отклонения новой цены от старой выходят за рамки заданного интервала, а также, если интервал не задан, выделяет цветом товары, у которых изменилась закупочная цена.

Необходимо проверить, что в поле «**Переоцениваемая цена»** выбрана правильная категория цены. Введя значение в поле **«Единый процент наценки»** можно предварительно рассчитать новую цену для всех товаров или только для тех, у которых не указан процент наценки в карточке товара. 

Для продолжения формирования переоценки необходимо отметить либо все, либо только необходимые, например выделенные розовым цветом, записи и нажать кнопку **«Продолжить»**.

Будет сформирован документ **«Переоценка ТМЦ»**.

> **Примечание!** Если в приходной накладной были указаны розничные цены в колонке Розничная цена, то документ Переоценка ТМЦ будет сформирован сразу, без захода в промежуточную форму**.**

## Основные реквизиты

![](/images/quick-start/revaluation-main.png)

-   **Категория цены —** из выпадающего списка выбирается категория цены для установки цен продажи. При формировании документа из другого документа, например, приходной накладной, это поле будет заполнено категорией цены из склада родительского документа.
-   **Флаг «Относительно старых цен реализации» —** позволяет произвести расчет новой цены относительно предыдущей.
-   **Флаг «Относительно** **цен закупки» —** позволяет произвести расчет новой цены относительно цены закупки товара. Вышеперечисленные флаги связаны с выпадающим списком «Увеличить/Уменьшить», числовым полем «на ... %» и кнопкой «Выполнить расчет с использованием алгоритма округления».
-   **Кнопка «Заполнить» —** заполняет спецификацию документа всеми товарами, у которых есть остаток.
-   **Кнопка «Пересчитать» —** в заполненном, но не проведенном документе в случае изменения остатков на складах позволяет сделать перерасчет, при проведении документа перерасчет производится автоматически.

## Дополнительные реквизиты

-   **Флаг «Акция» и заполненное поле «Срок окончание акции» —** позволяют контролировать последующие изменении цены на товар, участвующий в акции до установленной даты. При изменении цены система выдает предупреждение о том, что данный товар участвует в акции.
-   **Кнопка «Загрузить цены до акции» —** загружает цены по выбранным из списка условиям.

После того, как документ заполнен и проверен, его необходимо записать и провести. Затем можно провести ранее созданный документ **«Приходная накладная»**.

# Документ кассовой смены

Документ кассовой смены формируется автоматически в момент загрузки данных из ККМ. После того, как документы были загружены их необходимо провести. Для этого в журнале **«Документов кассовых смен»** необходимо открыть документ на корректировку или при нажатии правой кнопки мыши на документе можно выбрать из контактного меню пункт **«Провести»**.

![](/images/quick-start/cash-sales.png)

Не редко встречаются ситуации, когда на кассе пробивают не тот товар, который реально продается. В результате могут возникать пересортицы товаров, а документ кассовой смены не будет проводиться, ссылаясь на недостаток количества товара на складе. 

Для разрешения таких ситуаций в документе кассовая смена предусмотрена кнопка **«Проверить документ и сформировать недостающие документы»**. При ее нажатии система проверит необходимое для списания количество товара на складе и, в случае его нехватки, сформирует документ **«Пересортица ТМЦ»**, в котором добавит нужное количество на склад. 

Таким образом, информация о пересортице не будет утеряна, а будет зафиксирована в системе и появится возможность впоследствии разобраться в ситуации и принять необходимые меры.

Тот же механизм относится к продажам готовых блюд, перед проведением документа **«Кассовая смена»**, необходимо нажать кнопку **«Проверить документ и сформировать документ Выпуск и комплектация»**, таким образом, недостающее количество ингредиентов на складах будут перемещены автоматически.