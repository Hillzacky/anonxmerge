if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

$in = (Get-Location).ToString() + '\input'
$res = (Get-Location).ToString() + '\resources'
$out = (Get-Location).ToString() + '\output'
$qty = Get-Random -Minimum 17 -Maximum 47
$rating = Get-Random -Minimum 7 -Maximum 9
$curr = (Get-Date -UFormat "%Y-%m-%d %T").ToString()
$m1m = Get-Date -UFormat "%Y-%m-%d %T" (Get-Date).AddDays(-7).ToString()
$m2m = Get-Date -UFormat "%Y-%m-%d %T" (Get-Date).AddDays(-14).ToString()
$ext = 'mp4'
$intro = $res+'\intro.mp4'
$outro = $res+'\outro.mp4'

function render($ifile) {
    $randTime = Get-Date -Format o | ForEach-Object { $_ -replace "[-:.+]", "" }
    $randName = [System.IO.Path]::GetRandomFileName() + $randTime
    $result = $out+'\'+$randName+'.'+$ext
    .\resources\uncrypt.exe -y -i "$intro" -i "$ifile" -i "$outro" -filter_complex "[1:v:0]scale=608:1080:force_original_aspect_ratio=disable,pad=608:1080:(ow-iw)/2:(oh-ih)/2,setsar=1 [vmain];[0:v:0][0:a:0][vmain][1:a:0][2:v:0][2:a:0]concat=n=3:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" -vcodec libx264 -pix_fmt yuv420p -r 25 -crf $qty -metadata title="$rstr" -metadata language="eng" -metadata date="$m1m" -preset ultrafast -f $ext $result
}

function anon($ofile){
    .\resources\deepcml.exe -DateTimeOriginal="$m2m" -Date="$m2m" -CreateDate="$m2m" -ModifyDate="$m1m" -FileCreateDate="$m2m" -FileModifyDate="$m1m" -MediaCreateDate="$m2m" -MediaModifyDate="$m1m" -TrackCreateDate="$m2m" -TrackModifyDate="$m1m" -RatingPercent="$rating" -ownername= -source= -xmptoolkit= "$ofile" -overwrite_original
}

function setLoc($path){
    Set-Location -Path $path
}

$input = Get-ChildItem -Path $in -Force
Write-Host " ________  ________   ________  ________      ___    ___ _____ ______   _______   ________  ________  _______      ";
Write-Host "|\   __  \|\   ___  \|\   __  \|\   ___  \   |\  \  /  /|\   _ \  _   \|\  ___ \ |\   __  \|\   ____\|\  ___ \     ";
Write-Host "\ \  \|\  \ \  \\ \  \ \  \|\  \ \  \\ \  \  \ \  \/  / | \  \\\__\ \  \ \   __/|\ \  \|\  \ \  \___|\ \   __/|    ";
Write-Host " \ \   __  \ \  \\ \  \ \  \\\  \ \  \\ \  \  \ \    / / \ \  \\|__| \  \ \  \_|/_\ \   _  _\ \  \  __\ \  \_|/__  ";
Write-Host "  \ \  \ \  \ \  \\ \  \ \  \\\  \ \  \\ \  \  /     \/   \ \  \    \ \  \ \  \_|\ \ \  \\  \\ \  \|\  \ \  \_|\ \ ";
Write-Host "   \ \__\ \__\ \__\\ \__\ \_______\ \__\\ \__\/  /\   \    \ \__\    \ \__\ \_______\ \__\\ _\\ \_______\ \_______\";
Write-Host "    \|__|\|__|\|__| \|__|\|_______|\|__| \|__/__/ /\ __\    \|__|     \|__|\|_______|\|__|\|__|\|_______|\|_______|";
Write-Host "                                             |__|/ \|__|                                                           ";
Write-Host "                                                                                                                   ";
Write-Host "                                                                                                                   ";
Write-Host " ______   _____ ______   ________      ________  ___   ___  ___  ________  ________  _________  ______             ";
Write-Host "|\   ___\|\   _ \  _   \|\   __  \    |\   ____\|\  \ |\  \|\  \|\   __  \|\   __  \|\___   ___\\___   \           ";
Write-Host "\ \  \__|\ \  \\\__\ \  \ \  \|\  \   \ \  \___|\ \  \\_\  \ \  \ \  \|\ /\ \  \|\  \|___ \  \_\|___|\  \          ";
Write-Host " \ \  \   \ \  \\|__| \  \ \   _  _\   \ \_____  \ \______  \ \  \ \   __  \ \  \\\  \   \ \  \     \ \  \         ";
Write-Host "  \ \  \___\ \  \    \ \  \ \  \\  \| __\|____|\  \|_____|\  \ \  \ \  \|\  \ \  \\\  \   \ \  \    _\_\  \        ";
Write-Host "   \ \______\ \__\    \ \__\ \__\\ _\|\__\____\_\  \     \ \__\ \__\ \_______\ \_______\   \ \__\  |\______\       ";
Write-Host "    \|______|\|__|     \|__|\|__|\|__\|__|\_________\     \|__|\|__|\|_______|\|_______|    \|__|  \|______|       ";
Write-Host "                                         \|_________|                                                              ";
Write-Host "                                                                                                                   ";
Write-Host "                                                                                                                   ";
Write-Host " ________      ___    ___      ________  ___  __    ___  ___  ________   ___  __                                   ";
Write-Host "|\   __  \    |\  \  /  /|    |\   __  \|\  \|\  \ |\  \|\  \|\   ___  \|\  \|\  \                                 ";
Write-Host "\ \  \|\ /_   \ \  \/  / /    \ \  \|\  \ \  \/  /|\ \  \\\  \ \  \\ \  \ \  \/  /|_                               ";
Write-Host " \ \   __  \   \ \    / /      \ \   __  \ \   ___  \ \  \\\  \ \  \\ \  \ \   ___  \                              ";
Write-Host "  \ \  \|\  \   \/  /  /        \ \  \ \  \ \  \\ \  \ \  \\\  \ \  \\ \  \ \  \\ \  \                             ";
Write-Host "   \ \_______\__/  / /           \ \__\ \__\ \__\\ \__\ \_______\ \__\\ \__\ \__\\ \__\                            ";
Write-Host "    \|_______|\___/ /             \|__|\|__|\|__| \|__|\|_______|\|__| \|__|\|__| \|__|                            ";
Write-Host "             \|___|/                                                                                               ";
Write-Host "                                                                                                                   ";
Write-Host "                                                                                                                   ";

foreach ($inp in $input) {
    try {
        Write-Progress "Ker ngagawean nu $inp"
        render($in+'\'+$inp.Name)
    }
    catch {
        Write-Error "Error! $inp"
    }
}

$output = Get-ChildItem -Path $out -Force
foreach ($o in $output) {
    try {
        Write-Progress "Ker ngagawean nu $o"
        anon($out+'\'+$o.Name)
    }
    catch {
        Write-Error "Error! $o"
    }
}
Write-Warning -Message "Carape, beres ah."

