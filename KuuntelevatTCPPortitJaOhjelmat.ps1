# Kerätään kuuntelevat portit ja niiden takana olevat ohjelmat

# Luokka uusille objekteille
class TCPKuuntelija
{
    [uint16] $Portti
    [uint32] $ProsessiId
    [string] $Nimi  
    [string] $Käyttäjä 
}

# Tyhjä vektori tuloksille
$Tulokset = @()

# Haetaan kaikki kuuntelevat TCP-portit
$ListenerCollection = Get-NetTCPConnection -State Listen 

# Luodaan objektit portin ja prosessin tiedoista
foreach($Listener in $ListenerCollection)
{
    [TCPKuuntelija] $tcpKuuntelija = [TCPKuuntelija]::new()
    $tcpKuuntelija.Portti = $Listener.LocalPort
    $tcpKuuntelija.ProsessiId = $Listener.OwningProcess

    $Prosessitiedot = Get-Process -Id $Listener.OwningProcess -IncludeUserName
    $tcpKuuntelija.Nimi = $Prosessitiedot.ProcessName
    $tcpKuuntelija.Käyttäjä = $Prosessitiedot.UserName

    $Tulokset = $Tulokset + $tcpKuuntelija
}

$Tulokset | Out-GridView

Get-Process -Id 636
