


$server = Get-ADComputer -Filter {operatingsystem -like "*server*"}

function Get-TimeSource {
    [CmdletBinding()]
    param (
        [Parameter(manditory =$true)]

        $server
    )

    begin {
        $timeObjectArray = @()
    }

    process {
        foreach($serv in $server){
            if(Test-Connection $serv.Name -Count 1 -Quiet){
                $run = Invoke-Command -ComputerName $serv.Name -ScriptBlock {$time = & 'w32tm' '/query', '/status';$time }
                $timeObject = New-Object pscustomobject -Property @{
                    Server= $serv.name
                    NTP = ($run | Select-String "Source:*")[1].Line
                }
                $timeObjectArray += $timeObject


            }
        }
    }

    end {
        return $timeArray
    }
}


$server = Get-ADComputer -Filter {operatingsystem -like "*server*"}





