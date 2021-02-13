//
//  WordsRow.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 11/28/20.
//

import SwiftUI
import CoreData

struct WordRow: View {
    var word: Words
    @State private var ayas = [Ayas]()
    @State private var goToAyasView = false
    @State private var showingActionSheet = false
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: AyasView(ayas: ayas),
                isActive: $goToAyasView,
                label: {EmptyView()}
            )
            HStack {
                Text("\(word.index)")
                    .font(.caption)
                    .frame(width: 50.0)
                    .background(Color("Color1"))
                    .cornerRadius(10)
                VStack {
                    Text("\(word.wordTextKFGQPC!)")
                        .background(Color("Color2"))
                        .cornerRadius(10)
                    Text("\(word.wordTextSimple!)")
                        .background(Color("Color7"))
                        .cornerRadius(10)
                }
                Spacer()
                VStack {
                    Text("جذر")
                        .font(.footnote)
                    Text("\(word.root!)")
                        .font(.footnote)
                        .frame(width: 40)
                        .background(Color("Color3"))
                        .cornerRadius(10)
                }
                VStack {
                    Text("سورة")
                        .font(.footnote)
                    Text("\(word.sura!.name2!)")
                        .font(.footnote)
                        .frame(width: 60.0)
                        .background(Color("Color4"))
                        .cornerRadius(10)
                }
                VStack {
                    Text("آية")
                        .font(.footnote)
                    Text("\(word.ayaID)")
                        .font(.footnote)
                        .frame(width: 30)
                        .background(Color("Color5"))
                        .cornerRadius(10)
                }
                VStack {
                    Text("ترتيب")
                        .font(.footnote)
                    Text("\(word.wordID)")
                        .font(.footnote)
                        .frame(width: 30)
                        .background(Color("Color6"))
                        .cornerRadius(10)
                }
            }
            .onTapGesture {print("Word # \(word.index)")}
            .onLongPressGesture {showingActionSheet.toggle()}
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("title"), message: Text("message"), buttons: [
                    .default(Text("السورة")) {
                        ayas = word.sura?.ayas?.sortedArray(using: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)]) as! [Ayas]
                        goToAyasView.toggle()
                    },
                    .cancel()
                ])
            }
        }
    }
}

struct WordRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
