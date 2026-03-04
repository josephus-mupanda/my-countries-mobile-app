@echo off
echo ================================================
echo Running All Flutter Tests for Countries App
echo ================================================
echo.

REM Check if Flutter is available
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Flutter is not installed or not in PATH
    echo Please install Flutter and add it to your PATH
    pause
    exit /b 1
)

REM Clean previous coverage data
if exist coverage (
    echo Cleaning previous coverage data...
    rmdir /s /q coverage
    echo.
)

echo Running ALL Tests (unit, widget, helpers)...
echo -------------------------------------------
echo.

REM Run ALL tests at once with coverage
flutter test --coverage --test-randomize-ordering-seed=random
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Tests failed!
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================
echo All tests completed successfully!
echo ================================================
echo.
echo Coverage report generated at: coverage\lcov.info
echo.
echo To view line-by-line coverage, open coverage\lcov.info in a text editor.
echo.
echo For HTML coverage report on Windows:
echo 1. Install lcov via Chocolatey: choco install lcov
echo 2. Run: genhtml coverage\lcov.info -o coverage\html
echo 3. Open coverage\html\index.html in your browser
echo.
pause