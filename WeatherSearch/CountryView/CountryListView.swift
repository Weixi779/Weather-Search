//
//  CountryListView.swift
//  WeatherSearch
//
//  Created by 孙世伟 on 2021/3/9.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var items:Country
    @ObservedObject var viewmodel:ViewModel
    @State var AddCountryItem = false
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            
            List{
                ForEach(items.countrys,id:\.self) { country in
                    Text(country)
                        .onTapGesture {
                            viewmodel.GetWeatherUrl(items.SearchCountry(country))
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }.onDelete(perform: removeItems)
            }
            .foregroundColor(Color("Viewcolor"))
            .sheet(isPresented: $AddCountryItem) {
                AddCountryView(AddCountryItem: $AddCountryItem).environmentObject(items)
            }
        }.navigationBarTitle("城市列表")
        .navigationBarColor(UIColor(Color("Viewcolor")))
        .navigationBarItems(trailing:
            Button { AddCountryItem.toggle() } label: {
                Image(systemName: "plus.bubble")
                    .foregroundColor(Color("FontColor"))
            })
    }
    func removeItems(at offset:IndexSet){
        items.countrys.remove(atOffsets: offset)
    }
}

//struct CountryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryListView()
//    }
//}
