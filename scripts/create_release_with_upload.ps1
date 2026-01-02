# سكريبت شامل لإنشاء Release ورفع الملفات على GitHub
# يتطلب GitHub Personal Access Token

param(
    [string]$Version = "1.0.0",
    [string]$ZipPath = "",
    [string]$ReleaseNotes = "الإصدار الأولي من نظام المتمكن",
    [string]$GitHubToken = $env:GITHUB_TOKEN
)

$owner = "Hadani0mar"
$repo = "almutamakin-sales-system"
$tag = "v$Version"
$apiBaseUrl = "https://api.github.com/repos/$owner/$repo"

# التحقق من وجود ملف ZIP
if ([string]::IsNullOrEmpty($ZipPath)) {
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $ZipPath = Join-Path $desktopPath "Almutamakin_Sales_System\Almutamakin_Sales_System_v$Version.zip"
}

if (-not (Test-Path $ZipPath)) {
    Write-Host "Error: ZIP file not found at: $ZipPath" -ForegroundColor Red
    Write-Host "Please build the application first or provide the correct path." -ForegroundColor Yellow
    exit 1
}

# إذا لم يتم توفير Token
if ([string]::IsNullOrEmpty($GitHubToken)) {
    Write-Host "=" -ForegroundColor Cyan
    Write-Host "GitHub Personal Access Token Required" -ForegroundColor Yellow
    Write-Host "=" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Go to: https://github.com/settings/tokens" -ForegroundColor White
    Write-Host "2. Click 'Generate new token (classic)'" -ForegroundColor White
    Write-Host "3. Select 'repo' scope" -ForegroundColor White
    Write-Host "4. Copy the token" -ForegroundColor White
    Write-Host ""
    $GitHubToken = Read-Host "Enter your GitHub token (or press Enter to skip)"
    
    if ([string]::IsNullOrEmpty($GitHubToken)) {
        Write-Host ""
        Write-Host "Skipping automated release creation." -ForegroundColor Yellow
        Write-Host "Please create release manually at:" -ForegroundColor Yellow
        Write-Host "https://github.com/$owner/$repo/releases/new" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Upload this file:" -ForegroundColor Yellow
        Write-Host $ZipPath -ForegroundColor White
        exit 0
    }
}

Write-Host ""
Write-Host "Creating release $tag..." -ForegroundColor Green

# إعداد Headers
$headers = @{
    "Authorization" = "Bearer $GitHubToken"
    "Accept" = "application/vnd.github.v3+json"
    "User-Agent" = "PowerShell-Release-Script"
}

# إنشاء Release
$releaseBody = @{
    tag_name = $tag
    name = "الإصدار $tag"
    body = $ReleaseNotes
    draft = $false
    prerelease = $false
} | ConvertTo-Json -Depth 10

try {
    Write-Host "Step 1: Creating release..." -ForegroundColor Cyan
    $releaseUrl = "$apiBaseUrl/releases"
    $releaseResponse = Invoke-RestMethod -Uri $releaseUrl -Method Post -Headers $headers -Body $releaseBody -ContentType "application/json; charset=utf-8"
    $releaseId = $releaseResponse.id
    Write-Host "✓ Release created! ID: $releaseId" -ForegroundColor Green
    
    # رفع ملف ZIP
    Write-Host "Step 2: Uploading ZIP file..." -ForegroundColor Cyan
    $fileName = Split-Path $ZipPath -Leaf
    $uploadUrl = $releaseResponse.upload_url -replace '\{.*\}', "?name=$fileName"
    
    # قراءة الملف كـ bytes
    $fileBytes = [System.IO.File]::ReadAllBytes($ZipPath)
    $fileSizeMB = [math]::Round($fileBytes.Length / 1MB, 2)
    Write-Host "  File size: $fileSizeMB MB" -ForegroundColor Gray
    
    # رفع الملف
    $uploadHeaders = @{
        "Authorization" = "Bearer $GitHubToken"
        "Content-Type" = "application/zip"
        "Content-Length" = $fileBytes.Length
    }
    
    $uploadResponse = Invoke-RestMethod -Uri $uploadUrl -Method Post -Headers $uploadHeaders -Body $fileBytes
    
    Write-Host "✓ File uploaded successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "=" -ForegroundColor Green
    Write-Host "Release Published Successfully!" -ForegroundColor Green
    Write-Host "=" -ForegroundColor Green
    Write-Host ""
    Write-Host "Release URL: $($releaseResponse.html_url)" -ForegroundColor Cyan
    Write-Host "Tag: $tag" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Users can now update automatically from within the app!" -ForegroundColor Yellow
    
} catch {
    Write-Host ""
    Write-Host "Error occurred:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "Please create release manually at:" -ForegroundColor Yellow
    Write-Host "https://github.com/$owner/$repo/releases/new" -ForegroundColor Cyan
    exit 1
}

