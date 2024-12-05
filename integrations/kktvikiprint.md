---
title: Подключение ККТ Вики Принт к Айтиде
description: ККТ Вики Принт от Дримкас
published: false
date: 2024-12-05T11:25:46.859Z
tags: ккт, онлайн-касса, фискальный регистратор, вики принт, дримкас
editor: markdown
dateCreated: 2024-12-04T12:34:59.956Z
---

# Установка драйвера
Для работы с **ККТ Вики Принт** необходимо установить VikiDriver.
VikiDriver это драйвер для работы Вики Принт 57Ф, Вики Принт 57Ф Плюс, Вики Принт 80 и Пирит 2Ф. Используется для автоматического и ручного подключения кассы по USB, COM и TCP/IP и для работы по API.

> **Минимальные требования**
> 32 или 64-битная версия Windows 7 с пакетом обновления (SP 1)
{.is-info}

Перейдите по ссылке: [https://help.dreamkas.ru/kb/zagruzki/](https://help.dreamkas.ru/kb/zagruzki/viki-print-57-f-viki-print-57-plyus-f-viki-print-80-plyus-f-/) и скачайте дистрибутив с той версией VikiDriver, которая подходит для вашей операционной системы.

Подключите Вики Принт к компьютеру.

> **Информация**
> Если вы ранее использовали Вики Принт вместе с службой ComProxy, то удалите её [по инструкции](https://help.dreamkas.ru/kb/viki-printy/obsluzhivanie-kassy-viki-print/udalit-sluzhbu-comproxy/?sphrase_id=25615)
{.is-success}

Запустите файл и нажмите кнопку **«Далее»** → Следуйте подсказкам установщика пока не начнётся установка компонентов.

![6ovx3jya9e2e2sng6eyfh5g3gyte0de2.png](/images/integrations/kktvikiprint/6ovx3jya9e2e2sng6eyfh5g3gyte0de2.png){.align-center}

Нажмите **«Завершить»**

VikiDriver установлен. Он запустится как служба Windows, иконка отобразится в системном трее.

# Подключение Вики Принт к Viki Driver
Viki Driver при запуске сканирует сеть и сам находит все доступные Вики Принты, но есть возможность найти кассу вручную.
При запуске Viki Driver выберите **Подключить ККТ вручную**

![1fbc2cmkhctjvwe6vzduor2wtsar3hoh.png](/images/integrations/kktvikiprint/1fbc2cmkhctjvwe6vzduor2wtsar3hoh.png){.align-center}

В зависимости от того как вы хотите подключить Вики принт выберите тип подключения:

**Если по СOM-порту**, то выберите способ подключения "**СОМ-порт**", а затем нужный вам порт, например, СОМ-10 → Нажмите кнопку **Подключить**.

![lbx9d236pxceze4320bnfr8zqk7doz7b.png](/images/integrations/kktvikiprint/lbx9d236pxceze4320bnfr8zqk7doz7b.png){.align-center}

**Если по TCP/IP** (доступно для Вики Принт с WI-Fi модулем), то выберите способ подключения "**TCP/IP**" → Укажите IP-адрес Вики Принт → Нажмите кнопку **Подключить**.

Присутствует так же способ поиска ККТ по mDNS (доступно для Вики Принт с WI-Fi модулем).
Если у вас в одной сети работает несколько Вики Принтов, то включите тумблер "**Поиск ККТ по сети**".

![cmi8a33gpeap8i1jedwjccxjf3d8d884.jpg](/images/integrations/kktvikiprint/cmi8a33gpeap8i1jedwjccxjf3d8d884.jpg){.align-center}

Viki Driver найдет все, которые есть и выведет список устройств

![gv3vv9cd8jablxe733tajw0vwhe6vw25.png](/images/integrations/kktvikiprint/gv3vv9cd8jablxe733tajw0vwhe6vw25.png){.align-center}