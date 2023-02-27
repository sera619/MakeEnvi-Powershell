
function MakeEnvi {
    param (
        $lang, $name
    )
    Write-Host ""
    if ($lang -and $name){
        # Set this to your Codedirectory
        $codedir = "<codedirectory>"
        #
        if ($codedir -eq "<codedirectory>"){
            Write-Host -fore DarkRed "[x] ERROR: Please change the codedir variable in the script!"
            Write-Host -fore DarkRed "[x] Exit !"
            return
        }
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
    }else{
        Write-Host -fore DarkRed [x] Error!
        if (!$lang){
            Write-Host -fore DarkRed [x] Langquage not set!
        }
        if (!$name){
            Write-Host -fore DarkRed [x] Langquage not set!
        }
        Write-Host -fore DarkRed "[x] Exit !"
        Write-Host ""
        return       
    }
}   

Set-Alias shortcut `MakeEnvi`