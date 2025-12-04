@echo off

REM ============================================================
REM  Java 25 READY launcher for JSystem Runner
REM  Includes JAXB 4.x support + DEBUG MODE ENABLED
REM ============================================================

set current_dir=%~dp0
set current_drive=%~d0

%current_drive%
cd %current_dir%

set _JAVACMD=java.exe
if exist "%JAVA_HOME%\bin\java.exe" set _JAVACMD=%JAVA_HOME%\bin\java.exe

REM ------------------------------------------------------------
REM  CLASSPATH: JSystem Launcher + JAXB 4.x (manual for Java 25)
REM ------------------------------------------------------------
set JSYSTEM_USED_CLASSPATH=%current_dir%/lib/jsystem-launcher.jar

REM Add JAXB 4.x JARs
set JSYSTEM_USED_CLASSPATH=%JSYSTEM_USED_CLASSPATH%;%current_dir%/thirdparty/lib/jakarta.xml.bind-api-4.0.2.jar
set JSYSTEM_USED_CLASSPATH=%JSYSTEM_USED_CLASSPATH%;%current_dir%/thirdparty/lib/jaxb-core-4.0.4.jar
set JSYSTEM_USED_CLASSPATH=%JSYSTEM_USED_CLASSPATH%;%current_dir%/thirdparty/lib/jaxb-runtime-4.0.4.jar
set JSYSTEM_USED_CLASSPATH=%JSYSTEM_USED_CLASSPATH%;%current_dir%/thirdparty/lib/jakarta.activation-api-2.1.3.jar

REM Include customer JARs if defined
if not "%JSYSTEM_CUSTOMER_JARS%" == "" set JSYSTEM_USED_CLASSPATH=%JSYSTEM_USED_CLASSPATH%;%JSYSTEM_CUSTOMER_JARS%

REM ------------------------------------------------------------
REM DEBUG MODE - ENABLED
REM You can connect a debugger on port 8787
REM ------------------------------------------------------------
set DEBUG=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8787

REM ------------------------------------------------------------
REM RUN JSystem (Java 25 compatible)
REM ------------------------------------------------------------
"%_JAVACMD%" %DEBUG% -Xms32M -Xmx256M ^
-Djsystem.main=%JSYSTEM_MAIN% ^
-DentityExpansionLimit=1280000 ^
-classpath "%JSYSTEM_USED_CLASSPATH%" ^
jsystem.framework.launcher.Launcher2 %1 %2 %3 %4 %5 %6 %7

if %ERRORLEVEL% == 6 goto launch

pause
