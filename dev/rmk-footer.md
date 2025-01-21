---
title: РМК: расширенная настройка строк подвала
description: 
published: true
date: 2025-01-21T09:53:58.839Z
tags: 
editor: markdown
dateCreated: 2025-01-21T09:53:58.839Z
---

# Переопределение строк подвала
В скрипте инициализации интерфейса

```js
My_Footer = "{
    ""object_type"": ""footerlines"",
    ""lines"": 
  [
    {
      ""number"" : 1,
      ""height"" : 50,
      ""fields"" : ""total""
    },
    {
      ""number"" : 6,
      ""height"" : 32,
      ""fields"" : ""number,count""
    }
    ],
  ""fields"" : 
  [
    {
      ""name"": ""total"",
      ""label"": 
      {
        ""caption"": ""Набрали на"",
        ""swidth"": 30,
        ""width"": 30,
        ""forecolor"": ""#000000"",
        ""backcolor"": ""#AAAAFF"",
        ""font"": { ""name"":""Arial"", ""size"" : 30, ""bold"" : true },
        ""alignment"": ""centr""
      },
      ""value"": 
      {
        ""width"": 70,
        ""swidth"": 70,
        ""forecolor"": ""#FF0000"",
        ""backcolor"": ""#AABBFF"",
        ""font"": { ""name"":""Arial"", ""size"" : 30, ""bold"" : true, ""italic"" : false, ""underlined"" : false  },
        ""alignment"": ""centr""
      }
    }
  ]
}";
ОТПРАВИТЬСООБЩЕНИЕ( _ДЕСКРИПТОРОКНА, _СООБЩЕНИЕВЫПОЛНИТЬКОМАНДУ, "УСТАНОВИТЬПАРАМЕТРЫ", My_Footer );
```