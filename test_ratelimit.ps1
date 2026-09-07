1..25 | ForEach-Object {
    $i = $_
    try {
        $r = Invoke-RestMethod -Method POST `
            -Uri "http://localhost:8000/chat" `
            -ContentType "application/json" `
            -Body "{`"message`": `"Rate limit test $i`", `"thread_id`": `"test`"}"
        Write-Host "  Request $i`: 200 OK" -ForegroundColor Green
    } catch {
        $code = $_.Exception.Response.StatusCode.value__
        if ($code -eq 429) {
            Write-Host "  Request $i`: 429 RATE LIMITED" -ForegroundColor Yellow
        } else {
            Write-Host "  Request $i`: $code" -ForegroundColor Red
        }
    }
}
