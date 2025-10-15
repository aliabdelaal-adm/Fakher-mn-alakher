# Quick Start Guide / دليل البدء السريع
## Fakher mn Alakher - فاخر من الآخر

Welcome! This guide will help you get started with the Fakher mn Alakher project quickly.

مرحباً! سيساعدك هذا الدليل في البدء بمشروع فاخر من الآخر بسرعة.

---

## 🚀 Quick Start for Website / البدء السريع للموقع

### Option 1: Python (Recommended / الموصى به)

```bash
# Navigate to website directory
cd website

# Start server
python3 -m http.server 8000

# Open in browser
# Visit: http://localhost:8000
```

### Option 2: Node.js

```bash
# Install http-server globally
npm install -g http-server

# Navigate to website directory
cd website

# Start server
http-server -p 8000

# Open in browser
# Visit: http://localhost:8000
```

### Option 3: PHP

```bash
# Navigate to website directory
cd website

# Start server
php -S localhost:8000

# Open in browser
# Visit: http://localhost:8000
```

### Option 4: Direct File Access

Simply open `website/index.html` in your browser. However, some features may not work without a server.

---

## 📱 Quick Start for iOS App / البدء السريع لتطبيق iOS

### Prerequisites / المتطلبات
- macOS with Xcode 14.0+
- Apple Developer account (for device testing)

### Steps / الخطوات

1. **Open Xcode / افتح Xcode**
   ```bash
   open -a Xcode
   ```

2. **Create New Project / أنشئ مشروع جديد**
   - File → New → Project
   - Choose: iOS → App
   - Product Name: `Fakher mn Alakher`
   - Interface: UIKit
   - Language: Swift

3. **Add Source Files / أضف ملفات المصدر**
   - Drag all files from `ios-app/FakherApp/` into your project
   - Check "Copy items if needed"
   - Add to target

4. **Configure Info.plist / اضبط Info.plist**
   - Replace the default Info.plist with the one provided

5. **Run / شغّل**
   - Select a simulator or device
   - Press ⌘R or click Run button

---

## 📂 Project Structure / هيكل المشروع

```
Fakher-mn-alakher/
├── ios-app/           # iOS Swift Application
│   └── FakherApp/     # App source files
├── website/           # Website files
│   ├── index.html     # Main page
│   ├── privacy.html   # Privacy policy
│   ├── css/          # Styles
│   └── js/           # JavaScript
├── docs/             # Documentation
│   ├── APPLE_STORE_SUBMISSION.md
│   ├── DEVELOPMENT_GUIDE.md
│   └── IMAGE_GUIDELINES.md
└── README.md         # Main documentation
```

---

## 🎯 Key Features / المميزات الرئيسية

### Website / الموقع
✅ Responsive design (mobile, tablet, desktop)
✅ Arabic and English support (RTL/LTR)
✅ Product showcase with modal details
✅ Contact form with validation
✅ Modern animations and effects
✅ Standardized product images

### iOS App / تطبيق iOS
✅ Product catalog with grid layout
✅ Detailed product pages
✅ Bilingual support (AR/EN)
✅ Image processing utilities
✅ Professional UI design
✅ Custom product cells

---

## 🔧 Testing / الاختبار

### Test Website / اختبر الموقع

1. **Homepage / الصفحة الرئيسية**
   - Check if all products load
   - تحقق من تحميل جميع المنتجات

2. **Product Modal / نافذة المنتج**
   - Click any product card
   - انقر على أي بطاقة منتج
   - Verify modal opens with details
   - تحقق من فتح النافذة مع التفاصيل

3. **Navigation / التنقل**
   - Test all navigation links
   - اختبر جميع روابط التنقل
   - Check smooth scrolling
   - تحقق من التمرير السلس

4. **Contact Form / نموذج الاتصال**
   - Fill in all fields
   - املأ جميع الحقول
   - Submit form
   - أرسل النموذج
   - Check validation
   - تحقق من التحقق

5. **Responsive Design / التصميم المتجاوب**
   - Test on mobile size (< 768px)
   - Test on tablet size (768px - 1024px)
   - Test on desktop size (> 1024px)

### Test iOS App / اختبر تطبيق iOS

1. **Build / البناء**
   ```
   Product → Build (⌘B)
   ```

