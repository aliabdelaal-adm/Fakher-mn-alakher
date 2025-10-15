# Apple App Store Submission Guide
# دليل رفع التطبيق على متجر آبل

## Prerequisites / المتطلبات الأساسية

1. **Apple Developer Account** / حساب مطور آبل
   - Sign up at: https://developer.apple.com
   - Annual fee: $99 USD
   - التسجيل في: https://developer.apple.com
   - الرسوم السنوية: 99 دولار أمريكي

2. **Mac Computer with Xcode** / جهاز ماك مع برنامج Xcode
   - Download Xcode from the Mac App Store
   - Minimum version: Xcode 14.0+
   - تنزيل Xcode من متجر ماك
   - الإصدار الأدنى: Xcode 14.0+

3. **iOS Device for Testing** / جهاز iOS للاختبار
   - iPhone or iPad running iOS 15.0+
   - آيفون أو آيباد يعمل بنظام iOS 15.0+

## Step 1: Prepare the App Bundle / الخطوة 1: تجهيز حزمة التطبيق

### Create Xcode Project / إنشاء مشروع Xcode

1. Open Xcode
2. Create a new project: File → New → Project
3. Choose "App" template
4. Configure project settings:
   - Product Name: `Fakher mn Alakher`
   - Team: Select your Apple Developer team
   - Organization Identifier: `com.yourcompany`
   - Bundle Identifier: `com.yourcompany.fakher-mn-alakher`
   - Language: Swift
   - User Interface: UIKit

### Add Source Files / إضافة ملفات المصدر

Copy all Swift files from the `ios-app/FakherApp/` directory to your Xcode project:
- AppDelegate.swift
- SceneDelegate.swift
- Models/Product.swift
- Controllers/MainViewController.swift
- Controllers/ProductDetailViewController.swift
- Views/ProductCell.swift
- Utils/ImageProcessor.swift

## Step 2: Configure App Information / الخطوة 2: تكوين معلومات التطبيق

### Update Info.plist
Add required permissions and configurations:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to process and display images</string>

<key>NSCameraUsageDescription</key>
<string>We need access to your camera to capture product images</string>
```

### App Icons / أيقونات التطبيق

Create app icons in the following sizes:
- 1024x1024 (App Store)
- 180x180 (iPhone)
- 167x167 (iPad Pro)
- 152x152 (iPad)
- 120x120 (iPhone)
- 87x87 (iPhone)
- 80x80 (iPad)
- 76x76 (iPad)
- 60x60 (iPhone)
- 58x58 (iPhone)
- 40x40 (iPhone/iPad)
- 29x29 (iPhone/iPad)
- 20x20 (iPhone/iPad)

Add all icons to `Assets.xcassets/AppIcon.appiconset/`

## Step 3: Test the App / الخطوة 3: اختبار التطبيق

### Run on Simulator / التشغيل على المحاكي
1. Select a simulator from the device dropdown
2. Press Cmd+R to run
3. Test all features

### Run on Physical Device / التشغيل على جهاز فعلي
1. Connect your iOS device
2. Select it from the device dropdown
3. Click "Run" or press Cmd+R
4. You may need to trust the developer certificate on your device

## Step 4: Archive and Upload / الخطوة 4: الأرشفة والرفع

### Create Archive / إنشاء الأرشيف
1. Select "Any iOS Device" from the device dropdown
2. Menu: Product → Archive
3. Wait for archive to complete
4. Organizer window will open automatically

### Upload to App Store Connect / الرفع إلى App Store Connect
1. In Organizer, select your archive
2. Click "Distribute App"
3. Choose "App Store Connect"
4. Click "Upload"
5. Wait for upload to complete

## Step 5: App Store Connect Configuration / الخطوة 5: تكوين App Store Connect

### Create App Record / إنشاء سجل التطبيق
1. Go to https://appstoreconnect.apple.com
2. Click "My Apps" → "+" → "New App"
3. Fill in the form:
   - Platform: iOS
   - Name: Fakher mn Alakher
   - Primary Language: Arabic
   - Bundle ID: com.yourcompany.fakher-mn-alakher
   - SKU: FAKHER001

### App Information / معلومات التطبيق

#### App Name (English)
```
Fakher mn Alakher
```

#### App Name (Arabic)
```
فاخر من الآخر
```

#### Subtitle (English)
```
Luxury Shopping Experience
```

#### Subtitle (Arabic)
```
تجربة تسوق فاخرة
```

#### Description (English)
```
Discover the finest luxury products with Fakher mn Alakher. Our curated collection features premium watches, jewelry, designer handbags, exclusive perfumes, and elegant accessories.

Features:
• Browse premium luxury products
• Detailed product information with high-quality images
• Easy-to-use interface with Arabic and English support
• Secure shopping experience
• Featured products and special collections
• Product ratings and reviews

