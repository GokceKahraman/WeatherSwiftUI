//
//  WelcomeView.swift
//  WeatherSwiftUI
//
//  Created by Gökçe Kahraman on 5.12.2022.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            WelcomeView().environmentObject(locationManager)
        }
        .background()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
