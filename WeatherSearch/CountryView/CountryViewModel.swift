//
//  CountryViewModel.swift
//  WeatherSearch
//
//  Created by 孙世伟 on 2021/3/9.
//

import Foundation

class Country: ObservableObject {
    var namesearch = NameSearch()
    //@Published var countrys:[Country]
    @Published var countrys:[String]{
        didSet{
            let encoder = JSONEncoder()
            if let encoder = try? encoder.encode(countrys){
                UserDefaults.standard.set(encoder, forKey: "Countrys")
            }
        }
    }
    
    init() {
        if let countrys = UserDefaults.standard.data(forKey: "Countrys"){
            let decoder = JSONDecoder()
            if let decoder = try? decoder.decode([String].self, from: countrys){
                self.countrys = decoder
                return
            }
        }
        self.countrys = [String]()
    }
    
    func AddCountry(_ name:String){
        countrys.append(name)
    }
    
    func SearchCountry(_ name:String) -> String{
        if namesearch.name_search.keys.contains(name) {
            return namesearch.name_search[name]!
        }else{
            print("error")
            return ""
        }
    }
}
