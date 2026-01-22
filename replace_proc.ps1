$mainFile = "c:\Projects\Bc apps\AppKings\Karatina\src\page\Pag50963.ProcessExamsCentralGen.al"
$tempProc = Get-Content "c:\Projects\Bc apps\AppKings\Karatina\temp_proc.al" -Raw
$content = Get-Content $mainFile -Raw

# Create regex pattern to match the procedure
$pattern = '(?s)procedure GetMultipleProgramExists\(StudNoz: Code\[250\]; AcadYearsz: Code\[250\]\) Multiples: Boolean\s*var.*?end;'

# Replace the procedure
$newContent = $content -replace $pattern, $tempProc

# Write back to file
$newContent | Set-Content $mainFile -Force
