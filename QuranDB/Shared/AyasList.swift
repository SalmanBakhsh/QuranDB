//
//  AyasList.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 12/4/20.
//

import SwiftUI

struct AyasList: View {
    var fetchRequest: FetchRequest<Ayas>
    var ayas: FetchedResults<Ayas> {
        fetchRequest.wrappedValue
    }
    
    init(filter: String) {
        if filter == "" {
            fetchRequest = FetchRequest<Ayas>(entity: Ayas.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)])
        } else {
            fetchRequest = FetchRequest<Ayas>(entity: Ayas.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)], predicate: NSPredicate(format: "ayaTextKFGQPC CONTAINS[cd] %@ || ayaTextSimple CONTAINS[cd] %@ || ayaTextUthmani CONTAINS[cd] %@ || ayaID == %@", filter, filter, filter, filter))
            
        }
    }
    
    init(suraNumber: Int, filter: String) {
        if filter == "" {
            fetchRequest = FetchRequest<Ayas>(entity: Ayas.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)], predicate: NSPredicate(format: "suraID == %@", suraNumber))
            
        } else {
            fetchRequest = FetchRequest<Ayas>(entity: Ayas.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)], predicate: NSPredicate(format: "(ayaTextKFGQPC CONTAINS[cd] %@ || ayaTextSimple CONTAINS[cd] %@ || ayaTextUthmani CONTAINS[cd] %@ || ayaID == %@) && suraID == %@", filter, filter, filter, filter, suraNumber))
        }
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue) {aya in
            AyaRow(aya: aya)
        }
    }
}

struct AyasList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
