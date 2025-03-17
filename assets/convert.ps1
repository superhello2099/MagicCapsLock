# 使用 System.Drawing 进行图像处理
Add-Type -AssemblyName System.Drawing

# 转换函数
function Convert-SvgToBitmap {
    param (
        [string]$inputPath,
        [string]$outputPath,
        [int]$width,
        [int]$height
    )
    
    try {
        $bitmap = New-Object System.Drawing.Bitmap($width, $height)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        
        # 设置高质量绘图
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        
        # 读取 SVG 并绘制
        $svgDoc = [System.Xml.XmlDocument]::new()
        $svgDoc.Load($inputPath)
        
        # 保存为位图
        $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Bmp)
    }
    finally {
        if ($graphics) { $graphics.Dispose() }
        if ($bitmap) { $bitmap.Dispose() }
    }
}

# 转换图片
Convert-SvgToBitmap -inputPath "installer-side.svg" -outputPath "installer-side.bmp" -width 164 -height 314
Convert-SvgToBitmap -inputPath "installer-header.svg" -outputPath "installer-header.bmp" -width 150 -height 57

# 创建图标
$sizes = @(16, 32, 48, 256)
foreach ($size in $sizes) {
    Convert-SvgToBitmap -inputPath "logo.svg" -outputPath "logo-$size.bmp" -width $size -height $size
}

Write-Host "转换完成！" 