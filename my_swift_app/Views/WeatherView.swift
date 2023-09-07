//
//  WeatherView.swift
//  my_swift_app
//
//  Created by François Dinong on 01/08/2023.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: ResponseBody
    
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }

    var body: some View {

        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    
                    Text("Aujourd'hui, \(formattedDate())")
                        .fontWeight(.light)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 5) {
                            
                            switch weather.weather.first?.main.lowercased() {
                            case "clear":
//                                Text("It's a clear day. Enjoy the sunshine!")
                                Image(systemName: "sun.max.fill")
                                    .font(.system(size: 40))
                                
//                                Text("\(weather.weather[0].main)")
                                Text("Dégagé")
                            case "clouds":
                                Image(systemName: "cloud.fill")
                                    .font(.system(size: 40))
                                
//                                Text("\(weather.weather[0])")
                                Text("Nuageux")
//                                Text("It's a cloudy day. Don't forget your umbrella!")
                            case "rain":
                                Image(systemName: "cloud.rain.fill")
                                    .font(.system(size: 40))
                                
//                                Text("\(weather.weather[0].main)")
//                                Text("It's raining. Stay dry!")
                                Text("Pluie")
                            case "snow":
                                Image(systemName: "cloud.snow.fill")
                                    .font(.system(size: 40))
                                
                                Text("\(weather.weather[0].main)")
//                                Text("It's snowing. Bundle up!")
                            case "thunderstorm":
                                Image(systemName: "cloud.bolt.fill")
                                    .font(.system(size: 40))
                                
                                Text("\(weather.weather[0].main)")

//                                Text("There's a thunderstorm. Stay indoors and safe!")
                            default:
                                Text("Weather condition: \(weather.weather.first?.main ?? "Unknown")")
                            }


                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°C")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Météo d'aujourd'hui")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Temp min", value: (weather.main.tempMin.roundDouble() + ("°C")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Temp max", value: (weather.main.tempMax.roundDouble() + "°C"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Vitesse", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidité", value: "\(weather.main.humidity.roundDouble())%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(red: 0.4235294117647059, green: 0.39215686274509803, blue: 0.984313725490196))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Extend")
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(red: 0.4235294117647059, green: 0.39215686274509803, blue: 0.984313725490196))
        .preferredColorScheme(.dark)
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
