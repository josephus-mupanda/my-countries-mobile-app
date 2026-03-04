@echo off
echo ================================================
echo Generating Flutter Test Coverage Report
echo ================================================
echo.

REM Clean previous coverage
if exist coverage (
    echo Cleaning previous coverage data...
    rmdir /s /q coverage
    echo.
)

REM Run all tests with coverage
echo Running tests and generating coverage...
echo ----------------------------------------
flutter test --coverage --test-randomize-ordering-seed=random

if exist coverage\lcov.info (
    echo.
    echo ✅ Coverage data successfully generated!
    echo 📊 File: coverage\lcov.info
    echo 📁 Size: 
    for %%F in (coverage\lcov.info) do echo        %%~zF bytes
    
    echo.
    echo 📈 Quick Coverage Summary:
    echo ---------------------------
    
    REM Count total lines and covered lines
    set total=0
    set covered=0
    
    REM This is a simplified parser for Windows batch
    REM For accurate percentage, use PowerShell or Python
    
    echo Running PowerShell to calculate coverage...
    powershell -Command ^
        "$lcov = Get-Content 'coverage\lcov.info' -Raw; " ^
        "$total = ([regex]::Matches($lcov, 'LF:')).Count; " ^
        "$covered = ([regex]::Matches($lcov, 'LH:')).Count; " ^
        "if ($total -gt 0) { " ^
        "    $percent = [math]::Round(($covered / $total) * 100, 2); " ^
        "    Write-Host 'Lines Found:    ' $total; " ^
        "    Write-Host 'Lines Hit:      ' $covered; " ^
        "    Write-Host 'Coverage:       ' $percent'%'; " ^
        "} else { " ^
        "    Write-Host 'No coverage data found.'; " ^
        "}"
    
    echo.
    echo ================================================
    echo 📋 Viewing Options:
    echo ================================================
    echo.
    echo Option 1: View raw coverage data
    echo    Open coverage\lcov.info in any text editor
    echo.
    echo Option 2: Generate HTML report (requires lcov)
    echo    1. Install Chocolatey: https://chocolatey.org/install
    echo    2. Install lcov: choco install lcov
    echo    3. Generate: genhtml coverage\lcov.info -o coverage\html
    echo    4. Open: coverage\html\index.html
    echo.
    echo Option 3: Use Python for HTML report
    echo    1. Install Python: https://www.python.org/downloads/
    echo    2. Install: pip install lcov-cobertura
    echo    3. Convert: lcov_cobertura coverage\lcov.info -o coverage\coverage.xml
    echo.
    echo Option 4: Upload to Codecov.io (for CI/CD)
    echo    Visit: https://about.codecov.io/
) else (
    echo.
    echo ❌ ERROR: Failed to generate coverage data
    echo Check that your tests are running properly
)

echo.
pause