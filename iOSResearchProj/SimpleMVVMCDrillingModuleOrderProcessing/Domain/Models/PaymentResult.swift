//
//  PaymentResult.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

enum PaymentStatus: String {
    case pending
    case success
    case failed
}

struct PaymentResult: Hashable, Sendable {
    let transactionId: UUID
    let orderId: UUID
    let totalPaid: Decimal
    let timeStamp: Date
    let status: PaymentStatus
}

