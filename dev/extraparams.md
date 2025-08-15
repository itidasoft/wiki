---
title: Пример запроса параметров
description: 
published: true
date: 2025-08-15T07:24:25.883Z
tags: 
editor: markdown
dateCreated: 2024-06-18T09:37:51.047Z
---

## Загрузка списков из интернета, маски ввода и клавиатура

Добавлена обработка конструкций вида
```js
				<Parameter Name="register_point" Caption="Точка регистрации" Description="Канал регистрации" TypeValue="String" Required= "True" >
				<href>
						{ 
							"href":"https://site-v2.apipb.ru/cashbox-list", 
							"headers":
							[
								{"header":"Authorization", "value":"_PBTOKEN"}, 
							   	{"header":"Content-type", "value":"\"application/json\""}
							], "type":"post", "body":"'{\"cashier_name\": \"Иван Иванов\"}'", "data":"list", "code":"id", "name":"name" 
						}
				</href>
</Parameter>
```

т.е. с запросом списка из интернета

```js
<check_script>
								ДЛИНА( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( phone, '(', '' ), ')', '' ), '-', '' ) ) >= 9;
</check_script>
```

```js
InputMask="+7(000)000-00-00" Required= "True"
```
маска ввода и признак обязательности



и общие скрипты инициализации и проверки
```js
		<init_script>/*СООБЩЕНИЕ( "Привет!" );*/</init_script>
		<valid_script>/*СООБЩЕНИЕ( "Пока!" );*/</valid_script>
```

Общий пример
[pbparams.txt](/images/dev/extparams/pbparams.txt)
[eapi_full.sql](/images/dev/extparams/eapi_full.sql)

может вызвать интерес функция проверки телефона и функционал запроса кода подтверждения


**Может быть параметр**
```
<Settings virtualkbd= "true">
```
**тогда будет в окне запроса экранная клавиатура**

Установка ширины клавитуры через `virtualkbd_width`

```
<Settings virtualkbd="true" virtualkbd_width="750">
```

## Дополнение с релиза 4.7.3

В описание параметров добавлены атрибуты:
1. **ResetList** - список полей через запятую, которые будут повторно инициализированы при изменении значения поля. Например, после изменения токена авторизации нужно будет перезаполнить список чего-то. В токене нужно будет в этом атрибуте указать имя перезаполняемого поля. Так же, возможно что будет изменено значение перезаполняемых полей на значение выражения, DefaultValue. В этом выражении (теперь это может быть и тэг, а не только атрибут) можно проанализировать нужные значения и вернуть то что надо.
2. **CheckList** - список через запятую имен полей, для которых нужно будет вызвать проверку после изменения значения поля.

Пример:
```xml
        <Parameter Name="phone" Caption="Телефон" Description="Телефон" ResetList= "gender" CheckList= "gender" TypeValue="String" ReadOnly="True" InputMask="+7(000)000-00-00" Required= "True">
          <check_script>
              ДЛИНА( ЗАМЕНИТЬ( ЗАМЕНИТЬ( ЗАМЕНИТЬ( phone, ''('', '''' ), '')'', '''' ), ''-'', '''' ) ) >= 9;
          </check_script>
        </Parameter>
```