2. **Run on Simulator / التشغيل على المحاكي**
   ```
   Product → Run (⌘R)
   ```

3. **Test Features / اختبر المميزات**
   - Product list displays correctly
   - Product details open on tap
   - Images render properly
   - Navigation works smoothly

---

## 📸 Screenshots / لقطات الشاشة

### Website Homepage / الصفحة الرئيسية للموقع
![Website Homepage](https://github.com/user-attachments/assets/51f26df2-e54b-4fb4-9349-d3d19b2ade4a)

### Product Detail Modal / نافذة تفاصيل المنتج
![Product Modal](https://github.com/user-attachments/assets/66da634e-7c59-4931-b2ea-b50130399dab)

---

## 📖 Documentation / التوثيق

For detailed information, see:
لمزيد من المعلومات التفصيلية، راجع:

- [README.md](README.md) - Project overview / نظرة عامة على المشروع
- [DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md) - Development guide / دليل التطوير
- [APPLE_STORE_SUBMISSION.md](docs/APPLE_STORE_SUBMISSION.md) - App Store guide / دليل متجر التطبيقات
- [IMAGE_GUIDELINES.md](docs/IMAGE_GUIDELINES.md) - Image standards / معايير الصور
- [CHANGELOG.md](CHANGELOG.md) - Version history / سجل الإصدارات

---

## 🆘 Common Issues / المشاكل الشائعة

### Website Issues / مشاكل الموقع

**Issue: Images not showing**
- Make sure you're running a web server
- تأكد من تشغيل خادم ويب

**Issue: Modal not opening**
- Check browser console for errors
- تحقق من وحدة تحكم المتصفح للأخطاء
- Verify JavaScript is enabled
- تحقق من تمكين JavaScript

### iOS App Issues / مشاكل تطبيق iOS

**Issue: Build fails**
- Check Swift version (should be 5.0+)
- تحقق من إصدار Swift (يجب أن يكون 5.0+)
- Verify all files are added to target
- تحقق من إضافة جميع الملفات إلى الهدف

**Issue: Simulator not loading**
- Restart Xcode
- أعد تشغيل Xcode
- Clean build folder (⇧⌘K)
- نظف مجلد البناء (⇧⌘K)

---

## 🎨 Customization / التخصيص

### Change Colors / تغيير الألوان

**Website CSS:**
```css
/* Edit website/css/styles.css */
:root {
    --primary-color: #1a1a2e;  /* Dark blue */
    --accent-color: #d4af37;   /* Gold */
}
```

**iOS Swift:**
```swift
// Edit color values in view controllers
let primaryColor = UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0)
let accentColor = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)
```

### Add New Products / إضافة منتجات جديدة

**Website:**
```javascript
// Edit website/js/app.js
const products = [
    // Add new product here
    {
        id: '7',
        name: 'New Product',
        nameArabic: 'منتج جديد',
        price: 999.00,
        // ... other fields
    }
];
```

**iOS:**
```swift
// Edit ios-app/FakherApp/Models/Product.swift
static var sampleProducts: [Product] {
    return [
        // Add new product here
        Product(
            id: "7",
            name: "New Product",
            nameArabic: "منتج جديد",
            // ... other fields
        )
    ]
}
```

---

## 🚀 Next Steps / الخطوات التالية

1. ✅ Test the website locally
2. ✅ Test the iOS app in simulator
3. ✅ Review documentation
4. 📝 Customize products and branding
5. 🎨 Adjust colors and styling
6. 📸 Replace placeholder images with real products
7. 🌐 Deploy website to hosting
8. 🍎 Submit iOS app to App Store

---

## 📞 Support / الدعم

For help and questions:
للمساعدة والأسئلة:

- 📧 Email: support@fakher-mn-alakher.com
- 💬 Create an issue on GitHub
- 📚 Check documentation in `docs/` folder

---

## ⭐ Features Coming Soon / مميزات قادمة

- [ ] Backend API integration
- [ ] User authentication
- [ ] Shopping cart
- [ ] Payment processing
- [ ] Order tracking
- [ ] Push notifications
- [ ] Wishlist
- [ ] Product search

---

**Happy coding! / برمجة سعيدة!** 🎉

Built with ❤️ for luxury shopping
صنع بـ ❤️ للتسوق الفاخر
