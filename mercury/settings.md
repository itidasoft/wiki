---
title: Настройка модуля Меркурий в Айтиде
description: Меркурий - настройка
published: true
date: 2025-07-01T07:08:26.391Z
tags: настройка, меркурий
editor: markdown
dateCreated: 2022-07-31T11:54:54.165Z
---

# Введение

С первого июля 2018 вступил в силу обязательный электронный документооборот с ГИС Меркурий. По этой причине, в систему Айтида был добавлен модуль, реализующий получение и гашение электронных сертификатов ГИС Меркурий.

# Предварительные настройки

## Подключение к системе Меркурий

Для регистрации в системе Меркурий и получения доступа необходимо предоставить в Территориальное Управление Россельхознадзора сведения об организации/ИП, сведения о местах осуществления деятельности (производство, переработка, хранение, реализация), сведения о пользователе организации/ИП, который будет работать в системе и, при необходимости, предоставлять доступ другим сотрудникам организации.

Перечисленные сведения необходимо оформить в виде заявки по следующим шаблонам:

1) Для ИП - [http://vetrf.ru/vetrf-docs/ru/sample/sampleMercuryIP.doc](http://vetrf.ru/vetrf-docs/ru/sample/sampleMercuryIP.doc%20)

2) Для Юридических лиц - [https://view.officeapps.live.com/op/view.aspx?src=http://vetrf.ru/vetrf-docs/ru/sample/sampleMercuryUL.doc](https://view.officeapps.live.com/op/view.aspx?src=http://vetrf.ru/vetrf-docs/ru/sample/sampleMercuryUL.doc%20)

Заявку необходимо отправить в Территориальное Управление Россельхознадзора [(http://www.fsvps.ru/fsvps/structure/terorgs](file:///D:\Техническое%20описание\ИНСТРУКЦИИ\(http:\www.fsvps.ru\fsvps\structure\terorgs)).

После обработки на указанный в заявке адрес электронной почты вы получите письмо с реквизитами доступа, после чего можно начинать работать с системой через веб-интерфейс.

>   Для работы с системой Меркурий через программный продукт «Айтида» необходимо получить доступ к Ветис.API.
{.is-info}


Доступ к Ветис.API предоставляется в 2 этапа: первый этап – подача заявки на предоставление доступа к тестовой версии Ветис.API для разработки и отладки, второй этап – подача заявки на предоставление доступа к продуктивной версии Ветис.API. [Подробнее по ссылке](http://help.vetrf.ru/wiki/Ветис.API#.D0.9F.D1.80.D0.B5.D0.B4.D0.BE.D1.81.D1.82.D0.B0.D0.B2.D0.BB.D0.B5.D0.BD.D0.B8.D0.B5_.D0.B4.D0.BE.D1.81.D1.82.D1.83.D0.BF.D0.B0).

**Для получения доступа к продуктивной версии шлюза** заявки подаются только при помощи публичной электронной формы, доступной по адресу <https://aplms.vetrf.ru/pub>.

На втором шаге подключения к продуктивному контуру необходимо выбрать вариант «**Регистрация новой клиентской системы».**

На третьем шаге в сведениях о подключаемой клиентской системе выбрать:

-   Тип: «Покупное решение»
-   Сведения о разработчике: ООО "Айтида" (ИНН: 3528315533; адрес: Россия, г. Череповец, ул. Раахе, д. 50, офис 3)
-   Название системы: Айтида

# Подключение и настройка модуля Меркурий

Для подключения модуля Меркурий необходимо добавить в систему меню программы пункт *Модуль Меркурий* (название пункта может быть изменено партнёром по его усмотрению). В дистрибутивной базе данный пункт расположен в меню Сервис. Для самостоятельного подключения этого пункта необходимо использовать команду *DO FORM mercuryform*.

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/978c86684c72738e8b4cc02d543bf16e.png)

Для отображения добавленного пункта в меню необходимо перезапустить систему Айтида. Так же, можно добавить пункт меню для вызова формы сопоставления товаров с продукцией ГИС Меркурий. Для этого необходимо использовать команду `DO FORM mercurysubst`*.*

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/cfc2ae365a0f9b8af5695339489f858f.png)

Для пункта меню, вызывающего форму сопоставления контрагентов с партнерами ГИС Меркурий необходимо использовать команду `DO FORM mercurysubstpartners`*.*

Первый запуск модуля необходимо произвести от имени пользователя с правами администратора. В этом случае будет доступен функционал по настройке модуля:

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/67c9ee05950f385b8b8f68833bce03b3.png)

Настройка модуля производится для каждой торговой точки, на которых предполагается обмен данными с ГИС Меркурий. В окне настройки можно указать следующие параметры:

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/774e7190865686b2869001398d30d597.png)

1.  Раздел **Загрузка данных из ГИС Меркурий** заполняется автоматически при установке обновления системы Айтида и содержит текст обработки, выполняющей необходимые функции по взаимодействию с ГИС Меркурий. Раздел доступен при запуске системы в режиме конфигурации при наличии NFR лицензии/сублицензии.
2.  Кнопки **Добавить предприятие в список, Изменить название предприятия в списке** и **Удалить предприятие из списка** позволяют формировать список предприятий, подчиненных хозяйствующим субъектам, возможно различным, для работы.
3.  Кнопка **Создать предприятие в ГИС Меркурий** позволяет создать новую площадку, используя API Меркурий. *Подробнее см. в разделе Создание предприятия в ГИС Меркурий.*
4.  Поля **Логин, пароль, APIKey ИД организации (ХС).** В этих полях необходимо указать параметры, полученные от регулятора после регистрации в Ветис.API.

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/6f380c5acf8710cea437d5109aa59fd4.png)

