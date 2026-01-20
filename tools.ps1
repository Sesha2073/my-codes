function get-code {
    param([string]$file)

    # --- CONFIGURATION (FILLED FOR YOU) ---
    $githubUser = "Sesha2073"
    $repoName   = "my-codes"
    $branch     = "main"   
    # --------------------------------------

    $baseUrl = "https://raw.githubusercontent.com/$githubUser/$repoName/$branch/"

    if ([string]::IsNullOrWhiteSpace($file)) {
        Write-Host "❌ Error: You didn't tell me which file to get." -ForegroundColor Red
        Write-Host "Usage: get-code filename.ext" -ForegroundColor Yellow
        return
    }

    $url = "$baseUrl$file"

    try {
        # This downloads the raw text safely (even HTML)
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop
        
        Write-Host "`n--- START OF $file ---`n" -ForegroundColor Cyan
        # Print the raw code to the screen
        Write-Output $response.Content
        Write-Host "`n--- END OF $file ---`n" -ForegroundColor Cyan
    }
    catch {
        Write-Host "⚠️ Error: Could not find '$file' at:" -ForegroundColor Red
        Write-Host $url -ForegroundColor Gray
        Write-Host "Check if the file is in your 'my-codes' repo and spelled correctly." -ForegroundColor Gray
    }
}

Write-Host "✅ Universal Loader Active! Type 'get-code <filename>' to fetch." -ForegroundColor Green
