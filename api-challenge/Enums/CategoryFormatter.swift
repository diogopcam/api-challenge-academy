//
//  CategoryFormatter.swift
//  api-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import Foundation

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
            case .custom(let value):
                let formatted = value
                    .replacingOccurrences(of: "-", with: " ")
                    .capitalized
                return formatted
            default:
                return stringLocalized
            }
        }

        var stringLocalized: String {
            switch self {
            case .beauty: return String(localized: "Beauty")
            case .fragrances: return String(localized: "Fragrances")
            case .furniture: return String(localized: "Furniture")
            case .groceries: return String(localized: "Groceries")
            case .homeDecoration: return String(localized: "Home Decoration")
            case .kitchenAccessories: return String(localized: "Kitchen Accessories")
            case .laptops: return String(localized: "Laptops")
            case .mensShirts: return String(localized: "Men's Shirts")
            case .mensShoes: return String(localized: "Men's Shoes")
            case .mensWatches: return String(localized: "Men's Watches")
            case .mobileAccessories: return String(localized: "Mobile Accessories")
            case .motorcycle: return String(localized: "Motorcycle")
            case .skinCare: return String(localized: "Skin Care")
            case .smartphones: return String(localized: "Smartphones")
            case .sportsAccessories: return String(localized: "Sports Accessories")
            case .sunglasses: return String(localized: "Sunglasses")
            case .tablets: return String(localized: "Tablets")
            case .tops: return String(localized: "Tops")
            case .vehicle: return String(localized: "Vehicle")
            case .womensBags: return String(localized: "Women's Bags")
            case .womensDresses: return String(localized: "Women's Dresses")
            case .womensJewellery: return String(localized: "Women's Jewellery")
            case .womensShoes: return String(localized: "Women's Shoes")
            case .womensWatches: return String(localized: "Women's Watches")
            case .custom(let value):
                let formatted = value
                    .replacingOccurrences(of: "-", with: " ")
                    .capitalized
                return NSLocalizedString(formatted, comment: "")
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


