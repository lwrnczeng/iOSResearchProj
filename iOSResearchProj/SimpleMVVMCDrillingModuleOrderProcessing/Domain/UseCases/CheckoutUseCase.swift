//
//  CalculateDiscountUseCase.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

enum DiscountError: Error, LocalizedError {
    case invalidPromoCode
    case subtotalTooLow
    
    // computed properties
    var errorDescription: String {
        switch self {
        case .invalidPromoCode:
            return "invalid PromoCode"
        case .subtotalTooLow:
            return "subtotal TooLow"
        }
    }
}

protocol CalculateDiscountUseCaseProtocol {
    func calculateDiscountedPrice(subtotal: Decimal, promoCode: String) throws -> Discount
}

class CalculateDiscountUseCase: CalculateDiscountUseCaseProtocol {
    func calculateDiscountedPrice(subtotal: Decimal,
                                  promoCode: String) throws -> Discount {
        
        guard subtotal > 0 else {
            throw DiscountError.subtotalTooLow
        }
        
        let percentage: Decimal
        let cleanedPromoCode = promoCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        switch cleanedPromoCode {
        case "SAVE10":
            percentage = 0.10
        case "SAVE20":
            percentage = 0.20
        case "SAVE30":
            percentage = 0.30
        default:
            throw DiscountError.invalidPromoCode
        }
        
        // calculate
        let amountSaved = subtotal * percentage
        let finalAmount = subtotal - amountSaved
        
        return Discount(code: cleanedPromoCode, percentage: percentage, amountSaved: amountSaved,
                        finalAmount: finalAmount)
    }
}
