# Fakher mn Alakher (فاخر من الآخر)

A premium luxury shopping application and website featuring standardized product images and an elegant user experience.

## 🌟 Features

### iOS Application
- **Modern Swift UI**: Built with UIKit and modern iOS design patterns
- **Standardized Images**: All product images are processed to uniform sizes
- **Image Processing Utilities**: Built-in tools for resizing, removing backgrounds, and applying effects
- **Bilingual Support**: Arabic and English product information
- **Product Categories**: Watches, Jewelry, Bags, Perfumes, Accessories, and Clothing
- **Product Details**: Comprehensive product pages with ratings and reviews
- **Elegant Design**: Premium UI with shadows, rounded corners, and smooth animations

### Website
- **Responsive Design**: Works perfectly on desktop, tablet, and mobile
- **RTL Support**: Right-to-left layout for Arabic content
- **Modern CSS**: Gradients, animations, and smooth transitions
- **Interactive Product Cards**: Click to view detailed product information
- **Modal Product Details**: Elegant popup for product information
- **Contact Form**: Easy communication with validation
- **Image Processing**: JavaScript utilities for consistent image display

### Image Standardization
All images are processed to these standard sizes:
- **Thumbnail**: 150x150px (for lists and previews)
- **Medium**: 400x400px (for product cards)
- **Large**: 800x800px (for detail views)
- **Hero**: 1200x800px (for featured products)

Image features:
- ✅ Uniform dimensions
- ✅ No backgrounds (transparent PNG support)
- ✅ Rounded corners
- ✅ Shadow effects
- ✅ Optimized compression
- ✅ Aspect ratio preservation

## 📁 Project Structure

```
Fakher-mn-alakher/
├── ios-app/                    # iOS Swift Application
│   └── FakherApp/
│       ├── AppDelegate.swift
│       ├── SceneDelegate.swift
│       ├── Info.plist
│       ├── Controllers/
│       │   ├── MainViewController.swift
│       │   └── ProductDetailViewController.swift
│       ├── Views/
│       │   └── ProductCell.swift
│       ├── Models/
│       │   └── Product.swift
│       └── Utils/
│           └── ImageProcessor.swift
│
├── website/                    # Website Files
│   ├── index.html             # Main HTML page
│   ├── css/
│   │   └── styles.css         # Styling
│   └── js/
│       └── app.js             # JavaScript functionality
│
└── docs/                       # Documentation
    ├── APPLE_STORE_SUBMISSION.md
    └── README.md

```

## 🚀 Getting Started

### iOS App Setup

#### Prerequisites
- macOS with Xcode 14.0 or later
- iOS 15.0+ target device or simulator
- Apple Developer account (for device testing and App Store submission)

#### Steps
1. Open Xcode
2. Create a new iOS App project
3. Set the following:
   - Product Name: `Fakher mn Alakher`
   - Bundle Identifier: `com.yourcompany.fakher-mn-alakher`
   - Language: Swift
   - User Interface: UIKit
4. Copy all files from `ios-app/FakherApp/` to your project
5. Build and run (⌘R)

### Website Setup

#### Prerequisites
- Any modern web browser
- A web server (optional, for hosting)

#### Steps
1. Navigate to the `website/` directory
2. Open `index.html` in your web browser
3. Or host on a web server:
   ```bash
   cd website
   python3 -m http.server 8000
   # Visit http://localhost:8000
   ```

## 📱 iOS App Features

### Image Processing
The `ImageProcessor` class provides powerful image manipulation:

```swift
// Resize to standard size
let resized = ImageProcessor.resizeImage(image, to: .medium)

// Make circular (for profiles)
let circular = ImageProcessor.makeCircular(image)

// Add corner radius
let rounded = ImageProcessor.applyCornerRadius(image, radius: 16)

// Add shadow
let shadowed = ImageProcessor.addShadow(image)

// Compress for storage
let compressed = ImageProcessor.compressImage(image, quality: 0.8)
```

### Product Model
Products are structured with bilingual support:

```swift
struct Product {
    let name: String              // English name
    let nameArabic: String        // Arabic name
    let description: String       // English description
    let descriptionArabic: String // Arabic description
    let price: Double
    let category: Category
    // ... more fields
}
```

