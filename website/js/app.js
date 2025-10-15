// Product data
const products = [
    {
        id: '1',
        name: 'Luxury Gold Watch',
        nameArabic: 'ساعة ذهبية فاخرة',
        description: 'Exquisite gold watch with premium craftsmanship. Features include water resistance, sapphire crystal, and Swiss movement.',
        descriptionArabic: 'ساعة ذهبية رائعة بحرفية متميزة. تتميز بمقاومة الماء وكريستال ياقوتي وحركة سويسرية.',
        price: 2500.00,
        currency: 'USD',
        category: 'Watches',
        categoryArabic: 'ساعات',
        imageURL: 'placeholder-watch',
        featured: true,
        rating: 4.8,
        reviewCount: 125,
        inStock: true
    },
    {
        id: '2',
        name: 'Diamond Necklace',
        nameArabic: 'عقد الماس',
        description: 'Stunning diamond necklace for special occasions. Crafted with 18k white gold and premium diamonds.',
        descriptionArabic: 'عقد ألماس مذهل للمناسبات الخاصة. مصنوع من ذهب أبيض عيار 18 وألماس فاخر.',
        price: 5000.00,
        currency: 'USD',
        category: 'Jewelry',
        categoryArabic: 'مجوهرات',
        imageURL: 'placeholder-necklace',
        featured: true,
        rating: 5.0,
        reviewCount: 89,
        inStock: true
    },
    {
        id: '3',
        name: 'Designer Handbag',
        nameArabic: 'حقيبة يد مصممة',
        description: 'Premium leather handbag with elegant design. Features multiple compartments and gold-plated hardware.',
        descriptionArabic: 'حقيبة يد جلدية فاخرة بتصميم أنيق. تحتوي على عدة أقسام وقطع معدنية مطلية بالذهب.',
        price: 1800.00,
        currency: 'USD',
        category: 'Bags',
        categoryArabic: 'حقائب',
        imageURL: 'placeholder-bag',
        featured: false,
        rating: 4.6,
        reviewCount: 67,
        inStock: true
    },
    {
        id: '4',
        name: 'Luxury Perfume',
        nameArabic: 'عطر فاخر',
        description: 'Exclusive fragrance with exotic notes. Long-lasting scent perfect for any occasion.',
        descriptionArabic: 'عطر حصري بنفحات غريبة. رائحة طويلة الأمد مثالية لأي مناسبة.',
        price: 350.00,
        currency: 'USD',
        category: 'Perfumes',
        categoryArabic: 'عطور',
        imageURL: 'placeholder-perfume',
        featured: false,
        rating: 4.7,
        reviewCount: 142,
        inStock: true
    },
    {
        id: '5',
        name: 'Silk Scarf',
        nameArabic: 'وشاح حريري',
        description: 'Hand-crafted silk scarf with intricate patterns. Made from 100% pure silk.',
        descriptionArabic: 'وشاح حريري مصنوع يدوياً بنقوش معقدة. مصنوع من حرير نقي 100%.',
        price: 280.00,
        currency: 'USD',
        category: 'Accessories',
        categoryArabic: 'إكسسوارات',
        imageURL: 'placeholder-scarf',
        featured: false,
        rating: 4.5,
        reviewCount: 54,
        inStock: true
    },
    {
        id: '6',
        name: 'Premium Sunglasses',
        nameArabic: 'نظارات شمسية فاخرة',
        description: 'Designer sunglasses with UV protection. Titanium frame with polarized lenses.',
        descriptionArabic: 'نظارات شمسية مصممة بحماية من الأشعة فوق البنفسجية. إطار تيتانيوم بعدسات مستقطبة.',
        price: 450.00,
        currency: 'USD',
        category: 'Accessories',
        categoryArabic: 'إكسسوارات',
        imageURL: 'placeholder-sunglasses',
        featured: true,
        rating: 4.9,
        reviewCount: 98,
        inStock: true
    }
];

// Image processing utilities
const ImageUtils = {
    // Standard sizes (matching iOS app)
    sizes: {
        thumbnail: { width: 150, height: 150 },
        medium: { width: 400, height: 400 },
        large: { width: 800, height: 800 },
        hero: { width: 1200, height: 800 }
    },

    // Create placeholder image with gradient
    createPlaceholderImage(product, size = 'medium') {
        const canvas = document.createElement('canvas');
        const dimensions = this.sizes[size];
        canvas.width = dimensions.width;
        canvas.height = dimensions.height;
        const ctx = canvas.getContext('2d');

        // Create gradient background
        const gradient = ctx.createLinearGradient(0, 0, canvas.width, canvas.height);
        gradient.addColorStop(0, '#e6d7b8');
        gradient.addColorStop(1, '#f2ebe0');
        ctx.fillStyle = gradient;
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        // Add category text
        ctx.fillStyle = '#998866';
        ctx.font = 'bold 32px Arial';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(product.category, canvas.width / 2, canvas.height / 2);

        return canvas.toDataURL();
    },

    // Apply corner radius effect
    applyCornerRadius(imageData, radius) {
        // This would require canvas manipulation
        return imageData;
    }
};

