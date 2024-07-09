//
//  ContentView.swift
//  iTour
//
//  Created by Brandon Johns on 7/9/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var sortOrder = [SortDescriptor(\Destination.name)]
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    
    @State private var searchText = ""
    
    @State private var minimumDate = Date.distantPast
    let currentDate = Date.now
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText, minimumDate: minimumDate)
            .navigationTitle("iTour")
            .searchable(text: $searchText)
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Samples", action: addSamples)
                Button("Add Destination", systemImage: "plus", action: addDestination)
                
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag([SortDescriptor(\Destination.name),
                                  SortDescriptor(\Destination.date)
                                 ])
                        Text("Priority")
                            .tag([SortDescriptor(\Destination.priority, order: .reverse), 
                                  SortDescriptor(\Destination.name)])
                        
                        Text("Date")
                            .tag([SortDescriptor(\Destination.date),
                                  SortDescriptor(\Destination.name)])
                    }
                    .pickerStyle(.inline)
                    
                    Picker("Filter", selection: $minimumDate) {
                        Text("Show all destinations")
                            .tag(Date.distantPast)
                        
                        Text("Show upcoming destinations")
                            .tag(currentDate)
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)

    }
    
    
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}

/*
 init(sort: SortDescriptor<Destination>) {
     let now = Date.now

     _destinations = Query(filter: #Predicate {
         $0.date > now
     }, sort: [sort])
 }
 
 init(sort: SortDescriptor<Destination>) {
     _destinations = Query(filter: #Predicate {
         $0.priority >= 2
     }, sort: [sort])
 }
 
 */
