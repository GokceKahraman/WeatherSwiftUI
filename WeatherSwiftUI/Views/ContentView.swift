//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Gökçe Kahraman on 5.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack{
            if let location = locationManager.location {
                if let weather = weather{
                    Text("Weather data fetch")
                } else {
                    LoadingView()
                        .task {
                            do{
                                weather = try await weatherManager.getCurrentWeather(latitute: location.latitude, longitude: location.longitude)
                            }catch{
                                print("Error getting weather: \(weather)")
                            }
                        }
                }
            } else{
                if locationManager.isLoading{
                    LoadingView()
                }else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
