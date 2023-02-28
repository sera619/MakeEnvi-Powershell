

function MakeEnvi {
    param (
        $lang, $name
    )
    # Set this to your Codedirectory
    $codedir = "<codedirectory>"
    ######   
    if ($codedir -eq "<codedirectory>") {
        Write-Host -fore DarkRed [x] Error!
        Write-Host -fore DarkRed "[x] You didnt change the Code-Directory variable in file."
        Write-Host -fore DarkRed "[x] Exit !"
        explorer $PROFILE
        return
    }
    $python = ""
    $vscode = ""
    $InstalledSoftware = Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    foreach ($obj in $InstalledSoftware) {
        #write-host $obj.GetValue('DisplayName') -NoNewline; write-host " - " -NoNewline; write-host $obj.GetValue('DisplayVersion')
        if ($obj.GetValue('DisplayName') -like "*Python*") {
            if ($python -eq "") {
                $python = "Ok"
            }
        }
        if ($obj.GetValue('DisplayName') -like "*Studio Code*") {
            if ($vscode -eq "") {
                $vscode = "Ok"
            }
        }
    }

    if ((!$python -eq "Ok" ) -or (!$vscode -eq "Ok")) {
        if (!$python -eq "Ok") {
            Write-Host -fore DarkRed [x] Error!
            Write-Host -fore DarkRed "[x] No Python found! Install please! (https://www.python.org/downloads/)"
            Write-Host -fore DarkRed "[x] Exit !"
            return
        }
        if (!$vscode -eq "Ok") {
            Write-Host -fore DarkRed [x] Error!
            Write-Host -fore DarkRed "[x] No Visual Studio Code found! Install please!(https://code.visualstudio.com/Download)"
            Write-Host -fore DarkRed "[x] Exit !"
            return
        }
    }
    Write-Host -fore Green "[!] Python found!"
    Write-Host -fore Green "[!] Visual Studio Code found!"
    Write-Host ""

    if (!$lang -or !$name) {
        Write-Host -fore DarkRed [x] Error!
        if (!$lang) {
            Write-Host -fore DarkRed [x] Language not set!
        }
        if (!$name) {
            Write-Host -fore DarkRed [x] Projectname not set!
        }
        Write-Host -fore DarkRed "[x] Exit !"
        Write-Host ""
        return       
    }
    Write-Host ""
    if ($lang -and $name) {

        $lang = (Get-Culture).TextInfo.ToTitleCase( $lang.ToLower())
        if ($lang -eq "Python") {
            Write-Host -fore Cyan `#`#`#`#`#`#` MakeEnvi `- Python Project `#`#`#`#`#`#`
        
            $path = "C:\" + $codedir + "\" + $lang + "\" + $name
            $exist = Test-Path $path
            if (!$exist) {
                Write-Host -fore Yellow [!] Erstelle $path ...
            
                New-Item -Type Directory $path | Out-Null
            }
            else {
                Write-Host -fore DarkRed [x] Error: Pfad $path existiert bereits!
                return
            }
            Set-Location $path
            Write-Host -fore Yellow ""
            Write-Host -fore Yellow [!] Erstelle Python Environment: $name... 
            python -m venv env-$name
            Write-Host -fore Yellow ""
            Write-Host -fore Yellow [!] Aktiviere Python Environment: $name
            & env-$name\Scripts\Activate
        }
        elseif ($lang -eq "Javascript") {
            Write-Host -fore Yellow ""
            Write-Host -fore Cyan `#`#`#`#`#`#` MakeEnvi `- JavaScript Project `#`#`#`#`#`#`
        
            $path = "C:\" + $codedir + "\" + $lang + "\" + $name
            $exist = Test-Path $path
            if (!$exist) {
                Write-Host -fore Yellow [!] Erstelle $path ...
            
                New-Item -Type Directory $path | Out-Null
            }
            else {
                Write-Host -fore DarkRed [x] Error: Pfad $path existiert bereits!
                Write-Host -fore DarkRed "[x] Exit !"
                return
            }
        } 
        Set-Location $path
        Write-Host -fore Yellow ""
        Write-Host -fore Cyan "[?] Soll ein Basic-Filesystem erstellt werden? (y/n):"
        $option = Read-Host
        if ($option -eq "y") {
            Write-Host -fore Yellow ""
            Write-Host -fore Yellow [!] Erstelle Basic-Filesystem...
            Write-Host -fore Yellow ""
            if ($lang -eq "Javascript") {
                createJSFiles
            }
            elseif ($lang -eq "Python") {
                CBF
            }

            Write-Host -fore Yellow ""
            Write-Host -fore Green [!] Neues Project erstellt!
            code .
        }
        else {
            Write-Host -fore Yellow ""
            Write-Host -fore Green [!] Neues Project erstellt!
        
        }
        Write-Host -fore Yellow ""
    }
}   

Set-Alias shortcut `MakeEnvi`

function createJSFiles {
    New-Item -Type Directory script, styles, tests, src, assets, assets/img, assets/audio | Out-Null
    New-Item  script/main.js, styles/main.css, main.html | Out-Null
    WriteReadme -name $name
    WriteHTML
}
function CBF {
    New-Item -Type Directory tests, src, assets, assets/img, assets/audio | Out-Null
    New-Item main.py, src/settings.py, src/__init__.py, README.md, .gitignore, config.yml | Out-Null
    WriteReadme -name $name
    WriteConfig -name $name
}
Set-Alias shortcut `CBF`


function WriteHTML {
    $text = "<!DOCTYPE html>
<html lang='EN'>
<head>
    <link rel='stylesheet' href='styles/main.css'>
    <title>$name</title>
</head>

<body>
    <h1>New Project @ S3R43o3</h2>
    <br>
    <p>Please change the template at 'main.html' or 'scripts/main.js'!</p>
    <script src='scripts/main.js'></script>
</body>
<html>"
    $text | Out-File -FilePath main.html | Out-Null
}

function WriteReadme {
    param (
        $path,
        $name
    )

    $text = "# $name #

> Set your Projectdescription text!

## Installation ##

> Set your installation instructions here."
    $text | Out-File -FilePath README.md | Out-Null
}

function WriteConfig {
    param(
        $name
    )
    $text = "name: " + $name + "`nversion: 0.1`n"

    $text | Out-File -FilePath config.yml | Out-Null 
}