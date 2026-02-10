# Script para extrair Lattes do Excel usando COM
try {
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    
    $workbook = $excel.Workbooks.Open("$PWD\docentes.xlsx")
    $worksheet = $workbook.Sheets(1)
    
    # Encontra coluna LATTES
    $row = 1
    $lattesCol = 0
    for ($col = 1; $col -le 10; $col++) {
        if ($worksheet.Cells($row, $col).Value -like "*LATTES*") {
            $lattesCol = $col
            break
        }
    }
    
    Write-Host "Coluna LATTES: $lattesCol"
    
    # Extrai dados
    $results = @()
    for ($row = 2; $row -le 150; $row++) {
        $nome = $worksheet.Cells($row, 1).Value
        $lattesCell = $worksheet.Cells($row, $lattesCol)
        
        # Tenta pegar hiperlink
        $url = ""
        if ($lattesCell.Hyperlinks.Count -gt 0) {
            $url = $lattesCell.Hyperlinks(1).Address
        }
        
        if ($nome -and $url -and $url -like "*lattes*") {
            $results += "$nome|$url"
            Write-Host "$nome | $url"
        }
    }
    
    $results | Out-File "lattes_extraidos.txt" -Encoding utf8
    Write-Host "`nTotal: $($results.Count) Lattes extraídos"
    
    $workbook.Close()
    $excel.Quit()
    
} catch {
    Write-Host "Erro: $_"
}
