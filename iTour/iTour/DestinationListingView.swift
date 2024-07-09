//
//  DestinationListingView.swift
//  iTour
//
//  Created by Brandon Johns on 7/9/24.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    

    
    init(sort: SortDescriptor<Destination>) {
        _destinations = Query(sort: [sort])
    }
    
    init(sort: [SortDescriptor<Destination>], searchString: String, minimumDate: Date) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return $0.date > minimumDate
            } else {
                return  $0.date > minimumDate &&
                ($0.name.localizedStandardContains(searchString) || $0.sights.contains {$0.name.localizedStandardContains(searchString)})
            }
        }, sort: sort)
    }
    
    var body: some View {
        List {
                ForEach(destinations) { destination in
                    NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: [SortDescriptor(\Destination.name)], searchString: "", minimumDate: .distantPast)
}
