---
title: Обёртка для 1С компонент
description: 
published: true
date: 2023-12-07T13:38:38.635Z
tags: 
editor: markdown
dateCreated: 2023-12-07T13:38:38.635Z
---

Добавлена функция
**СОЗДАТЬОБЁРТКУС|CREATESWRAPPER( ПутьИмяDLL[, ИмяФайлаЖурнала] )**;
Создает COM объект на основе загруженной DLL

У этого объекта есть несколько своих методов
1. ИДМетода( ИмяМетода ) - возвращает индекс метода в DLL, если такой есть и -1 если нет
2. ИДСвойства( ИмяСвойства ) - возвращает индекс свойства в DLL, если такой есть и -1 если нет
3. ЕстьМетод( ИмяМетода ) - возвращает истину, если метод с указанным именем есть в DLL 
4. Естьсвойство( ИмяСвойства ) - возвращает истину, если метод с указанным именем есть в DLL
5. ОписаниеМетода( ИДМетода ) - возвращает строку с описанием метода - Два имени метода и параметры, если они описаны в dll
6. ОписаниеСвойства( ИДСвойства ) - возвращает строку с описанием свойства - Два имени свойства, его тип и признаки только для чтения/только для записи
7. КоличествоМетодов( ) - Вовзращает количество методов
8. КоличествоСвойств( ) - Вовзращает количество свойств
9. Ошибка( ) - Логическое, возникла ли ошибка при последнем вызове метода/свойства
10. КодОшибки( ) - Число, 0 если нет ошибки, код ошибки если была
		DllNotFound			= -1,
		InterfaceNotFound	= -2,
		ComponentNotFound	= -3,
		NameNotFound		= -4,
		MethodNotFound		= -5,
		PropertyNotFound	= -6,
		PropertyReadOnly	= -7,
		PropertyWriteOnly	= -8,
		BadParamCount		= -9,
		OutOfMemory			= -10,
		InvalidArgs			= -11,
		Exception			= -12

11. ТекстОшибки( [КодОшибки] ) - Если не указан числовой параметр, то возвращает текст последней возникшей ошибки, если указан код ошибки, то возвращается текст, соответствующий коду
12. Описание( ) - Возвращает строку со списком всех методов и свойств dll


пример
```js
	sw= СОЗДАТЬОБЁРТКУС( "c:\trash\DKViki_1C8_2.0.0.2_Win32.dll" );
	описание= false;
	sw.ПолучитьОписание( @описание );


строка( sw.количествометодов( ) ) + " " + строка( sw.количествосвойств( ) ) + " " + 
sw.описаниеметода( 13 ) + " " + sw.описаниесвойства( 1 ) + " " + sw.текстошибки( -5 ) + " " +
описание
```