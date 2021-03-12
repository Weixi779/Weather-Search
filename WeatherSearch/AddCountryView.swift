//
//  PlaceListView.swift
//  WeatherSearch
//
//  Created by 孙世伟 on 2021/3/9.
//

import SwiftUI

struct AddCountryView: View {
    let nameserch = NameSearch()
    @State var results: [String] = []
    @State var query = ""
    @Binding var AddCountryItem:Bool
    
    @EnvironmentObject var countrys:Country
    var body: some View {
        VStack{
            HStack(spacing:15){
                TextField("Serach", text: self.$query)
                    .autocapitalization(.none)
                    .onChange(of: self.query) { (value) in
                        if value != ""{
                            DispatchQueue.global(qos: .background).async {
                                let result = nameserch.name_search.keys.filter { (country) -> Bool in
                                    if country.contains(value){
                                        return true
                                    }else{
                                        return false
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.results = result
                                }
                            }
                        }else{
                            self.results.removeAll()
                        }
                    }
                if self.query != ""{
                    Button {
                        self.query = ""
                    } label: {
                        Image(systemName: "xmark").foregroundColor(.black)
                    }
                }
            }
            .padding(.all)
            .background(Color.black.opacity(0.06))
            .cornerRadius(15)
            .padding([.horizontal,.top])
            
            List(self.results,id:\.self){ country in
                Text(country)
                    .onTapGesture {
                        query = country
                        countrys.AddCountry(query)
                        AddCountryItem.toggle()
                    }
            }
        }
    }
}

//struct PlaceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCountryView()
//    }
//}
