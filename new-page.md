---
title: Untitled Page
description: 
published: true
date: 2025-04-22T10:54:56.420Z
tags: 
editor: markdown
dateCreated: 2025-04-22T10:54:56.420Z
---

# Header
Your content here
```mermaid
---
config:
  theme: default
  look: neo
  layout: dagre
---
flowchart TD
 subgraph s1["Интерфейс"]
        Java["Java Application Interface"]
        VFP["Visual FoxPro Interface"]
  end
 subgraph subGraph1["Слой вычислений"]
        CPP["C++ Computation Engine"]
  end
 subgraph subGraph2["Слой данных"]
        TSQL["T-SQL Database"]
  end
    Java --> CPP
    VFP --> CPP
    CPP --> TSQL
```