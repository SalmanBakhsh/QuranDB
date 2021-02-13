//
//  WordsView.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 11/28/20.
//

import SwiftUI
import CoreData

struct WordsView: View {
    var words = [Words]()    
    
    var body: some View {
        List(words) { word in
            WordRow(word: word)
        }
        .navigationTitle("الكلمات")
    }
}

struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
