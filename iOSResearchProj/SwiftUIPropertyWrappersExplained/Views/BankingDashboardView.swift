//
//  BankingDashboardView.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//
import SwiftUI

struct BankingDashboardView: View {
    // 1. @StateObject: THIS View owns the lifecycle of the ViewModel instance.
    // It is created once and preserved across re-evaluations of body.
    @StateObject private var viewModel = DashboardViewModel()
    
    // 2. @State: Private, local value-type state owned by THIS view.
    @State private var isPrivacyModeEnabled: Bool = false
    @State private var selectedAccountForEdit: Account? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Privacy Toggle Control
                Toggle("Hide Balances", isOn: $isPrivacyModeEnabled)
                    .padding()

                // Account List
                List(viewModel.accounts) { account in
                    // Pass a Binding to child view using '$' on @State
                    AccountRowView(account: account, isPrivacyMode: $isPrivacyModeEnabled)
                        .onTapGesture {
                            selectedAccountForEdit = account
                        }
                }
            }
            .navigationTitle("Portfolio")
            .sheet(item: $selectedAccountForEdit) { account in
                // Pass existing ViewModel down to sheet
                AccountEditSheet(viewModel: viewModel, account: account)
            }
        }
    }
}
