@echo off
echo ================================================
echo Running Flutter Tests for Countries App
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

REM Run unit tests
echo Running Unit Tests...
echo ---------------------
flutter test test/unit --coverage
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Unit tests failed!
    pause
    exit /b 1
)
echo.

REM Run widget tests  
echo Running Widget Tests...
echo -----------------------
flutter test test/widget --coverage
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Widget tests failed!
    pause
    exit /b 1
)
echo.

REM Run helper tests
echo Running Helper Tests...
echo -----------------------
flutter test test/helpers --coverage
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Helper tests failed!
    pause
    exit /b 1
)
echo.

REM Generate coverage report
echo Generating Coverage Report...
echo -----------------------------
if exist coverage\lcov.info (
    echo Coverage data collected in: coverage\lcov.info
    echo.
    echo To generate HTML coverage report:
    echo Option 1: Install lcov for Windows (see instructions below)
    echo Option 2: Use online tools to convert lcov.info
    echo Option 3: View raw coverage in coverage\lcov.info
    echo.
    echo Instructions for lcov on Windows:
    echo 1. Install Chocolatey: https://chocolatey.org/install
    echo 2. Run: choco install lcov
    echo 3. Then run: genhtml coverage\lcov.info -o coverage\html
) else (
    echo [WARNING] No coverage data generated
)

echo.
echo ================================================
echo All tests completed successfully!
echo ================================================
echo.
pause