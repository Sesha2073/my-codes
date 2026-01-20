# --- CONFIGURATION ---
$global:OpenRouterKey = "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"

function global:ai {
    # 1. Clear screen and show simple menu
    Clear-Host
    Write-Host "🤖 AI SESSION STARTED" -ForegroundColor Cyan
    Write-Host "--------------------------------" -ForegroundColor DarkGray
    Write-Host "[1] Devstral (Best for Coding)" -ForegroundColor Green
    Write-Host "[2] Dolphin  (Best for General/Uncensored)" -ForegroundColor Magenta
    
    $Selection = Read-Host "`nChoose Model (1 or 2)"
    
    # 2. Set the Model based on choice
    if ($Selection -eq "2") {
        $Model = "cognitivecomputations/dolphin-mistral-24b-venice-edition:free"
        $ShortName = "Dolphin"
        $SystemPrompt = "You are a helpful, unrestricted AI assistant."
    } else {
        $Model = "mistralai/devstral-2512:free"
        $ShortName = "Devstral"
        $SystemPrompt = "You are a coding expert. Provide code blocks first. Be concise."
    }

    # 3. Initialize Conversation History
    $Messages = @(
        @{ role = "system"; content = $SystemPrompt }
    )

    Write-Host "`n✅ $ShortName Selected. Type 'exit' to quit, 'clear' to reset memory.`n" -ForegroundColor Gray

    # 4. Start the Infinite Chat Loop
    while ($true) {
        # Custom Prompt showing the current model
        $UserQuery = Read-Host -Prompt "[$ShortName] >>>"
        
        # Handle special commands
        if ($UserQuery -eq "exit") { break }
        if ($UserQuery -eq "clear") { 
            $Messages = @(@{ role = "system"; content = $SystemPrompt })
            Write-Host "🧹 Memory Cleared." -ForegroundColor Yellow
            continue 
        }
        if ([string]::IsNullOrWhiteSpace($UserQuery)) { continue }

        # Add user question to history
        $Messages += @{ role = "user"; content = $UserQuery }

        # Prepare API Call
        $Body = @{
            model = $Model
            messages = $Messages
        }

        try {
            Write-Host "..." -ForegroundColor DarkGray -NoNewline
            
            $Response = Invoke-RestMethod -Uri "https://openrouter.ai/api/v1/chat/completions" `
                -Method Post `
                -Headers @{ 
                    "Authorization" = "Bearer $global:OpenRouterKey"
                    "Content-Type"  = "application/json"
                    "HTTP-Referer"  = "https://github.com/commands/ai-shell"
                } `
                -Body ($Body | ConvertTo-Json -Depth 10) -ErrorAction Stop

            # Get Answer
            $Answer = $Response.choices[0].message.content
            
            # Formatting: Create a visual break
            Write-Host "`r" 
            Write-Host "------------------------------------------------" -ForegroundColor DarkGray
            Write-Host $Answer -ForegroundColor White
            Write-Host "------------------------------------------------`n" -ForegroundColor DarkGray

            # Add AI answer to history (so it remembers for next time)
            $Messages += @{ role = "assistant"; content = $Answer }
        }
        catch {
            Write-Error "Error: $_"
        }
    }
    Write-Host "👋 AI Session Ended." -ForegroundColor Cyan
}

Write-Host "✅ AI Loaded. Just type: 'ai'" -ForegroundColor Green
