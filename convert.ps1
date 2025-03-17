Add-Type -AssemblyName System.Drawing

function Convert-SvgToBitmap {
    param(
        [string]$inputPath,
        [string]$outputPath,
        [int]$width,
        [int]$height
    )

    try {
        $bitmap = New-Object System.Drawing.Bitmap($width, $height)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        
        # Set high quality drawing options
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        
        # Load SVG file
        $image = [System.Drawing.Image]::FromFile($inputPath)
        
        # Draw image
        $graphics.DrawImage($image, 0, 0, $width, $height)
        
        # Save as BMP
        $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Bmp)
        
        # Cleanup
        $graphics.Dispose()
        $bitmap.Dispose()
        $image.Dispose()
        
        Write-Host "Successfully converted $inputPath to $outputPath"
    }
    catch {
        Write-Error "Error converting image: $_"
    }
}

# Convert installer side image
Convert-SvgToBitmap -inputPath "assets/installer-side.svg" -outputPath "assets/installer-side.bmp" -width 164 -height 314

# Convert installer header image
Convert-SvgToBitmap -inputPath "assets/installer-header.svg" -outputPath "assets/installer-header.bmp" -width 150 -height 57

Write-Host "Conversion completed!" 