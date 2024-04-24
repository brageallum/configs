function Invoke-NavigateToItem {
    [CmdletBinding()]
    param (
        [string]$Project,
        [string]$SearchTerm = ".",
        [switch]$Interactive,
        [switch]$Directory,
        [switch]$File,
        [switch]$All,
        [int]$Number = 1
    )

    #Write-Host $PSBoundParameters

    # Define project paths
    $projectPaths = @{
        bn = "C:\Code\BN"
        ppa = "C:\Code\BN\PublicPortalApply\src\PublicPortalApply"
        "." = "."
    }

    if ($SearchTerm -eq "." -and -not $Interactive) {
      Set-Location -LiteralPath $projectPaths[$Project]
      return
    }

    # Determine search path
    $searchPath = "."
    if ($Project -and $projectPaths.ContainsKey($Project)) {
        $searchPath = $projectPaths[$Project]
    }

    # Determine item type to search
    $itemType = "-Directory"
    if ($Directory -and $File) {
        $itemType = ""
    } elseif ($All) {
        $itemType = ""
    } elseif ($File) {
        $itemType = "-File"
    }

    # Construct and run the fzf command
    $fzfCommand = "Get-ChildItem '$searchPath' -Recurse $itemType | Select-Object -ExpandProperty FullName"
    if (-not $Interactive) {
        $fzfCommand += " | fzf --filter='$searchPath$SearchTerm'"
    } else {
        $fzfCommand += " | fzf"
    }

    #write-host $fzfCommand
  
    $selected = Invoke-Expression $fzfCommand
    if ($selected.Length -eq 0) {
        Write-Warning "No item selected or found."
        return
    }
    if ($selected -is [Array]) {
      $selected = $selected[0]
    }

    #Write-Host $selected

    $selectedItem = Get-Item $selected

    $location = ""
    if ($selectedItem.PSIsContainer) {
        $location = $selectedItem.FullName
    } else {
        $location = $selectedItem.Directory.FullName
    }

    #Write-Host $location

    Set-Location -LiteralPath $location
}

Set-Alias to Invoke-NavigateToItem

function Get-LatestIISLog {
    $date = Get-Date -Format "yyMMdd"
    $logPath = "C:\inetpub\logs\LogFiles\W3SVC1\u_ex$date.log"
    Get-Content $logPath -Tail 10 -Wait
}

Set-Alias iislog Get-LatestIISLog

function bn {
	cd C:\Code\BN
}

function ffbn {
	gci C:\Code\BN -r -Directory | Select-Object -ExpandProperty FullName | fzf | ForEach-Object { Set-Location -LiteralPath $_ }
}

function ff {
	gci . -r -Directory | Select-Object -ExpandProperty FullName | fzf | ForEach-Object { Set-Location -LiteralPath $_ }
}

function ffile {
	gci . -r -File | Select-Object -ExpandProperty FullName | fzf
}


function fbnfile {
	gci C:\Code\BN -r -File | Select-Object -ExpandProperty FullName | fzf
}

function Invoke-GitFetchRebase {
    git fetch
    git rebase
}
Set-Alias gp Invoke-GitFetchRebase -Option AllScope -Force

function Invoke-GitStatus {
    git status @args
}
Set-Alias gs Invoke-GitStatus

function Get-GitStatusVerbose {
  git status -v
}
Set-Alias gsv Get-GitStatusVerbose -Option AllScope -Force

function Invoke-GitAdd {
  git add @args
}
Set-Alias ga Invoke-GitAdd -Option AllScope

function Get-GitLog {
    param(
        [int]$number = 3
    )
    git log -$number
}
Set-Alias gl Get-GitLog -Option AllScope -Force

function Get-CommandFromHistory {
  cat (Get-PSReadlineOption).HistorySavePath | fzf
}

Set-Alias findcommand Get-CommandFromHistory

function Invoke-GitValidate {
  $gitRoot = git rev-parse --show-toplevel
  $scriptPath = "$gitRoot/.git/hooks/validate.ps1"
  $arguments = @("-ExecutionPolicy", "Bypass", "-File", "`"$scriptPath`"") + $args
  $argumentList = $arguments -join ' '

  $process = Start-Process -FilePath "powershell.exe" `
                -ArgumentList $argumentList `
                -WorkingDirectory $gitRoot `
                -NoNewWindow `
                -PassThru `
                -Wait

  return ($process.ExitCode -eq 0)
}

Set-Alias gitvalidate Invoke-GitValidate

function Invoke-GitValidatePush {
  $isValid = Invoke-GitValidate
  if ($isValid) {
    git push
  }
}

Set-Alias gup Invoke-GitValidatePush

function Invoke-Back {
  cd ..
}
Set-Alias .. Invoke-Back
function Invoke-Backx2 {
  cd ../..
}
Set-Alias ... Invoke-Backx2

 

Invoke-Expression (& { (zoxide init powershell | Out-String) })
