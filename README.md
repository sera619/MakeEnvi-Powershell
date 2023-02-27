# Automatic Project Creation #

> UNDER DEVELOPMENT
>
> This Powershellscript will create new code projects.

<details>
<summary>Supported languages</summary>
<br>

>| Language | Supported |
>|:----------:|:-----------:|
>| Python| ✔️ |
>| JavaScript| ✔️ |

</details>

## Usage ##

> If you already dont know what a Powershell-Profile is open below otherwise skip.

<details>
<summary>What is a Powershell-Profile?</summary>
<br>

>
> Microsoft provide a PowerShell-Script in your user directory that will always execute if you start a new PowerShell-Terminal.
>
> You can use this to create own shortcuts for example if you dont want type the same path again and again.
>
> Or you want provide some custom scripts that you can easy access via console.
>

</details>
<br>

> Here we install the script.

<details>
<summary>Installation</summary>
<br>

> Copy the content from the [script](#automatic-project-creation)
>
> Open a PowerShell-Terminal and type "explorer $profile"
>
> A Editor Window will appear with your profile opened.
> 
> Paste the copied script code somewhere in the script.
>
> Save file and close the restart the terminal.
> 
> Make sure you edite the \<codedirectory\> variable in the script to you root code directory!

</details>
<br>

> Now you can use the Helper!

<details>
<summary>Use command</summary>
<br>

> Open a Powershell-Terminal and type the command above
>
> The "codelanguage" and "projectname" represent your inputs
>
```Powershell
    MakeEnvi codelanguage projectname
```
>
> Your project should be Created
>

</details>
