CHCP 1251 > nul
rem ---Создаем папку---
set backupfolder=c:\backup\upload\%DATE%\
mkdir %backupfolder%
rem ---Останавливаем Oracle---
c:\oracle\ora92\bin\sqlplus.exe /nolog "@c:\Admin\shutdown_gas.sql"
rem ---Копируем БД Oracle---
copy C:\ORACLE\ORADATA\GAS\*.* %backupfolder%
copy C:\oracle\ora92\database\pwdgas.ora %backupfolder%
copy C:\oracle\ora92\database\spfilegas.ora %backupfolder%
rem ---Запускаем Oracle перезапускаем apache---
c:\oracle\ora92\bin\sqlplus.exe /nolog "@c:\Admin\startup_gas.sql"
C:\Pravosudie\BSR\Apache\bin\Apache.exe -w -n "BSR_Apache" -k stop
C:\Pravosudie\BSR\Apache\bin\Apache.exe -w -n "BSR_Apache" -k start
C:\Pravosudie\sdp\Apache\bin\Apache.exe -w -n "ISSApache" -k stop
C:\Pravosudie\sdp\Apache\bin\Apache.exe -w -n "ISSApache" -k start
rem ---Копия СДП---
copy C:\DATA\JUSTICE\*.* %backupfolder%
rem ---Копия судимость---
copy c:\Voskhod\Судимость-2008\CONVICTION.GDB %backupfolder%
rem ---Архивируем папку---
"c:\Program Files\7-Zip\7z.exe" a c:\backup\upload\%date%.zip %backupfolder%
rem ---Подчищаем за собой---
RD /s /q %backupfolder%
rem ---Загружаем на FTP---
start c:\Admin\WinSCP-5.17.7-Portable\WinSCP.exe /console /log=ftp.log /script=c:\Admin\uploadftp.txt