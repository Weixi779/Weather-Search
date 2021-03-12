//
//  WeatherModel.swift
//  WeatherSearch
//
//  Created by 孙世伟 on 2021/3/8.
//

import Foundation

struct Weather:Identifiable {
    let id = UUID()
    var location:String                 //位置
    var path:String
    var date:String                     //日期
    var text_day:String              //白天天气
    var code_day:String
    var text_night:String            //晚上天气
    var code_night:String
    var high:String                     //最高温度
    var low:String                      //最低温度
    var wind_direction_degree:String                   //降水概率
    var wind_scale:String    //风向角度
    var wind_speed:String               //风速
    var rainfall:String                 //降水量
    var humidity:String                 //相对湿度
    
    init(_ location:String,
         _ path:String,
         _ date:String,
         _ text_day:String,
         _ code_day:String,
         _ text_night:String,
         _ code_night:String,
         _ high:String,
         _ low:String,
         _ wind_direction_degree:String,                  
         _ wind_scale:String,
         _ wind_speed:String,
         _ rainfall:String,
         _ humidity:String) {
        self.location = location
        self.path = path
        
        let tempArray = date.split(separator: "-")//xxxx-xx-xx
        self.date = "\(tempArray[1])-\(tempArray[2])"
        
        self.text_day = text_day
        self.code_day = code_day
        self.text_night = text_night
        self.code_night = code_night
        self.high = high
        self.low = low
        self.wind_direction_degree = wind_direction_degree
        self.wind_scale = wind_scale
        self.wind_speed = wind_speed
        self.rainfall = rainfall
        self.humidity = humidity
    }
    func LocationReverse() -> String{
        var tempArray = path.split(separator: ",")
        tempArray.removeFirst()
        var string = ""
        for i in tempArray.reversed(){
            string += "\(i) "
        }
        return string
    }
}


