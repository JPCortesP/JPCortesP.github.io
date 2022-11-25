# ===== INSTALACIÓN DEL MÓDULO, IGNORAR SI YA ESTÁ INSTALADO ========
Set-ExecutionPolicy RemoteSigned #Pre-req para instalar el módulo. 
Install-Module -Name ExchangeOnlineManagement
# Si no tiene admin local: 
#Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser

#== FIN DE LA INSTALACIÓN

Import-Module ExchangeOnlineManagement
Connect-IPPSSession -UserPrincipalName nombre@dominio.net #reemplazar por su nombre@dominio con permisos de Admin global o similar. 
#Ver https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps para tenants fuera de Normal /ej, GCC. 

#Conectados al tenant, listamos las etiquetas de retención:
Get-RetentionCompliancePolicy | ft
#si necesitamos solo sincronizar una única política, esto es todo lo que necesitamos :P. Pero si queremos sincronizar todas, ejecutar lo siguiente: 
$LabelsSharePoint = Get-RetentionCompliancePolicy 
foreach ($label in $LabelsSharePoint) {
    Set-RetentionCompliancePolicy -Identity $label.Name -RetryDistribution
    #Para mensajes privados de Teams, usar Set-AppRetentionCompliancePolicy -Identity $label.Name -RetryDistribution
    Write-host( $label.Name + " se solicitó sincronizar" ) -ForegroundColor Green
}


#Para Desconectar: 
Disconnect-ExchangeOnline -Confirm:$false


#Copyright 2022, JPCortesP

#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.