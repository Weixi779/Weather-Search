//
//  ContentView.swift
//  WeatherSearch
//
//  Created by 孙世伟 on 2021/3/8.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewmodel:ViewModel
    @State var isSimple = false
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            LazyVGrid(columns: self.columns,spacing:20){
                                ForEach(viewmodel.weathers){ weather in
                                    GridView(weather: weather,colums: $columns)
                                }
                                
                            }
                            .padding([.top,.horizontal,.bottom])
                            Spacer()
                        }
                }
            }
            .ignoresSafeArea(.container,edges: .bottom)
            .navigationBarTitle("天气查询", displayMode: .inline)
            .navigationBarColor(UIColor(Color("Viewcolor")))
            .navigationBarItems(
                leading:
                    Button{
                        withAnimation(.easeOut){
                            if columns.count == 2{
                                columns.removeLast()
                            }else{
                                columns.append(GridItem(.flexible(),spacing: 15))
                            }
                        }
                    } label:{
                        Image(systemName: columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .foregroundColor(Color("FontColor")) },
                trailing:
                    NavigationLink( destination: CountryListView(items: Country(), viewmodel: viewmodel),
                                    label: { Image(systemName: "slider.horizontal.3")
                                                .foregroundColor(Color("FontColor"))
                }))
        }
        
    }
}

struct GridView:View {
    var weather: Weather
    @Binding var colums : [GridItem]
    @Namespace var namespace
    @State var isShowDetail = false
    var body: some View{
        //-MARK:动画之前
        if colums.count == 2 {
            ZStack{
                Color("Card")
                    .matchedGeometryEffect(id: "Card", in: namespace)
                VStack{
                    HStack{
                        VStack{
                            Text(weather.location)
                                .font(.headline)
                                .bold()
                                .padding(.leading , -10)
                            Text(weather.date)
                                .foregroundColor(Color("FontColor"))
                                .padding(.leading,4)
                        }
                        .matchedGeometryEffect(id: "title", in: namespace)
                        Spacer()
                        Image(weather.code_day)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .matchedGeometryEffect(id: "image", in: namespace)
                    }
                    .padding()
                    Text(weather.text_day)
                        .bold()
                        .font(.system(.largeTitle))
                        .matchedGeometryEffect(id: "weather", in: namespace)
                    Text("\(weather.low)°C〜\(weather.high)°C")
                        .matchedGeometryEffect(id: "temperature", in: namespace)
                        .padding()
                    Spacer()
                }
                .foregroundColor(Color("Viewcolor"))
            }
            .frame(height: 180)
            .cornerRadius(10)
            .onTapGesture {
                isShowDetail.toggle()
            }
            .sheet(isPresented: $isShowDetail){
                SheetView(weather: weather)
            }
        }
        //-MARK:动画之后
        else{
            HStack{
                ZStack{
                    Color("Card")
                        .matchedGeometryEffect(id: "Card", in: namespace)
                    VStack{
                        HStack{
                            VStack{
                                Text(weather.location)
                                    .font(.headline)
                                    .bold()
                                    .padding(.leading , -10)
                                Text(weather.date)
                                    .foregroundColor(Color("FontColor"))
                                    .padding(.leading,4)
                            }
                            .matchedGeometryEffect(id: "title", in: namespace)
                            Spacer()
                            Image(weather.code_day)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .matchedGeometryEffect(id: "image", in: namespace)
                            Text("->")
                            Image(weather.code_night)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .padding()
                        HStack{
                            Text(weather.text_day)
                                .bold()
                                .font(.system(.largeTitle))
                                .matchedGeometryEffect(id: "weather", in: namespace)
                            Text("=>")
                                .bold()
                                .font(.system(.largeTitle))
                            Text(weather.text_night)
                                .bold()
                                .font(.system(.largeTitle))
                        }
                        HStack{
                            Text("温度:")
                            Text("\(weather.low) °C 〜\(weather.high) °C")
                                .matchedGeometryEffect(id: "temperature", in: namespace)
                                .padding()
                            Spacer()
                            Text("风速:")
                            Text("\(weather.wind_speed) km/h")
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .foregroundColor(Color("Viewcolor"))
                }
                .cornerRadius(10)
            }
        }
        
        
    }
}
//-MARK:特写界面
struct SheetView:View {
    var weather:Weather
    var body: some View{
        
        
        ZStack {
            Color("Card")
            VStack{
                VStack{
                    HStack(spacing:10){
                        Text(weather.location)
                            .font(.largeTitle)
                            .foregroundColor(Color("Viewcolor"))
                            .bold()
                            
                        Spacer()
                    }
                    HStack{
                        Text(weather.LocationReverse())
                            .foregroundColor(Color("FontColor"))
                            .font(.body)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text(weather.date)
                            .foregroundColor(Color("Background"))
                    }
                }
                .font(.title)
                .padding()
                VStack{
                    Divider()
                    VStack{
                        HStack{
                            Text("白天天气:")
                            Text(weather.text_day)
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Spacer()
                            Text("\(weather.high)")
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Text("°C")
                            Spacer()
                        }
                        HStack{
                            Text("夜晚天气:")
                            Text(weather.text_night)
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Spacer()
                            Text("\(weather.low)")
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Text("°C")
                            Spacer()
                        }
                    }
                    .font(.title)
                    .padding()
                }
                VStack{
                    Divider()
                    VStack{
                        HStack{
                            Text("相对湿度:")
                            Text("\(weather.humidity)")
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Text("%")
                            Spacer()
                        }
                        HStack{
                            Text("降雨量:")
                            Text("\(weather.rainfall)")
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Text("mm")
                            Spacer()
                        }
                    }
                    .font(.title)
                    .padding()
                }
                VStack{
                    Divider()
                    VStack{
                        HStack{
                            Text("风级:")
                            Text(weather.wind_scale)
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Spacer()
                        }
                        HStack{
                            Text("风向角:")
                            Text(weather.wind_direction_degree)
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Spacer()
                        }
                        HStack{
                            Text("风速:")
                            Text(weather.wind_speed)
                                .foregroundColor(Color("Viewcolor"))
                                .bold()
                            Text("km/h")
                            Spacer()
                        }
                    }.font(.title)
                    .padding()
                }

                Divider()
                Spacer()
            }
            .foregroundColor(Color("Background"))
        }
        .ignoresSafeArea(.all)
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
