@echo off
echo Generating Flutter Test Coverage Report
echo ========================================
echo.

REM Run all tests with coverage
flutter test --coverage --test-randomize-ordering-seed=random

if exist coverage\lcov.info (
    echo Coverage data generated at: coverage\lcov.info
    echo.
    echo ============================
    echo Coverage Statistics Summary
    echo ============================
    echo.
    
    REM Basic parsing of lcov.info (simplified version)
    for /f "tokens=*" %%a in ('type coverage\lcov.info ^| findstr /c:"LF:"') do (
        set line=%%a
        REM Extract coverage percentage
        for /f "tokens=2 delims=:" %%b in ("%%a") do (
            set /a "percent=%%b"
            echo Overall coverage: %%b%%
        )
    )
    
    echo.
    echo For detailed HTML report on Windows:
    echo 1. Install Python: https://www.python.org/downloads/
    echo 2. Install lcov parser: pip install lcov-cobertura
    echo 3. Convert: lcov_cobertura coverage\lcov.info -o coverage\coverage.xml
    echo 4. Open coverage.xml in browser or use coverage.py
    echo.
    echo Quick view option:
    echo Open coverage\lcov.info in any text editor to see line-by-line coverage.
) else (
    echo [ERROR] Failed to generate coverage data
)

echo.
pause