//
//  AccountEditSheet.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//

import SwiftUI

struct AccountEditSheet: View {
    // 4. @ObservedObject: Does NOT own the ViewModel lifecycle.
    // It receives a reference created upstream (@StateObject in Parent).
    @ObservedObject var viewModel: DashboardViewModel
    let account: Account
    
    @State private var newName: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            TextField("Account Name", text: $newName)
            Button("Save") {
                viewModel.updateAccountName(id: account.id, newName: newName)
                dismiss()
            }
        }
        .onAppear {
            newName = account.name
        }
    }
}
