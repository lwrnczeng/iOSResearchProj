//
//  CheckoutUsecase.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

enum PromoCode {
    .SAVE10
    .SAVE20
    .SAVE30
}

protocol CheckoutUseCaseProtocol {
    func calculateDiscountedPrice(originalPrice: Decimal, promoCode: String) -> Decimal
}

class CheckoutUsecase: CheckoutUseCaseProtocol {
    func calculateDiscountedPrice(originalPrice: Decimal,
                                  promoCode: String) -> Decimal {
        
    }
}