## 🌐 Website Features

### Image Utilities
JavaScript utilities for consistent image display:

```javascript
// Create standardized placeholder
ImageUtils.createPlaceholderImage(product, 'medium')

// Standard sizes available
ImageUtils.sizes = {
    thumbnail: { width: 150, height: 150 },
    medium: { width: 400, height: 400 },
    large: { width: 800, height: 800 },
    hero: { width: 1200, height: 800 }
}
```

### Product Management
Easy product data management:

```javascript
const product = {
    name: 'Luxury Gold Watch',
    nameArabic: 'ساعة ذهبية فاخرة',
    price: 2500.00,
    category: 'Watches',
    // ... more fields
}
```

## 🎨 Design Philosophy

### Color Scheme
- **Primary**: Dark blue (#1a1a2e, #16213e) - Sophistication
- **Accent**: Gold (#d4af37, #b8960f) - Luxury
- **Background**: Light gray gradients - Clean and modern
- **Text**: Dark gray (#333) - Readability

### Typography
- **Headers**: Bold, large sizes for impact
- **Body**: Clean, readable fonts
- **Arabic**: Right-to-left layout with appropriate fonts

### User Experience
- **Smooth animations**: All interactions are fluid
- **Clear hierarchy**: Important information stands out
- **Consistent spacing**: Professional layout
- **Responsive design**: Works on all devices

## 📊 Product Categories

1. **Watches** (ساعات)
   - Luxury timepieces
   - Swiss movements
   - Premium materials

2. **Jewelry** (مجوهرات)
   - Diamonds and precious stones
   - Gold and platinum
   - Custom designs

3. **Bags** (حقائب)
   - Designer handbags
   - Premium leather
   - Limited editions

4. **Perfumes** (عطور)
   - Exclusive fragrances
   - Long-lasting scents
   - Luxury brands

5. **Accessories** (إكسسوارات)
   - Scarves and ties
   - Sunglasses
   - Belts and wallets

6. **Clothing** (ملابس)
   - Designer fashion
   - Premium fabrics
   - Tailored fits

## 🔧 Technical Details

### iOS Technologies
- **Swift 5.0+**
- **UIKit** for user interface
- **Core Graphics** for image processing
- **Auto Layout** for responsive design
- **Compositional Layout** for flexible collections

### Web Technologies
- **HTML5** with semantic markup
- **CSS3** with modern features (Grid, Flexbox, Gradients)
- **JavaScript ES6+** with modern syntax
- **Canvas API** for image processing
- **Responsive Design** with media queries

### Image Processing
- Standardized dimensions
- Aspect ratio preservation
- Quality optimization
- Transparent backgrounds
- Professional effects

## 📤 Apple Store Submission

Detailed instructions are available in `docs/APPLE_STORE_SUBMISSION.md`

Quick checklist:
- [ ] Apple Developer account
- [ ] App icons (all required sizes)
- [ ] Screenshots (all device sizes)
- [ ] App description (English and Arabic)
- [ ] Privacy policy
- [ ] Testing on physical devices
- [ ] Age rating completion

## 🐛 Error Handling

### iOS App
- Graceful fallbacks for missing images
- Input validation
- Network error handling
- Memory management

### Website
- Form validation
- Email format checking
- Responsive error messages
- Browser compatibility checks

## 🔒 Security

- No hardcoded credentials
- Input sanitization
- Secure form submission
- Privacy-compliant data handling

## 📈 Future Enhancements

- [ ] Backend integration with API
- [ ] Real image loading from CDN
- [ ] User authentication
- [ ] Shopping cart functionality
- [ ] Payment integration
- [ ] Order tracking
- [ ] Push notifications (iOS)
- [ ] Wishlist feature
- [ ] Product search and filtering
- [ ] Multi-language support (more languages)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

Copyright © 2024 Fakher mn Alakher. All rights reserved.

## 📞 Support

For questions or support:
- Create an issue in the repository
- Contact through the website contact form
- Email: support@fakher-mn-alakher.com

## 🙏 Acknowledgments

- Apple Human Interface Guidelines
- Swift and iOS development community
- Web design best practices

---

**Built with ❤️ for luxury shopping**

Made in 2024 | فاخر من الآخر