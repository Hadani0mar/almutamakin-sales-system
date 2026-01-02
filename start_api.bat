@echo off
chcp 65001 >nul
echo ========================================
echo   تشغيل API Server (C#)
echo ========================================
echo.

cd /d "%~dp0ApiServer"

echo [1/2] التحقق من .NET SDK...
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo خطأ: .NET SDK غير مثبت.
    echo يرجى تثبيته من: https://dotnet.microsoft.com/download
    pause
    exit /b 1
)

echo [2/2] تشغيل API Server...
echo.
echo API Server يعمل على: http://localhost:5000
echo اضغط Ctrl+C لإيقاف السيرفر
echo.

dotnet run

pause


