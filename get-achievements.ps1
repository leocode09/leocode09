# GitHub Achievements Automation Script
# This script will help you get GitHub achievements faster

$repo = "leocode09/leocode09"

Write-Host "🏆 GitHub Achievement Hunter Script" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

# ============================================
# PULL SHARK x3 - Need 128 merged PRs total
# ============================================
Write-Host "`n🦈 Starting Pull Shark grind (need 128 PRs for x3)..." -ForegroundColor Yellow

$startPR = 21
$endPR = 130  # This should get you to x3

for ($i = $startPR; $i -le $endPR; $i++) {
    Write-Host "Creating PR $i..." -ForegroundColor Gray
    
    # Sync with main
    git checkout main 2>$null
    git pull origin main 2>$null
    
    # Create branch and commit
    $branch = "auto-pr-$i"
    git checkout -b $branch 2>$null
    
    # Add content
    Add-Content -Path "achievements.txt" -Value "Auto PR $i - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    
    git add . 2>$null
    git commit -m "Auto PR $i" 2>$null
    git push -u origin $branch 2>$null
    
    # Create and merge PR
    gh pr create --title "Auto PR $i" --body "Achievement hunting" --base main 2>$null
    gh pr merge --merge --admin 2>$null
    
    # Small delay to avoid rate limiting
    Start-Sleep -Milliseconds 500
    
    if ($i % 10 -eq 0) {
        Write-Host "✅ Completed $i PRs" -ForegroundColor Green
    }
}

# ============================================
# PAIR EXTRAORDINAIRE - Co-authored PR
# ============================================
Write-Host "`n👯 Setting up Pair Extraordinaire..." -ForegroundColor Yellow

git checkout main
git pull origin main
git checkout -b pair-extraordinaire

# Create a co-authored commit (you need a real GitHub user email)
# Using a common collaborator pattern
Add-Content -Path "pair-achievement.txt" -Value "Pair Extraordinaire Achievement"
git add .

# Co-authored commit format - replace with a real collaborator
$commitMsg = @"
Pair Extraordinaire Achievement

Co-authored-by: DivinPrince <divinprince@users.noreply.github.com>
"@

git commit -m $commitMsg
git push -u origin pair-extraordinaire
gh pr create --title "Pair Extraordinaire" --body "Co-authored PR for achievement" --base main
gh pr merge --merge --admin

Write-Host "✅ Pair Extraordinaire PR created!" -ForegroundColor Green

# ============================================
# MORE QUICKDRAW - Close issues fast
# ============================================
Write-Host "`n🤠 Creating more Quickdraw issues..." -ForegroundColor Yellow

for ($i = 4; $i -le 10; $i++) {
    gh issue create --title "Quickdraw $i" --body "Speed test" 2>$null
    gh issue close $i 2>$null
    Write-Host "✅ Quickdraw issue $i closed" -ForegroundColor Green
}

# ============================================
# Summary
# ============================================
Write-Host "`n🏆 ACHIEVEMENT SUMMARY" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "✅ Pull Shark - Grinding toward x3 (128 PRs)" -ForegroundColor Green
Write-Host "✅ YOLO - Multiple PRs merged without review" -ForegroundColor Green  
Write-Host "✅ Quickdraw - Multiple issues closed quickly" -ForegroundColor Green
Write-Host "✅ Pair Extraordinaire - Co-authored PR created" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  Cannot automate:" -ForegroundColor Yellow
Write-Host "   - Starstruck (need 16 real stars from users)" -ForegroundColor Gray
Write-Host "   - Public Sponsor (need to donate money)" -ForegroundColor Gray
Write-Host ""
Write-Host "🎉 Done! Check your profile: https://github.com/leocode09" -ForegroundColor Cyan
