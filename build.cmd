@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem --- 修复 PATH 与 chcp，确保可找到系统工具与 xelatex ---
if not defined SystemRoot set "SystemRoot=C:\Windows"

rem 1) 确保系统目录在 PATH 中（避免 chcp/where 等命令丢失）
for %%P in ("%SystemRoot%\System32" "%SystemRoot%" "%SystemRoot%\System32\Wbem" "%SystemRoot%\System32\WindowsPowerShell\v1.0") do (
  set "_p=%%~fP;!PATH!"
  call :_contains "!_p!" "%%~fP;"
  if errorlevel 1 set "PATH=%%~fP;!PATH!"
)
goto :after_contains

:_contains
rem %1 = haystack, %2 = needle
setlocal EnableDelayedExpansion
set "hay=%~1"
set "need=%~2"
if "!hay:%%~2=~!"=="!hay!" (
  endlocal
  exit /b 1
) else (
  endlocal
  exit /b 0
)

:after_contains

rem 2) 将代码页切到 UTF-8（使用绝对路径，避免 PATH 问题）
if exist "%SystemRoot%\System32\chcp.com" "%SystemRoot%\System32\chcp.com" 65001 >nul 2>&1

rem 3) 确保能找到 xelatex；若找不到，尝试加入常见 MiKTeX bin 目录
where xelatex.exe >nul 2>&1
if errorlevel 1 (
  for %%D in (
    "%ProgramFiles%\MiKTeX\miktex\bin\x64"
    "%ProgramFiles(x86)%\MiKTeX\miktex\bin"
    "%LocalAppData%\Programs\MiKTeX\miktex\bin\x64"
    "%LocalAppData%\MiKTeX\miktex\bin\x64"
    "%AppData%\MiKTeX\miktex\bin\x64"
  ) do (
    if exist "%%~fD\xelatex.exe" (
      set "PATH=%%~fD;!PATH!"
      goto :check_xelatex
    )
  )
  :check_xelatex
  where xelatex.exe >nul 2>&1
  if errorlevel 1 (
    echo [ERROR] xelatex not found in PATH.
    echo Please install TeX Live or MiKTeX and ensure "xelatex" is available.
    exit /b 1
  )
)

rem 提示：请在 Windows 命令提示符或 PowerShell 运行本脚本（不要在 Git Bash 中运行）。

echo Building resume with XeLaTeX...
xelatex -interaction=nonstopmode -halt-on-error main.tex
if errorlevel 1 goto :error
xelatex -interaction=nonstopmode -halt-on-error main.tex
if errorlevel 1 goto :error
echo Done. Output: main.pdf
exit /b 0
:error
echo Build failed. Check main.log for details.
exit /b 1
