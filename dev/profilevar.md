---
title: Переменные профилей оборудования
description: 
published: true
date: 2024-08-13T06:56:28.074Z
tags: 
editor: markdown
dateCreated: 2024-08-13T06:56:28.074Z
---

# Платежные системы

```c++
"code        =  '" + m_ps.code( ) + "';      "
"КОДОБОРУДОВАНИЯ  =  '" + m_ps.code( ) + "';      "
"devicenumber    =   " + m_ps.devicenumber( ) + ";  "
"НОМЕРУСТРОЙСТВА  =   " + m_ps.devicenumber( ) + ";  "
"comnumber      =   " + m_ps.comnumber( ) + ";    "
"НОМЕРПОРТА      =   " + m_ps.comnumber( ) + ";    "
"slipcopy      =   " + m_ps.slipcopy( ) + ";    "
"КОПИЙСЛИПА      =   " + m_ps.slipcopy( ) + ";    "
"storage      =  '" + m_ps.storage( ) + "';    "
"СКЛАД        =  '" + m_ps.storage( ) + "';    "
"moneybox      =  '" + m_ps.moneybox( ) + "';    "
"ДЕНЕЖНЫЙКАРМАН    =  '" + m_ps.moneybox( ) + "';    "
"firm        =  '" + m_ps.firm( ) + "';      "
"ФИРМА        =  '" + m_ps.firm( ) + "';      "
"frnumber      =  '" + Helpers::STDA( m_ps.frnumber( ), QChar( '\'' ) )  + "';    "
"НОМЕРФР      =  '" + Helpers::STDA( m_ps.frnumber( ), QChar( '\'' ) )  + "';    "
"frcode        =  '" + m_ps.freqcode( ) + "';    "
"ФРКОДОБОРУДОВАНИЯ  =  '" + m_ps.freqcode( ) + "';    "
"clientid      =  '" + Helpers::STDA( m_ps.clientid( ), QChar( '\'' ) ) + "';    "
"ИДКЛИЕНТА      =  '" + Helpers::STDA( m_ps.clientid( ), QChar( '\'' ) )  + "';    "
"bankid        =  '" + Helpers::STDA( m_ps.bankid( ), QChar( '\'' ) )  + "';    "
"ИДБАНКА      =  '" + Helpers::STDA( m_ps.bankid( ), QChar( '\'' ) )  + "';    "
"paymentcode    =  '" + Helpers::STDA( m_ps.paymentcode( ), QChar( '\'' ) )  + "';  "
"КОДВИДАОПЛАТЫ    =  '" + Helpers::STDA( m_ps.paymentcode( ), QChar( '\'' ) )  + "';  "
"paymenttype    =   " + QString::number( m_ps.paymenttype( ) ) + ";          "
"ВИДОПЛАТЫ      =   " + QString::number( m_ps.paymenttype( ) ) + ";          "
"ipaddress      =  '" + Helpers::STDA( m_ps.ipaddress( ), QChar( '\'' ) )  + "';  "
"IPАДРЕС      =  '" + Helpers::STDA( m_ps.ipaddress( ), QChar( '\'' ) )  + "';  "
"defaultps      =   " + QString( m_ps.isdefault( ) ? "true" : "false" ) + ";    "
"ОСНОВНАЯПС      =   " + QString( m_ps.isdefault( ) ? "true" : "false" ) + ";    ";
```