//
//  WordsList.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 12/4/20.
//

import SwiftUI

struct WordsList: View {
    var fetchRequest: FetchRequest<Words>
    var ayas: FetchedResults<Words> {
        fetchRequest.wrappedValue
    }
    
    init(filter: String) {
        if filter == "" {
            fetchRequest = FetchRequest<Words>(entity: Words.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Words.index, ascending: true)])
        } else {
            fetchRequest = FetchRequest<Words>(entity: Words.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Words.index, ascending: true)], predicate: NSPredicate(format: "wordTextKFGQPC CONTAINS[cd] %@ || wordTextSimple CONTAINS[cd] %@ || wordTextUthmani CONTAINS[cd] %@ || root CONTAINS[cd] %@ || index == %@", filter, filter, filter, filter, filter))
        }
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue) {word in
            WordRow(word: word)
        }
    }
}

struct WordsList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
