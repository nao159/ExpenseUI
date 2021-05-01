//
//  ContentView.swift
//  ExpenseUI
//
//  Created by Максим Нуждин on 30.04.2021.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let name: String
    let id = UUID()
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    let defaults = UserDefaults.standard
    @State private var showingAddNewItem = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text("\(item.name)")
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("ExpenseUI")
            .navigationBarItems(leading:
                                    Button(action: {
                                        showingAddNewItem.toggle()
                                    }, label: {
                                        Image(systemName: "plus")
                                    }
                                    ).sheet(isPresented: $showingAddNewItem, content: {
                                        AddView(expenses: expenses)
                                    })
            )
        }
    }
    func removeItems(offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