5.  В поле **ИД Предприятия** необходимо указать ИД ранее зарегистрированного предприятия. Значение можно выбрать из списка. Список можно обновить из ГИС Меркурий нажав кнопку **Запросить список из ГИС Меркурий**, расположенную правее поля ввода.
6.  В поле **Сотрудник** необходимо указать логин пользователя, зарегистрированного для доступа к ГИС Меркурий через WEB интерфейс.
7.  В разделе **Папки** **для создания новых объектов** необходимо выбрать папки справочников, в которых будут создаваться новые товары и контрагенты. Данные, загружаемые из ГИС Меркурий содержат в себе не только электронные сертификаты, но и реквизиты производителей, поставщиков товаров, а также названия самих товаров. При загрузке неопознанные контрагенты и товары будут созданы в указанных папках. При создании новых карточек товара будет учитываться, какая группа ресурсов указана в выбранной папке. В новые карточки будет перенесена информация заданная в группе ресурсов, так как если бы эта группа была выбрана в карточке товара интерактивным путем.

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/a0904e616fca46ceb1881b1a85942cbb.png)

1.  В разделе **Параметры создаваемых документов** необходимо выбрать **Организацию** и **Склад**, на которые будут создаваться приходные накладные. Если эти параметры не будут выбраны, то в процессе создания документов значения будут подставлены из настроек пользователя, осуществляющего операцию загрузки.
2.  Если установлен флаг **Сопоставлять товары после загрузки данных**, то в случае, если после загрузки данных добавились новые товары, которых еще нет в справочнике товаров Айтиды, будет выведено окно для осуществления сопоставления/создания карточек товаров с продукцией, пришедшей из ГИС Меркурий. Если флаг не установлен, тогда форма не будет выведена. В таком случае сопоставление можно будет выполнить позже, вызвав форму сопоставления из меню.
3.  Если установлен флаг **Загружать ВСД только из выбранного периода,** то при запросе эВСД будет добавлен фильтр на период, указанный в основной форме модуля Меркурий. Данная настройка позволяет ограничить количество принимаемых эВСД выбранным периодом.
4.  Если установлен флаг **Не выводить в список погашенные ВСД**, то погашенные эВСД не будут выводиться в список, даже, если приходные накладные по ним не созданы.
5.  Поле **Дата, с которой запрашивать остатки** позволяет указать дату, которая будет указана в качестве начальной даты периода при запросе действующих складских записей ГИС Меркурий, для текущего предприятия. В дальнейшем, при запросе остатков из ГИС Меркурий значение в этом поле будет автоматически обновляться. Но, возможность ручного изменения будет сохранена, для того чтобы была возможность запросить данные из более ранних периодов.

>   Журнал обмена с ГИС Меркурий записывается в файл, имя которого указано в константе \_**МЕРКУРИЙИМЯФАЙЛАЖУРНАЛА**. Если такой константы нет в системе, то по умолчанию используется имя файла **d:\\mercury_http.log**
{.is-info}


## Создание предприятия в ГИС Меркурий

В модуле Меркурий предусмотрена возможность создания в ГИС Меркурий нового предприятия. Это связано с тем, что web интерфейс ГИС не содержит необходимого функционала и клиентам приходится заполнять рукописные формы и передавать их в региональные отделения. Это долгий процесс. В то же время, API системы позволяет создать предприятие самостоятельно и очень быстро.

Для создания нового предприятия в окне параметров модуля Меркурий предусмотрена кнопка **Создать предприятие в ГИС Меркурий.** ![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/b5ae4e6a04bc61f24d0f0b40aad33c83.png)

При нажатии этой кнопки будет открыто окна с параметрами нового предприятия.

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/211811a708b9f93a3533ff9892755931.png)

На закладке **Предприятие** необходимо заполнить параметры доступа к API ГИС Меркурий, название нового предприятия, ИНН и КПП владельца. Так же, необходимо указать хотя бы один вид деятельности нового предприятия.

>   Если параметры доступа к API были заполнены ранее, то они будут перенесены в эту форму.
{.is-info}


На закладке **Адрес местоположения** необходимо указать адрес нового предприятия.

![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/0b9e9d71c7a3bd74df5ef9e02e6b353b.png)

Поля **Страна, Регион, Район, Населенный пункт, Населенный пункт 2, Улица** должны быть выбраны из справочника соответствующих объектов ГИС Меркурий. Для загрузки этих справочников предусмотрены кнопки ![](/images/mercury/settings/80a84205be0cc0c943ad41e85f8c8a68.png) правее полей ввода. В случае, если элемент не будет выбран из справочника, то ГИС Меркурий может вернуть отказ в регистрации предприятия.

После заполнения частей адреса необходимо нажать кнопку ![](/images/mercury/settings/80a84205be0cc0c943ad41e85f8c8a68.png) правее поля **Адрес**, для генерации адреса единой строкой.

После заполнения всех необходимых полей необходимо нажать кнопку **Отправить**.

При этом в ГИС Меркурий будет отправлен запрос на проверку наличия предприятия с указанным названием. Если такое будет найдено, то перед созданием будет предложено ознакомиться со списком и повторно подтвердить необходимость создания предприятия.

>   Запрос может занять некоторое время, обычно, не превышающее одной минуты.
{.is-info}


![Изображение выглядит как текст Автоматически созданное описание](/images/mercury/settings/8d4fe30efe5838301b9b27511d4fd9b3.png)

Если в списке нет создаваемого предприятия, то нажмите кнопку **Создать предприятие**. Предприятие будет создано в ГИС Меркурий.

После создания предприятия в параметрах модуля необходимо обновить список предприятий, нажав кнопку ![](/images/mercury/settings/80a84205be0cc0c943ad41e85f8c8a68.png) правее поля ввода **Предприятие**.
