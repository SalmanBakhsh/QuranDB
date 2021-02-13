//
//  SurasView.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 11/30/20.
//

import SwiftUI
import CoreData

struct SurasView: View {
    @State var searchText: String = ""
    
    var body: some View {
        VStack{
            TextEditor(text: $searchText)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .frame(height: 50)
            SurasList(filter: searchText)
        }
        .navigationTitle("السور")
    }
}

struct SurasView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
