@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo 梦境 SVN 管理器启动诊断
echo 当前目录: %CD%
echo.

if not exist "SVNManager.exe" (
  echo 找不到 SVNManager.exe。请确认已经完整解压压缩包。
  pause
  exit /b 1
)

echo 正在启动 SVNManager.exe...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p = Start-Process -FilePath '.\SVNManager.exe' -PassThru; Start-Sleep -Seconds 3; if ($p.HasExited) { Write-Host ''; Write-Host ('程序启动后立刻退出，退出码: ' + $p.ExitCode); Write-Host ''; $log = Join-Path $env:APPDATA 'SVNManager\startup.log'; if (Test-Path $log) { Write-Host '启动日志:'; Get-Content $log -Tail 120 } else { Write-Host ('没有找到启动日志: ' + $log) }; Write-Host ''; Read-Host '按回车关闭窗口' } else { Write-Host '程序已经启动。如果仍然没有窗口，请截图这个诊断窗口并发送。'; Start-Sleep -Seconds 2 }"
