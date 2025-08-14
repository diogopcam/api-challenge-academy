//
//  CategoryFormatter.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

enum CategoryFormatter {
    case beauty
    case fragrances
    case furniture
    case groceries
    case homeDecoration
    case kitchenAccessories
    case laptops
    case mensShirts
    case mensShoes
    case mensWatches
    case mobileAccessories
    case motorcycle
    case skinCare
    case smartphones
    case sportsAccessories
    case sunglasses
    case tablets
    case tops
    case vehicle
    case womensBags
    case womensDresses
    case womensJewellery
    case womensShoes
    case womensWatches
    case custom(String) // Para novas categorias não mapeadas
    
    init(apiValue: String) {
        switch apiValue {
        case "beauty": self = .beauty
        case "fragrances": self = .fragrances
        case "furniture": self = .furniture
        case "groceries": self = .groceries
        case "home-decoration": self = .homeDecoration
        case "kitchen-accessories": self = .kitchenAccessories
        case "laptops": self = .laptops
        case "mens-shirts": self = .mensShirts
        case "mens-shoes": self = .mensShoes
        case "mens-watches": self = .mensWatches
        case "mobile-accessories": self = .mobileAccessories
        case "motorcycle": self = .motorcycle
        case "skin-care": self = .skinCare
        case "smartphones": self = .smartphones
        case "sports-accessories": self = .sportsAccessories
        case "sunglasses": self = .sunglasses
        case "tablets": self = .tablets
        case "tops": self = .tops
        case "vehicle": self = .vehicle
        case "womens-bags": self = .womensBags
        case "womens-dresses": self = .womensDresses
        case "womens-jewellery": self = .womensJewellery
        case "womens-shoes": self = .womensShoes
        case "womens-watches": self = .womensWatches
        default: self = .custom(apiValue)
        }
    }
    
    var formattedName: String {
        switch self {
        case .beauty: return "Beauty"
        case .fragrances: return "Fragrances"
        case .furniture: return "Furniture"
        case .groceries: return "Groceries"
        case .homeDecoration: return "Home Decoration"
        case .kitchenAccessories: return "Kitchen Accessories"
        case .laptops: return "Laptops"
        case .mensShirts: return "Men's Shirts"
        case .mensShoes: return "Men's Shoes"
        case .mensWatches: return "Men's Watches"
        case .mobileAccessories: return "Mobile Accessories"
        case .motorcycle: return "Motorcycle"
        case .skinCare: return "Skin Care"
        case .smartphones: return "Smartphones"
        case .sportsAccessories: return "Sports Accessories"
        case .sunglasses: return "Sunglasses"
        case .tablets: return "Tablets"
        case .tops: return "Tops"
        case .vehicle: return "Vehicle"
        case .womensBags: return "Women's Bags"
        case .womensDresses: return "Women's Dresses"
        case .womensJewellery: return "Women's Jewellery"
        case .womensShoes: return "Women's Shoes"
        case .womensWatches: return "Women's Watches"
        case .custom(let value):
            // Formatação genérica para novas categorias
            let formatted = value
                .replacingOccurrences(of: "-", with: " ")
                .capitalized
            return formatted
        }
    }
    
    
    var iconName: String {
        switch self {
        case .beauty: return "sparkles"
        case .fragrances: return "sparkle"
        case .furniture: return "chair"
        case .groceries: return "basket"
        case .homeDecoration: return "house"
        case .kitchenAccessories: return "fork.knife"
        case .laptops: return "laptopcomputer"
        case .mensShirts: return "tshirt"
        case .mensShoes: return "shoe"
        case .mensWatches: return "clock"
        case .mobileAccessories: return "iphone"
        case .motorcycle: return "bicycle"
        case .skinCare: return "bandage"
        case .smartphones: return "iphone.gen3"
        case .sportsAccessories: return "sportscourt"
        case .sunglasses: return "glasses"
        case .tablets: return "ipad"
        case .tops: return "tshirt"
        case .vehicle: return "car"
        case .womensBags: return "bag"
        case .womensDresses: return "figure.stand.dress"
        case .womensJewellery: return "diamond"
        case .womensShoes: return "shoe"
        case .womensWatches: return "clock"
        case .custom: return "tag"
        }
    }
}
