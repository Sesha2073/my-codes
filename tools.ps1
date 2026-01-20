function get-code {
    param([string]$file)

    # --- CONFIGURATION: EDIT THIS PART ---
    $githubUser = "YOUR_USERNAME"
    $repoName   = "YOUR_REPO_NAME"
    $branch     = "main"   
    # -------------------------------------

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
        Write-Host "⚠️ Error: Could not find '$file'. Check the spelling." -ForegroundColor Red
    }
}

Write-Host "✅ Universal Loader Active! Type 'get-code <filename>' to fetch." -ForegroundColor Green
