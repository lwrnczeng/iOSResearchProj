//
//  TheFlawedCodeBase.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//
//
//import Combine
//import Foundation
//
//// MARK: - Models & Services
//public struct TransactionPayload: Codable {
//    public let id: String
//    public let amount: Decimal
//    public let encryptedDetails: String
//}
//
//public class LocalLedgerDatabase {
//    private var cache: [String: Decimal] = [:]
//    
//    // Simulates synchronous local disk write
//    public func save(id: String, amount: Decimal) {
//        cache[id] = amount
//    }
//    
//    public func getBalance(id: String) -> Decimal {
//        return cache[id] ?? 0.0
//    }
//}
//
//// MARK: - Legacy Engine (Target for Refactoring)
//@MainActor
//public class TransactionEngine: ObservableObject {
//    @Published public private(set) var latestBalance: Decimal = 0.0
//    @Published public private(set) var processingError: String?
//
//    private let database = LocalLedgerDatabase()
//    private var cancellables = Set<AnyCancellable>()
//
//    // Incoming transaction stream from WebSocket / Network layer
//    public func startListening(
//        to publisher: AnyPublisher<TransactionPayload, Error>
//    ) {
//        publisher
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { completion in
//                    if case .failure(let error) = completion {
//                        self.processingError = error.localizedDescription
//                    }
//                },
//                receiveValue: { payload in
//                    // Heavy decryption work done synchronously on MainActor!
//                    let decryptedAmount = self.decryptPayload(payload)
//
//                    // Writing to database synchronously on MainActor!
//                    self.database.save(id: payload.id, amount: decryptedAmount)
//
//                    // Update state
//                    self.latestBalance += decryptedAmount
//                }
//            )
//            .store(in: &cancellables)
//    }
//
//    private func decryptPayload(_ payload: TransactionPayload) -> Decimal {
//        // Simulates heavy CPU-bound decryption delay (blocking thread)
//        Thread.sleep(forTimeInterval: 0.5)
//        return payload.amount
//    }
//}
