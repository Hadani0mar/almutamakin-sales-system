# سكريبت لإنشاء Release على GitHub باستخدام API
# يتطلب GitHub Personal Access Token

param(
    [Parameter(Mandatory=$true)]
    [string]$Version = "1.0.0",
    
    [Parameter(Mandatory=$true)]
    [string]$ZipPath = "",
    
    [string]$ReleaseNotes = "الإصدار الأولي من نظام المتمكن",
    
    [string]$GitHubToken = ""
)

$owner = "Hadani0mar"
$repo = "almutamakin-sales-system"
$tag = "v$Version"
$apiUrl = "https://api.github.com/repos/$owner/$repo/releases"

# التحقق من وجود ملف ZIP
if (-not (Test-Path $ZipPath)) {
    Write-Host "Error: ZIP file not found at: $ZipPath" -ForegroundColor Red
    exit 1
}

# إذا لم يتم توفير Token، اطلب من المستخدم
if ([string]::IsNullOrEmpty($GitHubToken)) {
    Write-Host "GitHub Personal Access Token is required." -ForegroundColor Yellow
    Write-Host "Create one at: https://github.com/settings/tokens" -ForegroundColor Yellow
    Write-Host "Required scopes: repo" -ForegroundColor Yellow
    $GitHubToken = Read-Host "Enter your GitHub token"
}

if ([string]::IsNullOrEmpty($GitHubToken)) {
    Write-Host "Error: GitHub token is required" -ForegroundColor Red
    exit 1
}

Write-Host "Creating release $tag for $owner/$repo..." -ForegroundColor Green

# إنشاء Release
$releaseBody = @{
    tag_name = $tag
    name = "الإصدار $tag"
    body = $ReleaseNotes
    draft = $false
    prerelease = $false
} | ConvertTo-Json

$headers = @{
    "Authorization" = "token $GitHubToken"
    "Accept" = "application/vnd.github.v3+json"
}

try {
    # إنشاء Release
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $releaseBody -ContentType "application/json"
    $releaseId = $response.id
    Write-Host "Release created successfully! ID: $releaseId" -ForegroundColor Green
    
    # رفع ملف ZIP
    Write-Host "Uploading ZIP file..." -ForegroundColor Green
    $fileName = Split-Path $ZipPath -Leaf
    $uploadUrl = $response.upload_url -replace '\{.*\}', "?name=$fileName"
    
    $fileBytes = [System.IO.File]::ReadAllBytes($ZipPath)
    $fileEnc = [System.Text.Encoding]::GetEncoding('ISO-8859-1').GetString($fileBytes)
    
    $uploadHeaders = @{
        "Authorization" = "token $GitHubToken"
        "Content-Type" = "application/zip"
    }
    
    $uploadResponse = Invoke-RestMethod -Uri $uploadUrl -Method Post -Headers $uploadHeaders -Body $fileBytes -ContentType "application/zip"
    
    Write-Host "Release published successfully!" -ForegroundColor Green
    Write-Host "Release URL: $($response.html_url)" -ForegroundColor Cyan
    
} catch {
    Write-Host "Error creating release: $_" -ForegroundColor Red
    Write-Host "Response: $($_.Exception.Response)" -ForegroundColor Red
    exit 1
}

