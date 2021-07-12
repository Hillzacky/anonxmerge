@echo off
set scriptFolderPath=%cd%
set scriptFileName=render.ps1
powershell -Command "Start-Process powershell \"-ExecutionPolicy Bypass -NoProfile -NoExit -Command `\"cd \`\"%scriptFolderPath%\`\"; & \`\".\%scriptFileName%\`\";Start-Sleep -s 1.5;ii %cd%\output;exit`\"\" -Verb RunAs"
