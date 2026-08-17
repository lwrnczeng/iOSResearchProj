//
//  Discount.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

struct Discount {
    let code: String
    let percentage: Decimal
    let amountSaved: Decimal
    let finalAmount: Decimal
    
    
    
    
    
    
    
    
    
    
    
    
//  Swift automatically synthesizes a memberwise initializer for structs when you don’t define any custom initializers. That synthesized initializer takes parameters for each stored property in declaration order, with external labels matching the property names.
//    You only need to write a custom init if:
//    • You want different parameter names or ordering.
//    • You want to compute or validate values before assigning to properties.
//    • You want default values or optional parameters that differ from the stored properties.
//    • You want multiple convenience initializers.
    
//    init(code: String, percentage: Decimal, promoCode: String, finalAmount: Decimal) {
//        self.code = code
//        self.percentage = percentage
//        self.promoCode = promoCode
//        self.finalAmount = finalAmount
//    }
}
