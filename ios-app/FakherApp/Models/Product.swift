import Foundation
import UIKit

struct Product: Codable, Identifiable {
    let id: String
    let name: String
    let nameArabic: String
    let description: String
    let descriptionArabic: String
    let price: Double
    let currency: String
    let category: Category
    let imageURL: String
    let images: [String]
    let inStock: Bool
    let featured: Bool
    let rating: Double
    let reviewCount: Int
    
    enum Category: String, Codable {
        case jewelry = "jewelry"
        case watches = "watches"
        case accessories = "accessories"
        case clothing = "clothing"
        case perfumes = "perfumes"
        case bags = "bags"
        
        var displayName: String {
            switch self {
            case .jewelry: return "Jewelry"
            case .watches: return "Watches"
            case .accessories: return "Accessories"
            case .clothing: return "Clothing"
            case .perfumes: return "Perfumes"
            case .bags: return "Bags"
            }
        }
        
        var displayNameArabic: String {
            switch self {
            case .jewelry: return "مجوهرات"
            case .watches: return "ساعات"
            case .accessories: return "إكسسوارات"
            case .clothing: return "ملابس"
            case .perfumes: return "عطور"
            case .bags: return "حقائب"
            }
        }
    }
    
    var formattedPrice: String {
        return String(format: "%.2f %@", price, currency)
    }
    
    static var sampleProducts: [Product] {
        return [
            Product(
                id: "1",
                name: "Luxury Gold Watch",
                nameArabic: "ساعة ذهبية فاخرة",
                description: "Exquisite gold watch with premium craftsmanship",
                descriptionArabic: "ساعة ذهبية رائعة بحرفية متميزة",
                price: 2500.00,
                currency: "USD",
                category: .watches,
                imageURL: "watch1",
                images: ["watch1", "watch1_detail1", "watch1_detail2"],
                inStock: true,
                featured: true,
                rating: 4.8,
                reviewCount: 125
            ),
            Product(
                id: "2",
                name: "Diamond Necklace",
                nameArabic: "عقد الماس",
                description: "Stunning diamond necklace for special occasions",
                descriptionArabic: "عقد ألماس مذهل للمناسبات الخاصة",
                price: 5000.00,
                currency: "USD",
                category: .jewelry,
                imageURL: "necklace1",
                images: ["necklace1", "necklace1_detail1"],
                inStock: true,
                featured: true,
                rating: 5.0,
                reviewCount: 89
            ),
            Product(
                id: "3",
                name: "Designer Handbag",
                nameArabic: "حقيبة يد مصممة",
                description: "Premium leather handbag with elegant design",
                descriptionArabic: "حقيبة يد جلدية فاخرة بتصميم أنيق",
                price: 1800.00,
                currency: "USD",
                category: .bags,
                imageURL: "bag1",
                images: ["bag1", "bag1_detail1", "bag1_detail2"],
                inStock: true,
                featured: false,
                rating: 4.6,
                reviewCount: 67
            )
        ]
    }
}
