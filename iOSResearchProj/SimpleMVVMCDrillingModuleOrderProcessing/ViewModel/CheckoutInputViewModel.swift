//
//  CheckoutInputViewModel.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//

import Foundation
import Combine

@MainActor
class CheckoutInputViewModel: ObservableObject {
    @Published var itemName : String
    @Published var price: Decimal
    @Published var promoCode: String
    @Published var checkoutCoordinator: CheckoutCoordinator
    
    
    init(itemName: String,
         price: Decimal,
         promoCode: String,
         checkoutCoordinator: CheckoutCoordinator) {
        self.itemName = itemName
        self.price = price
        self.promoCode = promoCode
        self.checkoutCoordinator = checkoutCoordinator
    }
}
