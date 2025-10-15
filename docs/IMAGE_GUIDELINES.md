# Image Guidelines for Fakher mn Alakher
# إرشادات الصور لفاخر من الآخر

## Overview / نظرة عامة

This document outlines the image standards and processing guidelines for the Fakher mn Alakher application and website. Following these guidelines ensures a consistent, professional appearance across all platforms.

## Standard Image Sizes / المقاسات القياسية للصور

### iOS Application Sizes
| Size | Dimensions | Use Case | Arabic |
|------|------------|----------|---------|
| Thumbnail | 150 x 150px | List previews, small icons | صورة مصغرة |
| Medium | 400 x 400px | Product cards, grid view | متوسطة |
| Large | 800 x 800px | Detail views, zoom | كبيرة |
| Hero | 1200 x 800px | Featured products, banners | بطولية |

### Website Sizes
Same as iOS application for consistency across platforms.

### App Icons (iOS)
| Size | Purpose | Arabic |
|------|---------|--------|
| 1024 x 1024px | App Store | متجر التطبيقات |
| 180 x 180px | iPhone (@3x) | آيفون |
| 167 x 167px | iPad Pro | آيباد برو |
| 152 x 152px | iPad (@2x) | آيباد |
| 120 x 120px | iPhone (@2x) | آيفون |

## Image Requirements / متطلبات الصور

### Technical Requirements / المتطلبات التقنية

1. **Format / التنسيق**
   - Primary: PNG (for transparency)
   - Alternative: JPEG (for photos)
   - Avoid: GIF, BMP, TIFF

2. **Color Space / مساحة الألوان**
   - sRGB color space
   - 24-bit color depth minimum
   - RGB mode (not CMYK)

3. **Resolution / الدقة**
   - 72 DPI minimum for web
   - 144 DPI for retina displays
   - 300 DPI for print materials

4. **File Size / حجم الملف**
   - Thumbnail: < 50 KB
   - Medium: < 150 KB
   - Large: < 300 KB
   - Hero: < 500 KB

### Quality Standards / معايير الجودة

