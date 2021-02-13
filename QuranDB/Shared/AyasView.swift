//
//  SwiftUITestView.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 11/23/20.
//

import SwiftUI
import CoreData

struct AyasView: View {
    var ayas = [Ayas]()
    
    var body: some View {
        List(ayas) { aya in
            AyaRow(aya: aya)
        }
        .navigationTitle("Ayas")
    }
}

struct AyasView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
