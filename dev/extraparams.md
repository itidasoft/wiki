---
title: Пример запроса параметров
description: 
published: true
date: 2024-06-18T09:52:47.774Z
tags: 
editor: markdown
dateCreated: 2024-06-18T09:37:51.047Z
---

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