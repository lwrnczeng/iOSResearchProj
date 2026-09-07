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
    @Published var priceText: String
    @Published var quantity: Int = 1
    @Published var checkoutCoordinator: CheckoutCoordinator
    
    init(itemName: String,
         priceText: String,
         quantity: Int,
         checkoutCoordinator: CheckoutCoordinator) {
        self.itemName = itemName
        self.priceText = priceText
        self.quantity = quantity
        self.checkoutCoordinator = checkoutCoordinator
    }
    
}
