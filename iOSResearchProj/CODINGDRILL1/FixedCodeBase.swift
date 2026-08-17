//
//  FixedCodeBase.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//

import Foundation
import Combine

// MARK: - 1. Thread-Safe Model
/// Model explicitly marked Sendable to cross actor isolation boundaries safely.
public struct TransactionPayload: Codable, Sendable {
    public let id: String
    public let amount: Decimal
    public let encryptedDetails: String
    
    public init(id: String, amount: Decimal, encryptedDetails: String) {
        self.id = id
        self.amount = amount
        self.encryptedDetails = encryptedDetails
    }
}

// MARK: - 2. Actor-Isolated Ledger Database
/// Encapsulates mutable state inside an Actor to ensure mutual exclusion across concurrent threads.
public actor LocalLedgerDatabase {
    private var cache: [String: Decimal] = [:]
    
    public init() {}
    
    public func save(id: String, amount: Decimal) {
        cache[id] = amount
    }
    
    public func getBalance(id: String) -> Decimal {
        return cache[id] ?? 0.0
    }
}

// MARK: - 3. Nonisolated Worker / Utility
/// CPU-bound work isolated from actors to prevent clogging UI execution queues.
public struct DecryptionWorker: Sendable {
    public init() {}
    
    public func decrypt(_ payload: TransactionPayload) async -> Decimal {
        // Suspends thread safely using Task.sleep without blocking the thread
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        return payload.amount
    }
}

// MARK: - 4. Refactored Engine
@MainActor
public final class TransactionEngine: ObservableObject {
    @Published public private(set) var latestBalance: Decimal = 0.0
    @Published public private(set) var processingError: String?
    
    private let database: LocalLedgerDatabase
    private let decryptionWorker: DecryptionWorker
    private var listeningTask: Task<Void, Never>?
    
    public init(
        database: LocalLedgerDatabase = LocalLedgerDatabase(),
        decryptionWorker: DecryptionWorker = DecryptionWorker()
    ) {
        self.database = database
        self.decryptionWorker = decryptionWorker
    }
    
    deinit {
        // Ensure structured task cancellation when Engine is deallocated
        listeningTask?.cancel()
    }
    
    /// Listens to reactive Combine publisher by bridging it to AsyncSequence using Structured Concurrency
    public func startListening(to publisher: AnyPublisher<TransactionPayload, Error>) {
        // Cancel existing task before starting a new stream listener
        listeningTask?.cancel()
        
        listeningTask = Task { [weak self] in
            guard let self = self else { return }
            
            // Bridge Combine publisher to an AsyncSequence stream
            let stream = publisher.values
            
            do {
                for try await payload in stream {
                    // Check task cancellation status
                    guard !Task.isCancelled else { break }
                    
                    // Step A: Decrypt off MainActor safely
                    let decryptedAmount = await self.decryptionWorker.decrypt(payload)
                    
                    // Step B: Write to Actor-isolated Database safely (Off Main Thread)
                    await self.database.save(id: payload.id, amount: decryptedAmount)
                    
                    // Step C: Update MainActor-isolated UI state
                    self.latestBalance += decryptedAmount
                }
            } catch {
                if !Task.isCancelled {
                    self.processingError = error.localizedDescription
                }
            }
        }
    }
}


//Architectural Decision Matrix

//                          IS THERE MUTABLE STATE?
//                                 /       \
//                               YES        NO
//                              /             \
//                 WHERE DOES IT LIVE?     Is it a pure computation/utility?
//                   /             \                 |
//            On the UI?         In Data/IO?     Use a `struct` conforming to `Sendable`
//              /                     \          or a `nonisolated` function.
//     Use `@MainActor`           Use `actor`    (Executes in parallel on the CPU pool)
