//
//  ButtonShell.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 14.07.2024.
//

import SwiftUI

//struct TravelButtonShell<Destination: View>: View {
//    let whereTo: Destination
//    let buttonText: String
//    
//    var body: some View {
//        NavigationView{
//            NavigationLink(destination: {
//                whereTo
//            }, label: {
//                ZStack {
//                    // button design
//                    FloatingFireflies(quantity: 70)
//                    // Colors.boneColor
//                        .mask(
//                            ButtonShape()
//                        )
//                        .shadow(color: Colors.blackish, radius: 10)
//                        .padding()
//                    
//                    PrettyText(text:     buttonText,
//                               fontName: "ArsenalSC-Regular",
//                               color:    Colors.boneColor,
//                               fontSize: 56)
//                        .shadow(color: Colors.blackish, radius: 5)
//                }
//            })
//        }
//    }
//}

struct TravelButtonShell<Destination: View>: View {
    let whereTo: Destination
    let buttonText: String
    
    var body: some View {
        NavigationView{
            NavigationLink(destination: {
                whereTo
            }, label: {
                ButtonShell(buttonText: buttonText)
            })
        }
    }
}

#Preview {
    TravelButtonShell(whereTo: FloatingFireflies(quantity: 5),
                      buttonText: "Sign in")
}
