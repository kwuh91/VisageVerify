//
//  StaticTheme.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 14.07.2024.
//

import SwiftUI

struct StaticTheme {
    // define background color
    static var generalBackground: Color {
        Color(red: 255/255, green: 252/255, blue: 242/255) // bone color
    }
    
    // define firefly color
    static var fireflyTheme: Color {
        // used both in dark and light themes
        let orange = Color(red: 235/255, green: 94/255, blue: 40/255, opacity: 0.91) // orange color
        
        // colors for light theme
        let grayish  = Color(red: 64/255, green: 61/255, blue: 57/255) // grayish
        let blackish = Color(red: 37/255, green: 36/255, blue: 34/255) // blackish
        // let grayish  = Color(.green)  // debug
        // let blackish = Color(.yellow) // debug
        
        // array with colors for light theme (dots are dark and bg is light)
        // blackish is: 3x as rare, grayish: 2x and orange: 1x
        let lightFireflyColors: [Color] = [blackish, blackish, blackish, grayish, grayish, orange]
        
        // choose one random color
        return lightFireflyColors.randomElement()!
    }
    
    // define shadow color
    static var shadowTheme: Color {
        Color(red: 37/255,  green: 36/255,  blue: 34/255)  // blackish
    }
}
