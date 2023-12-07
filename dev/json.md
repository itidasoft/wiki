---
title: Работа с JSON
description: 
published: true
date: 2023-12-07T13:15:37.819Z
tags: 
editor: markdown
dateCreated: 2023-12-07T13:04:13.735Z
---

# СФОРМИРОВАТЬ_VJSON(СписокПеременных, Флаг)
Функция формирует объект JSON по списку переменных и возвращает в виде строки.
Параметры:
СписокПеременных - строка со списком переменных, разделенных пробелом или запятыми, по именам и значениям которых будет сформирован результирующий JSON
Флаг - значение 1 является признаком того, что значения переменных нужно записать "как есть", без дополнительных преобразований и экранирований. Полезно когда в значении переменной содержится сформированный оъект или массив JSON. 


Пример:
```js
extProductId	= 123;
name					= "Водка";
type					= "ALCOHOL";
unitId				= 777;
taxId					= 10;
extCategoryId	= 111;
sellPointId		= 999;

//реквизиты объекта alco
code					= "200";
isUnpacked		= true;
alco					= СФОРМИРОВАТЬ_VJSON("code isUnpacked");


//массив объектов items
price					= 500.00;
mbarcodes[0]	= "1234567890";
mbarcodes[1]	= "4567893210";
itemObject		= СФОРМИРОВАТЬ_VJSON("price mbarcodes");
itemsArray[0]	= itemObject;
items					= СФОРМИРОВАТЬ_VJSON("itemsArray", 1);

//собираем весь json
JSON_DATA			= СФОРМИРОВАТЬ_VJSON("extProductId name type unitId taxId extCategoryId sellPointId items|array alco|object");
СООБЩЕНИЕ( JSON_DATA, "JSON_DATA" );
```

Результат: 
![image_2023_08_16t17_51_12_837z.png](/images/dev/json/image_2023_08_16t17_51_12_837z.png)