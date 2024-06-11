//
//  PredatorImageFullScreen.swift
//  JP Apex Predators
//
//  Created by Wobi on 06/06/2024.
//

import SwiftUI

struct PredatorImageFullScreen: View {
    let predator: ApexPredator
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(
                                stops: [Gradient.Stop(color: .clear, location: 0.8),
                                        Gradient.Stop(color: .black, location: 1),],
                                startPoint: .top, endPoint: .bottom)
                        }
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: .gray, radius: 7)
                    
                }
            }
        }
    }
}

#Preview {
    PredatorImageFullScreen(predator: Predators().apexPredators[2])
}