1. **Background / الخلفية**
   - ✅ Transparent (preferred)
   - ✅ Solid white (#FFFFFF)
   - ✅ Subtle gradient (light colors)
   - ❌ Busy patterns
   - ❌ Dark backgrounds
   - ❌ Multiple colors

2. **Lighting / الإضاءة**
   - ✅ Even, soft lighting
   - ✅ No harsh shadows
   - ✅ Highlights on metallic surfaces
   - ❌ Overexposed areas
   - ❌ Underexposed areas
   - ❌ Uneven lighting

3. **Focus / التركيز**
   - ✅ Sharp, clear product
   - ✅ No blur
   - ✅ Proper depth of field
   - ❌ Out of focus
   - ❌ Motion blur
   - ❌ Pixelation

4. **Composition / التكوين**
   - ✅ Product centered
   - ✅ Appropriate padding (10-15%)
   - ✅ Consistent angles
   - ❌ Cropped important parts
   - ❌ Off-center positioning
   - ❌ Inconsistent perspective

## Image Processing Workflow / سير عمل معالجة الصور

### Step 1: Source Image Preparation / الخطوة 1: تحضير الصورة المصدر
1. Start with highest quality available
2. Ensure proper lighting and focus
3. Remove any watermarks or logos
4. Clean the background if necessary

### Step 2: Background Removal / الخطوة 2: إزالة الخلفية
1. Use professional tools:
   - Adobe Photoshop (Pen Tool, Magic Wand)
   - Remove.bg (online service)
   - GIMP (free alternative)
2. Ensure clean edges
3. Preserve fine details (hair, textures)
4. Save as PNG with transparency

### Step 3: Resizing / الخطوة 3: تغيير الحجم
1. Use iOS `ImageProcessor` class:
   ```swift
   let resized = ImageProcessor.resizeImage(image, to: .medium)
   ```
2. Or use web `ImageUtils`:
   ```javascript
   ImageUtils.createPlaceholderImage(product, 'medium')
   ```
3. Maintain aspect ratio
4. Use high-quality interpolation

### Step 4: Enhancement / الخطوة 4: التحسين
1. Adjust brightness/contrast if needed
2. Sharpen slightly (don't overdo)
3. Color correction for accuracy
4. Add subtle shadow if required

### Step 5: Optimization / الخطوة 5: التحسين
1. Compress to target file size
2. Use appropriate quality setting (80-90%)
3. Test on target devices
4. Ensure no quality loss visible

## iOS Image Processing Examples / أمثلة معالجة الصور في iOS

### Resize Image
```swift
import UIKit

// Resize to medium size (400x400)
let originalImage = UIImage(named: "product")!
let resizedImage = ImageProcessor.resizeImage(
    originalImage, 
    to: .medium, 
    removeBackground: true
)
```

### Apply Effects
```swift
// Add corner radius
let roundedImage = ImageProcessor.applyCornerRadius(
    image, 
    radius: 16
)

// Add shadow
let shadowedImage = ImageProcessor.addShadow(
    image,
    shadowColor: .black,
    shadowOpacity: 0.3,
    shadowOffset: CGSize(width: 0, height: 4),
    shadowRadius: 8
)

// Make circular
let circularImage = ImageProcessor.makeCircular(image)
```

### Compress for Storage
```swift
// Compress to 80% quality
if let imageData = ImageProcessor.compressImage(image, quality: 0.8) {
    // Save or upload imageData
}
```

## Website Image Processing Examples / أمثلة معالجة الصور في الموقع

### Create Placeholder
```javascript
// Create medium size placeholder
const placeholderImage = ImageUtils.createPlaceholderImage(
    product, 
    'medium'
);

// Set as image source
imageElement.src = placeholderImage;
```

### Responsive Images
```html
<!-- Use srcset for different screen sizes -->
<img 
    src="product-medium.png" 
    srcset="product-thumbnail.png 150w,
            product-medium.png 400w,
            product-large.png 800w"
    sizes="(max-width: 600px) 150px,
           (max-width: 1200px) 400px,
           800px"
    alt="Product name">
```

## Best Practices / أفضل الممارسات

### Do's / افعل
- ✅ Use consistent lighting across all products
- ✅ Maintain the same perspective/angle for similar products
- ✅ Include multiple angles for complex products
- ✅ Show scale reference when appropriate
- ✅ Use highest quality source images
- ✅ Test images on different devices
- ✅ Optimize file sizes without losing quality
- ✅ Use descriptive file names (product-name-view.png)
- ✅ Keep backup of original high-resolution images

### Don'ts / لا تفعل
- ❌ Don't stretch or distort images
- ❌ Don't use low-resolution sources
- ❌ Don't over-compress (visible artifacts)
- ❌ Don't mix different styles/backgrounds
- ❌ Don't include text in product images
- ❌ Don't use watermarked images
- ❌ Don't forget to test on retina displays
- ❌ Don't ignore accessibility (alt text)

## Quality Checklist / قائمة التحقق من الجودة

Before publishing any product image, verify:

- [ ] Image meets size requirements
- [ ] Background is clean (transparent or white)
- [ ] Product is centered and properly framed
- [ ] Lighting is even and professional
- [ ] Focus is sharp and clear
- [ ] Colors are accurate
- [ ] File size is optimized
- [ ] No visible compression artifacts
- [ ] Tested on different devices
- [ ] Alt text is descriptive

## Tools and Resources / الأدوات والموارد

### Image Editing Software
1. **Adobe Photoshop** - Professional (paid)
2. **GIMP** - Free alternative
3. **Pixelmator Pro** - Mac (paid)
4. **Affinity Photo** - One-time purchase

### Background Removal
1. **Remove.bg** - https://www.remove.bg
2. **Photoshop** - Pen tool, Select and Mask
3. **GIMP** - Foreground Select tool

### Optimization Tools
1. **TinyPNG** - https://tinypng.com
2. **ImageOptim** - Mac (free)
3. **Squoosh** - https://squoosh.app

### Quality Check
1. View at 100% zoom
2. Test on retina display
3. Compare with other products
4. Get second opinion

## Troubleshooting / استكشاف الأخطاء وإصلاحها

### Problem: Image appears blurry
**Solution:**
- Use higher resolution source
- Check DPI (should be 144+ for retina)
- Don't upscale from smaller images
- Use proper interpolation method

### Problem: File size too large
**Solution:**
- Reduce dimensions if possible
- Increase compression (slightly)
- Convert JPEG to PNG or vice versa
- Remove unnecessary metadata

### Problem: Colors look different on devices
**Solution:**
- Use sRGB color space
- Calibrate your monitor
- Test on target devices
- Avoid extreme saturation

### Problem: Edges look rough after background removal
**Solution:**
- Use higher quality selection tools
- Feather edges slightly (1-2px)
- Refine edge detection
- Manual cleanup with eraser

## Accessibility / إمكانية الوصول

### Alt Text Guidelines
- Be descriptive but concise
- Include color, size, material if relevant
- Don't start with "Image of..." or "Picture of..."
- Include Arabic translation

Example:
```html
<img src="gold-watch.png" 
     alt="Luxury gold watch with leather strap - ساعة ذهبية فاخرة بسير جلدي">
```

## Maintenance / الصيانة

### Regular Reviews
- Monthly: Check all product images
- Quarterly: Update to higher quality if available
- Annually: Review and update standards

### Version Control
- Keep original high-resolution files
- Document any edits made
- Maintain consistent naming convention
- Use version numbers for major changes

---

For questions about image guidelines, contact the design team.
للأسئلة حول إرشادات الصور، اتصل بفريق التصميم.