// Initialize products on page load
document.addEventListener('DOMContentLoaded', function() {
    loadProducts();
    initializeModal();
    initializeContactForm();
});

// Load and display products
function loadProducts() {
    const productsGrid = document.getElementById('productsGrid');
    
    products.forEach(product => {
        const productCard = createProductCard(product);
        productsGrid.appendChild(productCard);
    });
}

// Create product card element
function createProductCard(product) {
    const card = document.createElement('div');
    card.className = 'product-card';
    card.onclick = () => showProductDetails(product);

    // Create image
    const img = document.createElement('img');
    img.className = 'product-image';
    img.src = ImageUtils.createPlaceholderImage(product, 'medium');
    img.alt = product.name;

    // Create product info
    const info = document.createElement('div');
    info.className = 'product-info';

    // Category badge
    const category = document.createElement('span');
    category.className = 'product-category';
    category.textContent = product.categoryArabic;

    // Featured badge
    let featuredBadge = '';
    if (product.featured) {
        featuredBadge = '<div class="featured-badge">⭐ مميز</div>';
    }

    // Rating stars
    const ratingStars = createRatingStars(product.rating);

    info.innerHTML = `
        ${category.outerHTML}
        ${featuredBadge}
        <h3 class="product-name">${product.name}</h3>
        <p class="product-name-arabic">${product.nameArabic}</p>
        <div class="product-price">$${product.price.toFixed(2)}</div>
        <div class="product-rating">${ratingStars}</div>
    `;

    card.appendChild(img);
    card.appendChild(info);

    return card;
}

// Create rating stars
function createRatingStars(rating) {
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating - fullStars >= 0.5;
    let stars = '';

    for (let i = 0; i < 5; i++) {
        if (i < fullStars) {
            stars += '⭐';
        } else if (i === fullStars && hasHalfStar) {
            stars += '⭐';
        } else {
            stars += '☆';
        }
    }

    return stars;
}

// Show product details in modal
function showProductDetails(product) {
    const modal = document.getElementById('productModal');
    const modalBody = document.getElementById('modalBody');

    const img = document.createElement('img');
    img.className = 'modal-image';
    img.src = ImageUtils.createPlaceholderImage(product, 'large');
    img.alt = product.name;

    modalBody.innerHTML = `
        ${img.outerHTML}
        <div class="modal-details">
            <span class="product-category">${product.categoryArabic}</span>
            <h2>${product.name}</h2>
            <p style="color: #666; font-size: 1.3rem; margin-bottom: 1rem;">${product.nameArabic}</p>
            <div class="price">$${product.price.toFixed(2)}</div>
            <div class="product-rating" style="margin-bottom: 1rem; font-size: 1.2rem;">
                ${createRatingStars(product.rating)} (${product.reviewCount} تقييم)
            </div>
            <p class="description">${product.descriptionArabic}</p>
            <p class="description" style="color: #999;">${product.description}</p>
            <button class="add-to-cart-btn" onclick="addToCart('${product.id}')">
                أضف إلى السلة
            </button>
        </div>
    `;

    modal.style.display = 'block';
}

// Initialize modal close functionality
function initializeModal() {
    const modal = document.getElementById('productModal');
    const closeBtn = document.querySelector('.close');

    closeBtn.onclick = function() {
        modal.style.display = 'none';
    };

    window.onclick = function(event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    };
}

// Add to cart functionality
function addToCart(productId) {
    const product = products.find(p => p.id === productId);
    if (product) {
        alert(`تمت إضافة ${product.nameArabic} إلى السلة!`);
        document.getElementById('productModal').style.display = 'none';
    }
}

// Scroll to products section
function scrollToProducts() {
    document.getElementById('products').scrollIntoView({ behavior: 'smooth' });
}

// Initialize contact form
function initializeContactForm() {
    const form = document.getElementById('contactForm');
    
    form.onsubmit = function(e) {
        e.preventDefault();
        
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const message = document.getElementById('message').value;

        // Validate form
        if (!name || !email || !message) {
            alert('الرجاء ملء جميع الحقول');
            return;
        }

        // Validate email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('الرجاء إدخال بريد إلكتروني صحيح');
            return;
        }

        // Success message
        alert('شكراً لتواصلك معنا! سنرد عليك قريباً.');
        form.reset();
    };
}
