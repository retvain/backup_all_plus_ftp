CHCP 1251 > nul
rem ---������� �����---
set backupfolder=c:\backup\upload\%DATE%\
mkdir %backupfolder%
rem ---������������� Oracle---
c:\oracle\ora92\bin\sqlplus.exe /nolog "@c:\Admin\shutdown_gas.sql"
rem ---�������� �� Oracle---
copy C:\ORACLE\ORADATA\GAS\*.* %backupfolder%
copy C:\oracle\ora92\database\pwdgas.ora %backupfolder%
copy C:\oracle\ora92\database\spfilegas.ora %backupfolder%
rem ---��������� Oracle ������������� apache---
c:\oracle\ora92\bin\sqlplus.exe /nolog "@c:\Admin\startup_gas.sql"
C:\Pravosudie\BSR\Apache\bin\Apache.exe -w -n "BSR_Apache" -k stop
C:\Pravosudie\BSR\Apache\bin\Apache.exe -w -n "BSR_Apache" -k start
C:\Pravosudie\sdp\Apache\bin\Apache.exe -w -n "ISSApache" -k stop
C:\Pravosudie\sdp\Apache\bin\Apache.exe -w -n "ISSApache" -k start
rem ---����� ���---
copy C:\DATA\JUSTICE\*.* %backupfolder%
rem ---����� ���������---
copy c:\Voskhod\���������-2008\CONVICTION.GDB %backupfolder%
rem ---���������� �����---
"c:\Program Files\7-Zip\7z.exe" a c:\backup\upload\%date%.zip %backupfolder%
rem ---��������� �� �����---
RD /s /q %backupfolder%
rem ---��������� �� FTP---
start c:\Admin\WinSCP-5.17.7-Portable\WinSCP.exe /console /log=ftp.log /script=c:\Admin\uploadftp.txt