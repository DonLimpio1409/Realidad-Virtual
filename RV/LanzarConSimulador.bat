@echo off
setlocal
rem Abre Practica3 en UE 5.8 usando el Meta XR Simulator v81 portable de esta carpeta.
rem No instala nada ni toca el registro: el OpenXR loader usa XR_RUNTIME_JSON antes que el
rem runtime activo del sistema, y la variable solo vive en los procesos lanzados desde aqui.
rem Uso: doble clic. Si UE 5.8 no esta en la ruta por defecto: set UE_ROOT=D:\Ruta\UE_5.8

set "PROJECT=%~dp0Practica3.uproject"
set "XRSIM_DIR=%~dp0meta_xr_simulator_windows_81.0.0.865.254"
set "XR_RUNTIME_JSON=%XRSIM_DIR%\meta_openxr_simulator.json"

if not exist "%XR_RUNTIME_JSON%" (
    echo [ERROR] No se encuentra el simulador: "%XR_RUNTIME_JSON%"
    pause
    exit /b 1
)

echo OpenXR runtime: %XR_RUNTIME_JSON%

if not defined UE_ROOT set "UE_ROOT=C:\Program Files\Epic Games\UE_5.8"
set "UE_EDITOR=%UE_ROOT%\Engine\Binaries\Win64\UnrealEditor.exe"

if exist "%UE_EDITOR%" (
    echo Editor: %UE_EDITOR%
    start "" "%UE_EDITOR%" "%PROJECT%" %*
) else (
    rem Sin ruta conocida: se abre el .uproject con UnrealVersionSelector, que hereda XR_RUNTIME_JSON.
    echo Editor: asociacion de .uproject ^(UnrealVersionSelector^)
    start "" "%PROJECT%"
)
