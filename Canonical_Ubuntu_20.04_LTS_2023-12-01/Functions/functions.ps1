function get-udfpackage{
    param([hashtable]$fromSender)
    $cmd = "dpkg -l | grep $($fromSender.PackageName)"
    $pkg = Invoke-Expression $cmd
    $pkgTable   = @{
        FixRequired     = [bool]
        FixScriptPath   = [string]
        Details         = [string]
        Comments        = [string]
        Justification   = [string]
        DCState         = [string]
        Name            = [string]
        Version         = [string]
        Architecture    = [string]
    }
    
    $items = @()
    if($pkg){
        $items += ($pkg -split "\s+")
    }
    
    if($items){
        $pkgTable.FixRequired   = $false
        $pkgTable.FixScriptPath = $null
        $pkgTable.DCState       = $items[0]
        $pkgTable.Name          = $items[1]
        $pkgTable.Version       = $items[2]
        $pkgTable.Architecture  = $items[3]
    }else{
        $pkgTable.FixRequired   = $true
        $pkgTable.FixScriptPath = 'path\to\fix\script'
        $pkgTable.DCState       = $null
        $pkgTable.Name          = $null
        $pkgTable.Version       = $null
        $pkgTable.Architecture  = $null
    }

    $pkgObject = [pscustomobject]@{
        FixRequired   = $pkgTable.FixRequired  
        FixScriptPath = $pkgTable.FixScriptPath
        DCState       = $pkgTable.DCState      
        Name          = $pkgTable.Name         
        Version       = $pkgTable.Version      
        Architecture  = $pkgTable.Architecture 
    }
    return $pkgObject
}
#get-udfpackage @{PackageName = "vlock"}

#V-238205
function get-udfpasswdcontent{
    $content = Get-Content '/etc/passwd'
    $object = @()
    foreach($l in $content){
        $items  =  $l.Split(':')
        $object += [pscustomobject]@{
            UserName    = $items[0]
            PSHash      = $items[1]
            UID         = $items[2]
            GID         = $items[3]
            UserInfo    = $items[4]
            HomeDir     = $items[5]
            ShellPath   = $items[6]
        }
    }
    
    $duplicates = @()
    ($object | Group-Object -Property UID) | ForEach-Object {
        if($_.Count -gt 1){
            $duplicates += [pscustomobject]@{
                UserName        = $_.UserName
                UID             = $_.UID
            }
        }
    }
    $results = @()
    if($duplicates){
        foreach($i in $duplicates){
            $results += [pscustomobject]@{
                FixRequired     = $true
                FixScriptPath   = 'path\to\fix\script'
                Details         = ''
                Comments        = ''
                Justification   = 'There is duplicate UIDs.'
                UserName        = $i.UserName
                UID             = $i.UID
            }
        }
    }else{
        $results += [pscustomobject]@{
            FixRequired     = $false
            FixScriptPath   = $null
            Details         = ''
            Comments        = ''
            Justification   = 'There is no duplicate UIDs.'
            UserName        = $null
            UID             = $null
        }
    }
    return $results
}
#get-udfpasswdcontent

#v-238202
function get-udfpasswordminday{
    $passMin = ((invoke-expression "grep -i ^pass_min_days /etc/login.defs") -split "\s+")[-1]
    $results = @()
    if($passMin -eq 0){
        $results += [pscustomobject]@{
            FixRequired     = $true
            FixScriptPath   = 'path\to\fix\script'
            Details         = ''
            Comments        = ''
            Justification   = "'pass_min_days' value is set to '0'."
            PassMinDays     = $passMin
        }
    }else{
        $results += [pscustomobject]@{
            FixRequired     = $false
            FixScriptPath   = 'path\to\fix\script'
            Details         = ''
            Comments        = ''
            Justification   = "'pass_min_days' value is set to '$($passMin)'."
            PassMinDays     = $passMin
        } 
    }
    return $results
}
#get-udfpasswordminday
