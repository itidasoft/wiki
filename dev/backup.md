---
title: Резервное копирование базы Айтида
description: 
published: true
date: 2024-08-20T18:24:10.617Z
tags: 
editor: markdown
dateCreated: 2024-08-20T18:24:10.617Z
---

# Автоматическое резервное копирование базы Айтида

Для выполнения резервного копирования будет использоваться скрипт Powershell

## Текст скрипта

```powershell
# Установка параметров
$databaseName = "ItidaRetail"	# имя базы данных
$backupDir = "E:\BackUp\itida"  # Каталог для хранения резервных копий
$backupRetentionDays = 14  # Количество дней для хранения резервных копий
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$backupFile = "$backupDir\$databaseName-$timestamp.bak"
$zipFile = "$backupDir\$databaseName-$timestamp.zip"
$logFile = "$backupDir\BackupLog.txt"

# Параметры подключения к SQL Server
$sqlServer = "localhost"
$sqlUser = "sa"
$sqlPassword = "Itida2017"

# Функция записи в лог
function Write-Log {
    param (
        [string]$message
    )
    $logMessage = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - $message"
    Add-Content -Path $logFile -Value $logMessage
}

# Создание каталога для резервных копий, если он не существует
if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir
    Write-Log "Создан каталог для резервных копий: $backupDir"
}

try {
    # Команда для резервного копирования базы данных
    $backupCommand = "
    BACKUP DATABASE [$databaseName] TO DISK = N'$backupFile'
    WITH NOFORMAT, NOINIT, NAME = N'$databaseName-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
    "

    # Выполнение команды резервного копирования через sqlcmd с логином и паролем
    sqlcmd -S $sqlServer -U $sqlUser -P $sqlPassword -Q $backupCommand
    Write-Log "Резервное копирование базы данных '$databaseName' успешно выполнено: $backupFile"

    # Упаковка резервной копии в архив
    Add-Type -AssemblyName "System.IO.Compression.FileSystem"
    
    # Создание архива
    $zipStream = [System.IO.File]::Create($zipFile)
    $zipArchive = New-Object System.IO.Compression.ZipArchive($zipStream, [System.IO.Compression.ZipArchiveMode]::Create)
    
    # Добавление файла резервной копии в архив
    $entry = $zipArchive.CreateEntry([System.IO.Path]::GetFileName($backupFile))
    $entryStream = $entry.Open()
    $backupFileStream = [System.IO.File]::OpenRead($backupFile)
    $backupFileStream.CopyTo($entryStream)
    $entryStream.Close()
    $backupFileStream.Close()
    
    # Закрытие архива
    $zipArchive.Dispose()
    $zipStream.Close()
    
    Write-Log "Резервная копия упакована в архив: $zipFile"

    # Удаление исходного файла резервной копии после упаковки
    Remove-Item $backupFile -Force
    Write-Log "Исходный файл резервной копии удален: $backupFile"

    # Удаление старых резервных копий
    Get-ChildItem -Path $backupDir -Filter "*.zip" | Where-Object { 
        $_.CreationTime -lt (Get-Date).AddDays(-$backupRetentionDays) -and 
        $_.Name -like "*$databaseName*" 
    } | ForEach-Object {
        Write-Log "Удаление старой резервной копии: $_.FullName"
        Remove-Item $_.FullName
    }

    Write-Log "Резервное копирование завершено успешно!"
} catch {
    Write-Log "Ошибка во время резервного копирования: $_"
    throw
}

```