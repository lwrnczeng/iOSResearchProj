//
//  Order.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

struct Order : Identifiable, Hashable, Sendable {
    public let id: UUID
    public let items: [Item]
    public let promo: String?
    public let subTotalPrice: Decimal
    
    public struct Item: Identifiable, Hashable, Sendable {
        public let id: UUID
        public let name: String
        public let price: Decimal
        public let quantity: Int
        
    }
    
    init(id: UUID, name: String, items: [Item], promo: String?, subTotalPrice: Decimal) {
        self.id = id
        self.items = items
        self.promo = promo
        self.subTotalPrice = subTotalPrice
    }
    
}
