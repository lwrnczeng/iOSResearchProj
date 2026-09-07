import SwiftUI

struct DiscountView: View {
    let itemName: String
    let priceText: String
    let quantity: Int

    // Local state for discount inputs
    @State private var discountPercent: Double = 0 // 0-100
    @State private var enableBuyXGetOneFree: Bool = false
    @State private var buyXThreshold: Int = 3
    @State private var isShowingCheckout = false

    // Parse price from text like "$12.34" or "12.34"
    private var unitPrice: Double {
        let digits = priceText.filter { "0123456789.".contains($0) }
        return Double(digits) ?? 0
    }

    private var subtotal: Double {
        unitPrice * Double(quantity)
    }

    // Percentage discount amount
    private var percentageDiscountAmount: Double {
        subtotal * (discountPercent / 100.0)
    }

    // Buy X get 1 free discount (every full group of X gives 1 free item)
    private var bxgyDiscountAmount: Double {
        guard enableBuyXGetOneFree, buyXThreshold > 0 else { return 0 }
        let freeItems = quantity / buyXThreshold
        return Double(freeItems) * unitPrice
    }

    private var totalDiscount: Double {
        min(percentageDiscountAmount + bxgyDiscountAmount, subtotal)
    }

    private var total: Double {
        max(subtotal - totalDiscount, 0)
    }

    private func currency(_ value: Double) -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f.string(from: NSNumber(value: value)) ?? String(format: "$%.2f", value)
    }

    var body: some View {
        Form {
            Section(header: Text("Order Summary")) {
                HStack {
                    Text("Item")
                    Spacer()
                    Text(itemName)
                }
                HStack {
                    Text("Price")
                    Spacer()
                    Text(priceText)
                }
                HStack {
                    Text("Quantity")
                    Spacer()
                    Text("\(quantity)")
                }
            }
            Section(header: Text("Discount")) {
                // Inputs
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Percent")
                        Spacer()
                        Slider(value: $discountPercent, in: 0...100, step: 1) {
                            Text("Percent")
                        }
                        .frame(width: 140)
                        Text("\(Int(discountPercent))%")
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }

                    Toggle(isOn: $enableBuyXGetOneFree) {
                        Text("Buy X Get 1 Free")
                    }

                    if enableBuyXGetOneFree {
                        HStack {
                            Text("X threshold")
                            Spacer()
                            Stepper(value: $buyXThreshold, in: 1...20) {
                                Text("\(buyXThreshold)")
                                    .monospacedDigit()
                            }
                            .labelsHidden()
                        }
                    }
                }

                // Results
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text(currency(subtotal))
                            .monospacedDigit()
                    }
                    HStack {
                        Text("Discounts")
                        Spacer()
                        Text("-" + currency(totalDiscount))
                            .foregroundStyle(.red)
                            .monospacedDigit()
                    }
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text(currency(total))
                            .font(.headline)
                            .monospacedDigit()
                    }
                   
                }
            }
            Section {
                Button {
                    isShowingCheckout = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Checkout")
                            .font(.headline)
                        Spacer()
                    }
                }
                .navigationDestination(isPresented: $isShowingCheckout) {
                    CheckoutSummaryView(
                        itemName: itemName,
                        unitPrice: unitPrice,
                        quantity: quantity,
                        discountPercent: discountPercent,
                        enableBuyXGetOneFree: enableBuyXGetOneFree,
                        buyXThreshold: buyXThreshold,
                        subtotal: subtotal,
                        totalDiscount: totalDiscount,
                        total: total
                    )
                }
            }
           
        }
        .navigationTitle("Discount")
    }
}
