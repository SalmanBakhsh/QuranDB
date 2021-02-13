//
//  AyaRow.swift
//  QuranDB
//
//  Created by Salman Bakhsh on 12/3/20.
//

import SwiftUI
import CoreData

struct AyaRow: View {
    var aya: Ayas
    @State private var ayas = [Ayas]()
    @State private var words = [Words]()
    @State private var goToWordsView = false
    @State private var goToAyasView = false
    @State private var showingActionSheet = false
    
    var body: some View {
        ZStack {
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
            HStack {
                Text("\(aya.ayaTextSimple ?? "")")
                    .background(Color("Color1"))
                    .cornerRadius(7)
                Spacer()
                Text("\(aya.ayaID)")
                    .background(Color("Color2"))
                    .cornerRadius(7)
            }
        }
        .onTapGesture {print("Aya # \(aya.ayaID)")}
        .onLongPressGesture {showingActionSheet.toggle()}
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("title"), message: Text("message"), buttons: [
                .default(Text("صفحة الكلمات")) {
                    words = aya.words!.sortedArray(using: [NSSortDescriptor(keyPath: \Words.index, ascending: true)]) as! [Words]
                    goToWordsView.toggle()
                },
                .default(Text("السورة")) {
                    ayas = aya.sura?.ayas?.sortedArray(using: [NSSortDescriptor(keyPath: \Ayas.ayaIndex, ascending: true)]) as! [Ayas]
                    goToAyasView.toggle()
                },
                .cancel()
            ])
        }
    }
}

struct AyaRow_Previews: PreviewProvider {
    static var previews: some View {
        var ayasArray = [Ayas]()
        let context = PersistenceController.shared.container.viewContext
        let request: NSFetchRequest<Ayas> = Ayas.fetchRequest()
        
        do {
            ayasArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        return AyaRow(aya: ayasArray[0])
    }
}
