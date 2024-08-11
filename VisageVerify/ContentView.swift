//
//  ContentView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
        // FloatingFireflies(quantity: 70)
       // InitialScreen()
//        ZStack {
//            FloatingFireflies(quantity: 100)
//            
//            MultipleBlinkingEyes(quantity:     100,
//                                 mainEyeColor: Colors.blackish,
//                                 sectorColor:  Colors.boneColor,
//                                 pupilColor:   Colors.orangeColor)
//            .opacity(0.5)
//        }
//        ZStack {
//            Colors.boneColor
//                .ignoresSafeArea()
//            
//            MultipleBlinkingEyes()
//        }
        // MultipleBlinkingEyes(quantity: 5)
        
        
        
        
//        ZStack {
//            Color.white
//                .ignoresSafeArea()
//
//            BlinkingEyeStatesDisplay()
//        }
        
//        ZStack {
//            Color.white
//                .ignoresSafeArea()
//            
//            SingleBlinkingEyeView(mainEyeColor: .black,
//                                  sectorColor:  .white,
//                                  pupilColor:   .black)
//                .aspectRatio(0.5, contentMode: .fit)
//                .frame(height: 500)
//        }
        
        ZStack {
            Color.white
                .ignoresSafeArea()

            MultipleBlinkingEyes(quantity:     70,
                                 mainEyeColor: Color.black,
                                 sectorColor:  Color.white,
                                 pupilColor:   Color.black)
        }
        
//        ZStack {
//            Color.white
//                .ignoresSafeArea()
//
//            MultipleBlinkingEyes(quantity:     100,
//                                 mainEyeColor: Colors.blackish,
//                                 sectorColor:  Colors.boneColor,
//                                 pupilColor:   Colors.orangeColor)
//        }
        
//        ZStack {
//            Color(hex: "92140C")
//                .ignoresSafeArea()
//            
//            MultipleBlinkingEyes(quantity:     100,
//                                 mainEyeColor: Color.black ,
//                                 sectorColor:  Color.black,
//                                 pupilColor:   Color.red)
//        }
        
//        ZStack {
//            Color.white
//                .ignoresSafeArea()
//            
//            MultipleBlinkingEyes(quantity:     100,
//                                 mainEyeColor: Color(hex: "1E1E24"),
//                                 sectorColor:  Color(hex: "FFF8F0"),
//                                 pupilColor:   Color(hex: "FFF8F0"))
//        }
        
//        ZStack {
//            Color.black
//                .ignoresSafeArea()
//            
//            MultipleBlinkingEyes(quantity:     150,
//                                 mainEyeColor: Color.black ,
//                                 sectorColor:  Color.black,
//                                 pupilColor:   Color.blue)
//        }
    }
}

#Preview {
    ContentView()
}
