Add-Type -AssemblyName System.Drawing

for ($num = 1; $num -le 9; $num++) {
    $filePath = "f:\NID\Semester 3\iTool\Languages\Untitled_Artwork-$num.png"
    if (Test-Path $filePath) {
        $bmp = New-Object System.Drawing.Bitmap($filePath)
        $w = $bmp.Width
        $h = $bmp.Height
        
        $minX = $w
        $minY = $h
        $maxX = 0
        $maxY = 0
        $found = $false
        
        # Fast lockbits check or sampled check
        for ($y = 0; $y -lt $h; $y += 2) {
            for ($x = 0; $x -lt $w; $x += 2) {
                $pixel = $bmp.GetPixel($x, $y)
                if ($pixel.A -gt 10) {
                    if ($x -lt $minX) { $minX = $x }
                    if ($x -gt $maxX) { $maxX = $x }
                    if ($y -lt $minY) { $minY = $y }
                    if ($y -gt $maxY) { $maxY = $y }
                    $found = $true
                }
            }
        }
        $bmp.Dispose()
        if ($found) {
            $bw = $maxX - $minX + 1
            $bh = $maxY - $minY + 1
            Write-Host "Artwork $num - Canvas: $w x $h, BBox: X=$minX, Y=$minY, W=$bw, H=$bh"
        } else {
            Write-Host "Artwork $num - Empty"
        }
    }
}
