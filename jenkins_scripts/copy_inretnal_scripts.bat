@echo on
cd "%WORKSPACE%\jenkins_scripts_internal"
if ERRORLEVEL 1 exit 1
echo Y | XCOPY "*" "..\service_packs" /s /i
if ERRORLEVEL 1 exit 1
del ..\service_packs\.git
if ERRORLEVEL 1 exit 1
