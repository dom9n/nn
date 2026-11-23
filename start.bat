@echo off
chcp 65001 >nul
title Сайт: localhost:8000
cd /d "%~dp0"

rem Ищем Python: сначала лаунчер py, потом python
set "PY="
py -3 --version >nul 2>&1 && set "PY=py -3"
if not defined PY (
    python --version >nul 2>&1 && set "PY=python"
)

if not defined PY (
    echo.
    echo  Python не найден.
    echo  Установи его с https://www.python.org/downloads/
    echo  и при установке отметь галочку "Add Python to PATH".
    echo  Потом запусти этот файл ещё раз.
    echo.
    start "" https://www.python.org/downloads/
    pause
    exit /b 1
)

echo.
echo  Сайт запущен:  http://localhost:8000
echo  Чтобы остановить — закрой это окно или нажми Ctrl+C.
echo.

rem Браузер открываем через 2 секунды, когда сервер уже поднимется
start "" cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:8000"

%PY% -m http.server 8000 --bind 127.0.0.1

echo.
echo  Сервер остановлен. Если выше ошибка про порт — порт 8000 занят,
echo  закрой другое окно с сервером и запусти снова.
pause
