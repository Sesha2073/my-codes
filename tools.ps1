function get-code {
    param([string]$file)

    # --- CORRECTED CONFIGURATION ---
    # We define the names here (No '$' inside the quotes)
    $githubUser = "Sesha2073"
    $repoName   = "my-codes"
    $branch     = "main"   
    # -------------------------------

    # PowerShell automatically puts those names into this URL
    $baseUrl = "https://raw.githubusercontent.com/$githubUser/$repoName/$branch/"

    if ([string]::IsNullOrWhiteSpace($file)) {
        Write-Host "❌ Error: You didn't tell me which file to get." -ForegroundColor Red
        Write-Host "Usage: get-code filename.ext" -ForegroundColor Yellow
        return
    }

    $url = "$baseUrl$file"

    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop
        
        Write-Host "`n--- START OF $file ---`n" -ForegroundColor Cyan
        Write-Output $response.Content
        Write-Host "`n--- END OF $file ---`n" -ForegroundColor Cyan
    }
    catch {
        Write-Host "⚠️ Error: Could not find '$file' in $url" -ForegroundColor Red
        Write-Host "Check if the file exists in your GitHub repo or if the repo is Public." -ForegroundColor Gray
    }
}

Write-Host "✅ Universal Loader Active! Type 'get-code <filename>' to fetch." -ForegroundColor Green
