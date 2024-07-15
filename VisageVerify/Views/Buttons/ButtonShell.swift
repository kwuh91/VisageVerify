//
//  ButtonShell.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 14.07.2024.
//

import SwiftUI

struct ButtonShell: View {
    var body: some View {
        ZStack{
            // bg dark color
            Colors.blackish
                .ignoresSafeArea()
            
            // bg light color
            //Colors.boneColor
            //    .ignoresSafeArea()
            
            VStack {
                Button(action: {
                    print("clicked")
                }){
                    FloatingFireflies(quantity:          70, 
                                      backgroundOpacity: 1.0)
                        .mask(
                            Circle()
                        )
                        // light shadow
                        .shadow(color: Colors.boneColor, radius: 10)
                        
                        // light shadow
                        //.shadow(color: Colors.blackish, radius: 10)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ButtonShell()
}
