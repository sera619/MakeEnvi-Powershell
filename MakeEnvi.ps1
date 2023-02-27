

function MakeEnvi {
    param (
        $lang, $name
    )
    # Set this to your Codedirectory
    $codedir = "<codedirectory>"
    ######   
    if ($codedir -eq "<codedirectory>"){
        Write-Host -fore DarkRed [x] Error!
        Write-Host -fore DarkRed "[x] You didnt change the Code-Directory variable in file."
        Write-Host -fore DarkRed "[x] Exit !"
        explorer $PROFILE
        return
    }
    $python = ""
    $vscode = ""
    $InstalledSoftware = Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    foreach($obj in $InstalledSoftware){
        #write-host $obj.GetValue('DisplayName') -NoNewline; write-host " - " -NoNewline; write-host $obj.GetValue('DisplayVersion')
        if ($obj.GetValue('DisplayName') -like "*Python*") {
            if ($python -eq ""){
                $python = "Ok"
            }
        }
        if ($obj.GetValue('DisplayName') -like "*Studio Code*") {
            if ($vscode -eq ""){
                $vscode = "Ok"
            }
        }
    }

    if ((!$python -eq "Ok" )-or(!$vscode -eq "Ok")){
        if (!$python -eq "Ok"){
            Write-Host -fore DarkRed [x] Error!
            Write-Host -fore DarkRed "[x] No Python found! Install please!"
            Write-Host -fore DarkRed "[x] Exit !"
            return
        }
        if (!$vscode -eq "Ok"){
            Write-Host -fore DarkRed [x] Error!
            Write-Host -fore DarkRed "[x] No Visual Studio Code found! Install please!"
            Write-Host -fore DarkRed "[x] Exit !"
            return
        }
    }
    Write-Host -fore Green "[!] Python found!"
    Write-Host -fore Green "[!] Visual Studio Code found!"
    Write-Host ""
    
    if (!$lang -or !$name){
        Write-Host -fore DarkRed [x] Error!
        if (!$lang){
            Write-Host -fore DarkRed [x] Language not set!
        }
        if (!$name){
            Write-Host -fore DarkRed [x] Projectname not set!
        }
        Write-Host -fore DarkRed "[x] Exit !"
        Write-Host ""
        return       
    }
    Write-Host ""
    if ($lang -and $name){

        $lang = (Get-Culture).TextInfo.ToTitleCase( $lang.ToLower())
        if($lang -eq "Python"){
            Write-Host -fore Cyan `#`#`#`#`#`#` MakeEnvi `- Python Project `#`#`#`#`#`#`
            
            $path = "C:\"+$codedir+"\"+$lang+"\"+$name
            $exist = Test-Path $path
            if(!$exist){
                Write-Host -fore Yellow [!] Erstelle $path ...
                
                New-Item -Type Directory $path | Out-Null
            }else{
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
        }elseif ($lang -eq "Javascript"){
            Write-Host -fore Yellow ""
            Write-Host -fore Cyan `#`#`#`#`#`#` MakeEnvi `- JavaScript Project `#`#`#`#`#`#`
            
            $path = "C:\"+$codedir+"\"+$lang+"\"+$name
            $exist = Test-Path $path
            if(!$exist){
                Write-Host -fore Yellow [!] Erstelle $path ...
                
                New-Item -Type Directory $path | Out-Null
            }else{
                Write-Host -fore DarkRed [x] Error: Pfad $path existiert bereits!
                Write-Host -fore DarkRed "[x] Exit !"
                return
            }
        } 
        Set-Location $path
        Write-Host -fore Yellow ""
        Write-Host -fore Cyan "[?] Soll ein Basic-Filesystem erstellt werden? (y/n):"
        $option = Read-Host
        if ($option -eq "y"){
            Write-Host -fore Yellow ""
            Write-Host -fore Yellow [!] Erstelle Basic-Filesystem...
            Write-Host -fore Yellow ""
            CBF
            Write-Host -fore Yellow ""
            Write-Host -fore Green [!] Neues Project erstellt!
            code .
        } else {
            Write-Host -fore Yellow ""
            Write-Host -fore Green [!] Neues Project erstellt!
            
        }
        Write-Host -fore Yellow ""
    }
}   

Set-Alias shortcut `MakeEnvi`