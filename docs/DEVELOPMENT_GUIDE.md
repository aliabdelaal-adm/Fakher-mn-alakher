# Development Guide for Fakher mn Alakher
# دليل التطوير لفاخر من الآخر

## Table of Contents / جدول المحتويات

1. [Setup and Installation](#setup-and-installation)
2. [Project Architecture](#project-architecture)
3. [Coding Standards](#coding-standards)
4. [Testing](#testing)
5. [Deployment](#deployment)

## Setup and Installation / الإعداد والتثبيت

### iOS Development Environment / بيئة تطوير iOS

#### Requirements / المتطلبات
- macOS 12.0 (Monterey) or later
- Xcode 14.0 or later
- iOS 15.0+ SDK
- Swift 5.7+
- CocoaPods or Swift Package Manager (optional)

#### Initial Setup / الإعداد الأولي

1. **Clone the Repository / استنساخ المستودع**
   ```bash
   git clone https://github.com/aliabdelaal-adm/Fakher-mn-alakher.git
   cd Fakher-mn-alakher
   ```

2. **Create Xcode Project / إنشاء مشروع Xcode**
   ```bash
   # Open Xcode
   open -a Xcode
   
   # Create new project
   # File → New → Project → iOS → App
   # Set Bundle Identifier: com.yourcompany.fakher-mn-alakher
   ```

3. **Add Source Files / إضافة ملفات المصدر**
   - Drag and drop all files from `ios-app/FakherApp/` into Xcode project
   - Ensure "Copy items if needed" is checked
   - Add to target: Fakher mn Alakher

4. **Configure Project Settings / تكوين إعدادات المشروع**
   - Deployment Target: iOS 15.0
   - Swift Language Version: Swift 5
   - Team: Select your Apple Developer team

### Website Development Environment / بيئة تطوير الموقع

#### Requirements / المتطلبات
- Any modern web browser (Chrome, Firefox, Safari, Edge)
- Text editor or IDE (VS Code, Sublime Text, WebStorm)
- Local web server (optional but recommended)

#### Initial Setup / الإعداد الأولي

1. **Navigate to Website Directory / الانتقال إلى دليل الموقع**
   ```bash
   cd website
   ```

2. **Start Local Server / بدء الخادم المحلي**
   
   Using Python:
   ```bash
   python3 -m http.server 8000
   ```
   
   Using Node.js:
   ```bash
   npx http-server -p 8000
   ```
   
   Using PHP:
   ```bash
   php -S localhost:8000
   ```

3. **Open in Browser / فتح في المتصفح**
   ```
   http://localhost:8000
   ```

## Project Architecture / بنية المشروع

### iOS Application Architecture / بنية تطبيق iOS

```
MVC (Model-View-Controller) Pattern

Models/
  └── Product.swift          # Data models
  
Views/
  └── ProductCell.swift      # UI components
  
Controllers/
  ├── MainViewController.swift        # Main screen
  └── ProductDetailViewController.swift  # Detail screen
  
Utils/
  └── ImageProcessor.swift   # Image utilities
  
Delegates/
  ├── AppDelegate.swift      # App lifecycle
  └── SceneDelegate.swift    # Scene lifecycle
```

#### Design Patterns Used / أنماط التصميم المستخدمة

1. **MVC (Model-View-Controller)**
   - Separates data, UI, and logic
   - Easy to maintain and test

2. **Delegate Pattern**
   - UICollectionViewDelegate
   - UICollectionViewDataSource
   - Scene and App delegates

3. **Singleton** (if needed for shared resources)
   - Image cache
   - Network manager

### Website Architecture / بنية الموقع

```
index.html              # Main HTML structure
css/
  └── styles.css        # All styling
js/
  └── app.js           # All JavaScript logic
assets/
  └── images/          # Product images
```

#### Structure / البنية

1. **HTML** - Semantic markup
   - Header with navigation
   - Main content sections
   - Footer
   - Modal for product details

2. **CSS** - BEM-like methodology
   - Organized by component
   - Responsive design
   - CSS variables for theming

3. **JavaScript** - Modular functions
   - Product management
   - Image utilities
   - Event handlers
   - Form validation

## Coding Standards / معايير البرمجة

### Swift Coding Standards / معايير برمجة Swift

#### Naming Conventions / اصطلاحات التسمية

```swift
// Classes and Structs: PascalCase
class ProductManager { }
struct Product { }

// Functions and Variables: camelCase
func loadProducts() { }
var productName: String

// Constants: camelCase (or SCREAMING_SNAKE_CASE for global)
let maxProductCount = 100
let DEFAULT_TIMEOUT = 30

// Enums: PascalCase for type, camelCase for cases
enum ProductCategory {
    case jewelry
    case watches
}
```

#### Code Style / أسلوب الكود

```swift
// Use explicit types when clarity is needed
let price: Double = 29.99

// Use type inference when type is obvious
let products = Product.sampleProducts

// Prefer let over var
let immutableValue = 10
var mutableValue = 20

// Use guard for early returns
guard let product = products.first else {
    return
}

// Use meaningful names
// ✅ Good
func resizeImage(_ image: UIImage, to size: StandardSize) -> UIImage?

// ❌ Bad
func resize(_ i: UIImage, to s: Int) -> UIImage?

// Group related functionality with MARK
// MARK: - UICollectionViewDataSource
// MARK: - UICollectionViewDelegate
// MARK: - Private Methods
```

#### Comments / التعليقات

```swift
// Use comments for "why", not "what"
// ✅ Good
// Use aspect fill to prevent stretching
let ratio = max(widthRatio, heightRatio)

// ❌ Bad
// Calculate ratio
let ratio = max(widthRatio, heightRatio)

// Document public APIs
/// Resizes an image to standard size
/// - Parameters:
///   - image: The source image to resize
///   - size: Target standard size
/// - Returns: Resized image or nil if operation fails
func resizeImage(_ image: UIImage, to size: StandardSize) -> UIImage?
```

### JavaScript Coding Standards / معايير برمجة JavaScript

#### Naming Conventions / اصطلاحات التسمية

```javascript
// Functions and Variables: camelCase
function loadProducts() { }
const productName = 'Watch';

// Constants: SCREAMING_SNAKE_CASE or camelCase
const MAX_PRODUCTS = 100;
const defaultTimeout = 30;

// Classes: PascalCase
class ImageUtils { }

// Objects: camelCase
const product = { };
```

#### Code Style / أسلوب الكود

```javascript
// Use const by default, let when needed, avoid var
const products = [];
let currentPage = 1;

// Use arrow functions for callbacks
products.forEach(product => {
    console.log(product.name);
});

// Use template literals
const message = `Product ${product.name} costs $${product.price}`;

// Use destructuring
const { name, price } = product;

// Use modern array methods
const featured = products.filter(p => p.featured);
const names = products.map(p => p.name);

// Handle errors properly
try {
    const result = riskyOperation();
} catch (error) {
    console.error('Operation failed:', error);
}
```

### CSS Coding Standards / معايير CSS

#### Organization / التنظيم

```css
/* Group related styles */
/* Variables */
:root {
    --primary-color: #1a1a2e;
    --accent-color: #d4af37;
}

/* Global Styles */
* { }
body { }

/* Layout */
.container { }
.grid { }

/* Components */
.navbar { }
.product-card { }

/* Utilities */
.text-center { }
.mt-4 { }

/* Media Queries at the end */
@media (max-width: 768px) { }
```

#### Naming / التسمية

```css
/* Use descriptive class names */
/* ✅ Good */
.product-card { }
.hero-title { }
.submit-button { }

/* ❌ Bad */
.pc { }
.ht { }
.btn { }

/* Use kebab-case */
.product-detail-view { }
```

## Testing / الاختبار

### iOS Testing / اختبار iOS

#### Unit Tests / اختبارات الوحدة

```swift
import XCTest
@testable import FakherApp

class ProductTests: XCTestCase {
    
    func testProductInitialization() {
        let product = Product.sampleProducts.first!
        XCTAssertEqual(product.name, "Luxury Gold Watch")
        XCTAssertEqual(product.price, 2500.00)
    }
    
    func testImageProcessing() {
        let image = UIImage(named: "test-image")!
        let resized = ImageProcessor.resizeImage(image, to: .medium)
        XCTAssertNotNil(resized)
    }
}
```

#### UI Tests / اختبارات واجهة المستخدم

```swift
import XCTest

class FakherAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
    }
    
    func testProductListDisplay() {
        let collectionView = app.collectionViews.firstMatch
        XCTAssertTrue(collectionView.exists)
    }
    
    func testProductDetailNavigation() {
        let firstCell = app.collectionViews.cells.firstMatch
        firstCell.tap()
        
        XCTAssertTrue(app.navigationBars["Luxury Gold Watch"].exists)
    }
}
```

#### Running Tests / تشغيل الاختبارات

```bash
# Run all tests
xcodebuild test -scheme FakherApp -destination 'platform=iOS Simulator,name=iPhone 14'

# Or use Xcode: Product → Test (⌘U)
```

### Website Testing / اختبار الموقع

#### Manual Testing Checklist / قائمة الاختبار اليدوي

- [ ] All pages load correctly
- [ ] Navigation works
- [ ] Product cards display properly
- [ ] Modal opens and closes
- [ ] Form validation works
- [ ] Responsive design on mobile
- [ ] Responsive design on tablet
- [ ] Cross-browser compatibility (Chrome, Firefox, Safari)
- [ ] Images load correctly
- [ ] Arabic text displays properly (RTL)

#### Browser Testing / اختبار المتصفحات

Test on:
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

#### Performance Testing / اختبار الأداء

Use browser DevTools:
- Lighthouse audit
- Network tab (check load times)
- Performance tab (check for bottlenecks)

## Deployment / النشر

### iOS App Deployment / نشر تطبيق iOS

See detailed instructions in `APPLE_STORE_SUBMISSION.md`

Quick steps:
1. Archive the app (Product → Archive)
2. Upload to App Store Connect
3. Configure app information
4. Submit for review
5. Monitor review status

### Website Deployment / نشر الموقع

#### Option 1: Static Hosting / الاستضافة الثابتة

**GitHub Pages**
```bash
# Enable GitHub Pages in repository settings
# Set source to main branch
# Site will be available at: https://username.github.io/Fakher-mn-alakher/
```

**Netlify**
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
cd website
netlify deploy --prod
```

**Vercel**
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
cd website
vercel --prod
```

#### Option 2: Traditional Hosting / الاستضافة التقليدية

1. Choose hosting provider (GoDaddy, Bluehost, etc.)
2. Purchase domain name
3. Upload files via FTP/SFTP
4. Configure DNS settings

### Continuous Integration / التكامل المستمر

#### GitHub Actions Example

```yaml
name: iOS Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Build
      run: xcodebuild -scheme FakherApp -destination 'platform=iOS Simulator,name=iPhone 14' build
    
    - name: Run tests
      run: xcodebuild test -scheme FakherApp -destination 'platform=iOS Simulator,name=iPhone 14'
```

## Performance Optimization / تحسين الأداء

### iOS App Optimization / تحسين تطبيق iOS

1. **Image Optimization**
   ```swift
   // Use compression
   let compressedData = ImageProcessor.compressImage(image, quality: 0.8)
   
   // Cache images
   // Implement image caching to avoid reprocessing
   ```

2. **Memory Management**
   ```swift
   // Use weak references in closures
   { [weak self] in
       self?.handleCallback()
   }
   
   // Implement deinit to clean up resources
   deinit {
       // Clean up
   }
   ```

3. **Asynchronous Loading**
   ```swift
   DispatchQueue.global().async {
       let image = processImage()
       DispatchQueue.main.async {
           imageView.image = image
       }
   }
   ```

### Website Optimization / تحسين الموقع

1. **Minimize HTTP Requests**
   - Combine CSS files
   - Combine JavaScript files
   - Use CSS sprites for icons

2. **Optimize Images**
   - Compress images (TinyPNG, ImageOptim)
   - Use appropriate formats (PNG for transparency, JPEG for photos)
   - Implement lazy loading

3. **Enable Caching**
   ```html
   <!-- Add cache headers -->
   <meta http-equiv="Cache-Control" content="max-age=31536000">
   ```

4. **Minify Resources**
   ```bash
   # Minify CSS
   npx clean-css-cli styles.css -o styles.min.css
   
   # Minify JavaScript
   npx terser app.js -o app.min.js
   ```

## Troubleshooting / استكشاف الأخطاء

### Common iOS Issues / مشاكل iOS الشائعة

**Issue: App crashes on launch**
- Check console for error messages
- Verify all outlets are connected
- Ensure proper initialization order

**Issue: Images not displaying**
- Verify image names in asset catalog
- Check if images are added to target
- Ensure correct size and format

### Common Website Issues / مشاكل الموقع الشائعة

**Issue: Layout breaks on mobile**
- Check media queries
- Test responsive breakpoints
- Verify viewport meta tag

**Issue: JavaScript not working**
- Check browser console for errors
- Verify script loading order
- Test in different browsers

## Resources / الموارد

### iOS Development / تطوير iOS
- Apple Developer Documentation: https://developer.apple.com/documentation/
- Swift.org: https://swift.org
- Ray Wenderlich Tutorials: https://www.raywenderlich.com

### Web Development / تطوير الويب
- MDN Web Docs: https://developer.mozilla.org
- CSS Tricks: https://css-tricks.com
- JavaScript.info: https://javascript.info

### Design Resources / موارد التصميم
- Apple Human Interface Guidelines: https://developer.apple.com/design/
- Material Design: https://material.io
- Dribbble: https://dribbble.com

---

For questions or support, contact the development team.
للأسئلة أو الدعم، اتصل بفريق التطوير.
