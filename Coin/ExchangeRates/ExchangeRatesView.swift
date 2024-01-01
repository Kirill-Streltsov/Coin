//
//  ExchangeRatesView.swift
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

import SwiftUI

struct ExchangeRatesView: View {
    
    @StateObject private var vm = ViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Last Update: \(vm.lastUpdate)")
                HStack {
                    Text("Currency: ")
                    Picker("Currencies", selection: $vm.selectedCurrency) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.rawValue).tag(currency)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Stepper("Number of days: \(vm.infoAge)", value: $vm.infoAge, in: 1...30, onEditingChanged: { changed in
                        vm.updateAge()
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                List(vm.filteredInfo) { item in
                    VStack {
                        HStack {
                            Text("Rate Close:")
                            Spacer()
                            Text("\(item.rateClose, specifier: "%.2f")")
                                .fontWeight(.semibold)
                            
                        }
                        HStack {
                            Text("Date: ")
                            Spacer()
                            Text("9 June, 2001")
                            
                        }
                        .fontWeight(.light)
                        
                        
                    }
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("Coin")
            .toolbar {
                ToolbarItem {
                    Button("Get data", action: vm.getData)
                }
            }
        }
        .onAppear(perform: vm.getData)
    }
}

#Preview {
    ExchangeRatesView()
}
