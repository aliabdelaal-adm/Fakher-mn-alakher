import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let featuredBadge: UILabel = {
        let label = UILabel()
        label.text = "⭐ Featured"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor(red: 0.9, green: 0.6, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(ratingView)
        containerView.addSubview(featuredBadge)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            productImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            productImageView.heightAnchor.constraint(equalToConstant: 150),
            
            featuredBadge.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            featuredBadge.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 8),
            featuredBadge.widthAnchor.constraint(equalToConstant: 80),
            featuredBadge.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            ratingView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            ratingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            ratingView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "$\(String(format: "%.0f", product.price))"
        
        // Set placeholder image (in a real app, load from URL)
        productImageView.image = createPlaceholderImage(for: product)
        
        // Show/hide featured badge
        featuredBadge.isHidden = !product.featured
        
        // Setup rating stars
        setupRating(product.rating)
    }
    
    private func setupRating(_ rating: Double) {
        ratingView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let fullStars = Int(rating)
        let hasHalfStar = rating - Double(fullStars) >= 0.5
        
        for i in 0..<5 {
            let starLabel = UILabel()
            starLabel.font = UIFont.systemFont(ofSize: 12)
            if i < fullStars {
                starLabel.text = "⭐"
            } else if i == fullStars && hasHalfStar {
                starLabel.text = "⭐"
            } else {
                starLabel.text = "☆"
            }
            ratingView.addArrangedSubview(starLabel)
        }
    }
    
    private func createPlaceholderImage(for product: Product) -> UIImage? {
        let size = CGSize(width: 300, height: 300)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        
        // Create gradient background
        let colors = [
            UIColor(red: 0.9, green: 0.85, blue: 0.7, alpha: 1.0).cgColor,
            UIColor(red: 0.95, green: 0.9, blue: 0.8, alpha: 1.0).cgColor
        ]
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)!
        context?.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: size.width, y: size.height), options: [])
        
        // Add product category text
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor(red: 0.6, green: 0.5, blue: 0.4, alpha: 1.0)
        ]
        
        let text = product.category.displayName
        let textSize = (text as NSString).size(withAttributes: attributes)
        let textRect = CGRect(x: (size.width - textSize.width) / 2,
                            y: (size.height - textSize.height) / 2,
                            width: textSize.width,
                            height: textSize.height)
        (text as NSString).draw(in: textRect, withAttributes: attributes)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
