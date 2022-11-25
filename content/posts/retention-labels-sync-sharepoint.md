---
title: "Sincronizar Etiquetas de retención a SharePoint manualmente."
date: 2022-11-24T20:51:06-06:00

---
## ¿Qué son políticas de retención?
Sirven para retener información por cierta cantidad de tiempo; la mejor forma de explicarlo es compartirles este [link](https://learn.microsoft.com/en-us/microsoft-365/compliance/retention-policies-sharepoint?view=o365-worldwide) de la documentación. 

## ¿Porqué las quiero en SharePoint?
Fácil, funcionan para retener información. Un ejemplo podría ser: 

1. Un documento en proceso es creado o cargado en SharePoint
2. Un grupo de personas lo edita, y lo marcan como final. 
3. El dueño del documento, le aplica manualmente la etiqueta de retención llamada **"Retención 7 años"**
4. El documento es retenido inmutable por 4 años
5. Al término de 4 años, nos damos cuenta que es necesario editarlo. 
6. Se genera una nueva versión, se mantiene la retención por 3 años más del original y 7 años para la segunda versión
7. Al final de la retención de ambas versiones, se eliminan automáticamente para reducir riesgo. 

Por supuesto hay muchos más ejemplos. La idea queda clara. 

## ¿Porqué hacer un post sobre algo que puede ser un link a la documentación?
Porque generalmente, luego de crear la etiqueta y publicarla siguiendo la [documentación](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-apply-retention-labels?view=o365-worldwide), siempre puede pasar que varios dias después la etiqueta sigue sin estar disponible en SharePoint. 

La documentación nos dice que podemos ejecutar `Set-RetentionCompliancePolicy -Identity <policy name> -RetryDistribution` para sincronizar, sin embargo, si tenemos muchas, o hemos creado varias, se necesita una forma rápida de poder solicitar la sincronización manual de todas las políticas a la vez; si tenemos 20, son 20 ejecuciones y fácil nos toma horas. La forma rápida, abajo: 

*Como de Costumbre, es buena idea copiar y pegar en PowerShell ISE e ir paso a paso (Con F8) para capturar cualquier error*
```
$LabelsSharePoint = Get-RetentionCompliancePolicy 
foreach ($label in $LabelsSharePoint) {
    Set-RetentionCompliancePolicy -Identity $label.Name -RetryDistribution
    #Para mensajes privados de Teams, usar Set-AppRetentionCompliancePolicy -Identity $label.Name -RetryDistribution
    Write-host( $label.Name + " se solicitó sincronizar" ) -ForegroundColor Green
}

```

Para ver el Script completo, **incluyendo la instalaciones y pre-requisitos**, ir a este [link](https://github.com/JPCortesP/JPCortesP.github.io/blob/main/static/scripts/Sync-retention-labels-sharepoint.ps1)