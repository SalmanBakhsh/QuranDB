//
//  AyasViewAll.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 12/4/20.
//

import SwiftUI

struct AyasViewAll: View {
    @State var searchText: String = ""
    var type: AyasType = .AllSuras
    
    var body: some View {
        VStack {
            TextEditor(text: $searchText)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .frame(height: 50)
            AyasList(filter: searchText)
        }
        .navigationTitle("Ayas")
    }
}

struct AyasViewAll_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
