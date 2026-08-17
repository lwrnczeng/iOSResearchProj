//
//  ProcessPaymentUseCase.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-17.
//
import Foundation

protocol ProcessPaymentUseCaseProtocol {
    func process(orderId: UUID, totalPaid: Decimal) async throws -> PaymentResult
}

class ProcessPaymentUseCase: ProcessPaymentUseCaseProtocol {
//    In Swift, neither private nor public is the default for a property in a class;
//    instead, the default access level is internal
    private let repository: OrderRepositoryProtocol
    
    init(repository: OrderRepositoryProtocol) {
        self.repository = repository
    }
    
    func process(orderId: UUID, totalPaid: Decimal) async throws -> PaymentResult {
        let transactionId = UUID()
        
        // todo: call payment data repository
        try await Task.sleep(nanoseconds: 300_000_000)
        
        return try self.repository.processPayment(transactionId: transactionId,
                                                  orderId: orderId,
                                                  totalPaid: totalPaid)

    }
}
