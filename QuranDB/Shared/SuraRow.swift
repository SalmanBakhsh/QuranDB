//
//  SuraRow.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 6/1/20.
//  Copyright © 2020 Salman Bakhsh. All rights reserved.
//

import SwiftUI
import CoreData

struct SuraRow: View {
    
    var sura: Suras
    @State private var ayas = [Ayas]()
    @State private var words = [Words]()
    @State private var goToMainView = false
    @State private var goToAyasView = false
    @State private var goToWordsView = false
    @State private var showingActionSheet = false
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: SurasView(),
                isActive: $goToMainView,
                label: {EmptyView()}
            )
            NavigationLink(
                destination: AyasView(ayas: ayas),
                isActive: $goToAyasView,
                label: {EmptyView()}
            )
            NavigationLink(
                destination: WordsView(words: words),
                isActive: $goToWordsView,
                label: {EmptyView()}
            )
            HStack() {
                Text("\(sura.suraID)")
                    .frame(maxWidth:40.0,alignment:.center)
                    .background(Color("Color2"))
                    .cornerRadius(20)
                VStack() {
                    Text(sura.name ?? "")
                        .lineLimit(1)
                        .frame(maxWidth:300,alignment:.leading)
                        .background(Color("Color3"))
                        .cornerRadius(5)
                    Text(sura.type ?? "")
                        .lineLimit(1)
                        .background(Color("Color4"))
                        .frame(maxWidth:300,alignment:.leading)
                }
                Spacer()
                VStack {
                    Text("الآيات")
                    Text("\(sura.ayasNumbers)")
                        .frame(maxWidth:40,alignment:.center)
                        .background(Color("Color5"))
                        .cornerRadius(10)
                }
                Spacer()
                VStack {
                    Text("صفحة")
                    Text("\(sura.startAtPage!.index)")
                        .frame(maxWidth:40,alignment:.center)
                        .background(Color("Color6"))
                        .cornerRadius(10)
                }
            }
            .background(Color("Color1"))
        }
        .onTapGesture {
            ayas = sura.ayas!.sortedArray(using: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)]) as! [Ayas]
            goToAyasView.toggle()
        }
        .onLongPressGesture {showingActionSheet.toggle()}
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("title"), message: Text("message"), buttons: [
                .default(Text("صفحة الآيات")) {
                    ayas = sura.ayas!.sortedArray(using: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)]) as! [Ayas]
                    goToAyasView.toggle()
                },
                .default(Text("صفحة الكلمات")) {
                    words = sura.words!.sortedArray(using: [NSSortDescriptor(keyPath: \Words.index, ascending: true)]) as! [Words]
                    goToWordsView.toggle()
                },
                .default(Text("الصفحة الرئيسية")) {goToMainView.toggle()},
                .default(Text("Blue")) {print("Blue")},
                .cancel()
            ])
        }
    }
}

struct SuraRow_Previews: PreviewProvider {
    static var previews: some View {
        var surasArray = [Suras]()
        let context = PersistenceController.shared.container.viewContext
        let request: NSFetchRequest<Suras> = Suras.fetchRequest()
        
        do {
            surasArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        return SuraRow(sura: surasArray[0])
    }
}
