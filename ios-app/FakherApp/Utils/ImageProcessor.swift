import UIKit

class ImageProcessor {
    
    // Standard image sizes for the app
    enum StandardSize {
        case thumbnail  // 150x150
        case medium     // 400x400
        case large      // 800x800
        case hero       // 1200x800
        
        var dimensions: CGSize {
            switch self {
            case .thumbnail:
                return CGSize(width: 150, height: 150)
            case .medium:
                return CGSize(width: 400, height: 400)
            case .large:
                return CGSize(width: 800, height: 800)
            case .hero:
                return CGSize(width: 1200, height: 800)
            }
        }
    }
    
    // Resize image to standard size with aspect fill
    static func resizeImage(_ image: UIImage, to size: StandardSize, removeBackground: Bool = false) -> UIImage? {
        let targetSize = size.dimensions
        
        // Calculate aspect ratio
        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height
        let ratio = max(widthRatio, heightRatio)
        
        let newSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        
        // Create a graphics context and draw the resized image
        UIGraphicsBeginImageContextWithOptions(targetSize, !removeBackground, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        if removeBackground {
            // Clear background for transparent images
            let context = UIGraphicsGetCurrentContext()
            context?.clear(CGRect(origin: .zero, size: targetSize))
        }
        
        // Calculate position to center the image
        let x = (targetSize.width - newSize.width) / 2
        let y = (targetSize.height - newSize.height) / 2
        
        image.draw(in: CGRect(x: x, y: y, width: newSize.width, height: newSize.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // Apply corner radius to image
    static func applyCornerRadius(_ image: UIImage, radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: image.size)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
        context?.closePath()
        context?.clip()
        
        image.draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // Add shadow effect to image
    static func addShadow(_ image: UIImage, shadowColor: UIColor = .black, shadowOpacity: Float = 0.3, shadowOffset: CGSize = CGSize(width: 0, height: 4), shadowRadius: CGFloat = 8) -> UIImage? {
        let imageSize = image.size
        let padding: CGFloat = shadowRadius * 2
        let canvasSize = CGSize(width: imageSize.width + padding * 2, height: imageSize.height + padding * 2)
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShadow(offset: shadowOffset, blur: shadowRadius, color: shadowColor.withAlphaComponent(CGFloat(shadowOpacity)).cgColor)
        
        image.draw(in: CGRect(x: padding, y: padding, width: imageSize.width, height: imageSize.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // Compress image for optimal storage
    static func compressImage(_ image: UIImage, quality: CGFloat = 0.8) -> Data? {
        return image.jpegData(compressionQuality: quality)
    }
    
    // Create circular image (perfect for profile pictures)
    static func makeCircular(_ image: UIImage) -> UIImage? {
        let minDimension = min(image.size.width, image.size.height)
        let size = CGSize(width: minDimension, height: minDimension)
        
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.addEllipse(in: CGRect(origin: .zero, size: size))
        context?.closePath()
        context?.clip()
        
        let drawRect = CGRect(x: (size.width - image.size.width) / 2,
                            y: (size.height - image.size.height) / 2,
                            width: image.size.width,
                            height: image.size.height)
        image.draw(in: drawRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
