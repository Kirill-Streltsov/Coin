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
            List {
                headerView
                ForEach(vm.filteredInfo) { item in
                    VStack {
                        HStack {
                            Text("Rate Open: ")
                            Spacer()
                            Text("\(item.rateOpen, specifier: "%.2f")")
                                .fontWeight(.semibold)
                            
                        }
                        HStack {
                            Text("Date: ")
                            Spacer()
                            Text(DateConverter.convertDateString(item.timeOpen, shouldBeShort: true))
                        }
                        .fontWeight(.light)
                    }
                }
                
                
            }
            .listStyle(.plain)
            .navigationTitle("Coin")
            .toolbar {
                ToolbarItem {
                    Button("Refresh", action: vm.getDataFromAPI)
                }
            }
        }
        .onAppear {
            vm.getDataFromFileSystem()
            vm.getDataFromAPI()
        }
    }
    
    var headerView: some View {
        VStack {
            HStack {
                Text("Last Update: \(vm.lastUpdate)")
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Currency: ")
                Picker(selection: $vm.selectedCurrency) {
                    ForEach(Currency.allCases) { currency in
                        Text(currency.rawValue).tag(currency)
                    }
                } label: {
                    EmptyView()
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
        }
        
    }
}


#Preview {
    ExchangeRatesView()
}