Experience luxury shopping at your fingertips with standardized, professional product images and an elegant, sophisticated design.
```

#### Description (Arabic)
```
اكتشف أفخم المنتجات الفاخرة مع فاخر من الآخر. مجموعتنا المختارة تتضمن ساعات راقية، مجوهرات فاخرة، حقائب مصممة، عطور حصرية، وإكسسوارات أنيقة.

المميزات:
• تصفح المنتجات الفاخرة الراقية
• معلومات تفصيلية عن المنتجات مع صور عالية الجودة
• واجهة سهلة الاستخدام بدعم العربية والإنجليزية
• تجربة تسوق آمنة
• منتجات مميزة ومجموعات خاصة
• تقييمات ومراجعات المنتجات

استمتع بتجربة تسوق فاخرة في متناول يدك مع صور منتجات موحدة واحترافية وتصميم أنيق ومتطور.
```

#### Keywords (English)
```
luxury,shopping,fashion,jewelry,watches,designer,premium,handbags,perfumes,accessories
```

#### Keywords (Arabic)
```
فاخر,تسوق,أزياء,مجوهرات,ساعات,مصمم,راقي,حقائب,عطور,إكسسوارات
```

#### Category
- Primary: Shopping
- Secondary: Lifestyle

### Screenshots / لقطات الشاشة

Required screenshot sizes:
- 6.7" Display (iPhone 14 Pro Max): 1290 x 2796
- 6.5" Display (iPhone 11 Pro Max): 1242 x 2688
- 5.5" Display (iPhone 8 Plus): 1242 x 2208
- 12.9" iPad Pro: 2048 x 2732

Take at least 3 screenshots showing:
1. Main product listing page
2. Product detail page
3. Category browsing

### App Preview Video (Optional) / فيديو معاينة التطبيق (اختياري)
- 15-30 seconds
- Show key features
- No audio required

### Privacy Policy / سياسة الخصوصية
You need to provide a privacy policy URL. Create a simple privacy policy page on your website.

### Age Rating / التصنيف العمري
Complete the age rating questionnaire. For a shopping app, typically 4+.

## Step 6: Submit for Review / الخطوة 6: إرسال للمراجعة

### Pre-submission Checklist / قائمة التحقق قبل الإرسال
- [ ] App tested on multiple devices
- [ ] No crashes or bugs
- [ ] All features working correctly
- [ ] Screenshots uploaded
- [ ] App description complete
- [ ] Privacy policy URL provided
- [ ] Age rating completed
- [ ] Contact information provided

### Submit / الإرسال
1. In App Store Connect, go to your app
2. Select the version
3. Click "Submit for Review"
4. Answer the review questions
5. Click "Submit"

## Step 7: Review Process / الخطوة 7: عملية المراجعة

### Timeline / الجدول الزمني
- Initial review: 24-48 hours
- Re-submission after rejection: 24 hours
- Average approval time: 1-3 days

### Common Rejection Reasons / أسباب الرفض الشائعة
1. Incomplete app information
2. Poor app quality or crashes
3. Missing privacy policy
4. Misleading screenshots or description
5. In-app purchase issues

### If Rejected / في حالة الرفض
1. Read the rejection message carefully
2. Fix the issues mentioned
3. Respond to Apple's message
4. Re-submit the app

## Step 8: Post-Approval / الخطوة 8: ما بعد الموافقة

### Release Options / خيارات الإصدار
- **Automatic**: App goes live immediately after approval
- **Manual**: You choose when to release the app
- **Scheduled**: Set a specific date and time for release

### Monitor / المتابعة
- Check crash reports in App Store Connect
- Monitor user reviews and ratings
- Respond to user feedback
- Plan for updates and improvements

## Additional Resources / موارد إضافية

### Apple Documentation
- App Store Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- App Store Connect Help: https://help.apple.com/app-store-connect/
- Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/

### Support
- Apple Developer Support: https://developer.apple.com/support/
- App Store Connect Support: Through App Store Connect
- Developer Forums: https://developer.apple.com/forums/

## Important Notes / ملاحظات مهمة

1. **Keep your app updated**: Regular updates show active maintenance
2. **Respond to reviews**: Engage with your users
3. **Follow guidelines**: Stay compliant with App Store guidelines
4. **Test thoroughly**: Quality is crucial for approval
5. **Be patient**: The review process takes time

## Troubleshooting / استكشاف الأخطاء وإصلاحها

### Common Issues / المشاكل الشائعة

**Issue: "Invalid Bundle Identifier"**
- Solution: Ensure Bundle ID matches in Xcode and App Store Connect

**Issue: "Missing compliance information"**
- Solution: Answer encryption questions during upload

**Issue: "Invalid Provisioning Profile"**
- Solution: Regenerate provisioning profile in developer portal

**Issue: "App crashes on launch"**
- Solution: Test thoroughly on physical devices before submission

---

Good luck with your app submission! / حظاً موفقاً في رفع تطبيقك!

For questions or issues, contact Apple Developer Support.
للأسئلة أو المشاكل، اتصل بدعم مطوري آبل.
