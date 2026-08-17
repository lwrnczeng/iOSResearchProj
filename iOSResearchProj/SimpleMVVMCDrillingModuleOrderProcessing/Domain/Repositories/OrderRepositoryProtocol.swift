//
//  OrderRepositoryProtocol.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

protocol OrderRepositoryProtocol {
    func submitOrder() -> Order
    func processPayment(transactionId: UUID, orderId: UUID,
                        totalPaid: Decimal) throws -> PaymentResult
}
