# سكريبت لإنشاء Release على GitHub
# يتطلب GitHub CLI (gh) أو يمكن استخدام GitHub API مباشرة

param(
    [string]$Version = "1.0.0",
    [string]$ZipPath = "",
    [string]$ReleaseNotes = "الإصدار الأولي من نظام المتمكن"
)

$owner = "Hadani0mar"
$repo = "almutamakin-sales-system"
$tag = "v$Version"

Write-Host "Creating release $tag for $owner/$repo..."

# إذا كان GitHub CLI مثبتاً
if (Get-Command gh -ErrorAction SilentlyContinue) {
    if ($ZipPath -and (Test-Path $ZipPath)) {
        gh release create $tag $ZipPath --title "الإصدار $tag" --notes $ReleaseNotes --repo "$owner/$repo"
    } else {
        gh release create $tag --title "الإصدار $tag" --notes $ReleaseNotes --repo "$owner/$repo"
    }
    Write-Host "Release created successfully!"
} else {
    Write-Host "GitHub CLI (gh) not found. Please install it or create release manually at:"
    Write-Host "https://github.com/$owner/$repo/releases/new"
    Write-Host ""
    Write-Host "Or use GitHub API with a personal access token."
}

