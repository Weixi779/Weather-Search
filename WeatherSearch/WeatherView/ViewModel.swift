//
//  ViewModel.swift
//  WeatherSearch
//
//  Created by 孙世伟 on 2021/3/8.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var weathers:[Weather]
    init() {
        weathers = [Weather]()
        GetWeatherUrl("WWGTYKJXE1UQ")
    }
    
    func GetWeatherUrl(_ location:String){
        self.weathers = [Weather]()
        let apiNumber = "Ssk921BhxirVFVe7"
        SearchTodayWeather("https://api.seniverse.com/v3/weather/daily.json?key=\(apiNumber)a&location=\(location)&language=zh-Hans&unit=c&start=0&days=5")
    }
    //-MARK:现在天气JSON解析
    func SearchTodayWeather(_ url:String){
        struct TodayWeather: Codable{
            struct result:Codable {
                let location:Location
                let daily:[Daily]
                let last_update:String
            }
            struct Location:Codable {
                let id:String
                let name:String
                let country:String
                let path:String
                let timezone:String
                let timezone_offset:String
            }
            struct Daily:Codable {
                let date:String
                let text_day:String
                let code_day:String
                let text_night:String
                let code_night:String
                let high:String
                let low:String
                let wind_direction_degree:String
                let wind_scale:String
                let wind_speed:String
                let rainfall:String
                let humidity:String
            }
            let results:[result]
        }
        let url = URL(string: url)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let jsDecoder = JSONDecoder()
                do {
                    let Json = try jsDecoder.decode(TodayWeather.self, from: data)
                    for res in Json.results{
                        for day in res.daily{
                            let temp = Weather(res.location.name, res.location.path, day.date, day.text_day, day.code_day, day.text_night, day.code_night, day.high, day.low, day.wind_direction_degree, day.wind_scale, day.wind_speed, day.rainfall, day.humidity)
                            DispatchQueue.main.async {
                                self.weathers.append(temp)
                            }
                        }
                    }
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}
