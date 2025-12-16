@echo off
REM Backup DESIGN_PORTFOLIO_FINAL to external backups folder, excluding any 'psyche' folders

set SOURCE="%~dp0"
set DEST="C:\Users\beauwhitman\backups\DESIGN_PORTFOLIO_FINAL_backup_%DATE:/=-%_%TIME::=-%"

REM Create destination folder
mkdir %DEST%

REM Use robocopy to copy all files, excluding 'psyche' folders
robocopy %SOURCE% %DEST% /E /XD psyche /XF backup_project.bat

REM Done
ECHO Backup complete! Files copied to %DEST%
PAUSE
./backup_project.sh
