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
        Colors.boneColor
    }
    
    // define firefly color
    static var fireflyTheme: Color {
        // used both in dark and light themes
        let orange = Colors.orangeColor
        
        // colors for light theme
        let grayish  = Colors.grayish
        let blackish = Colors.blackish
        
        // array with colors for light theme (dots are dark and bg is light)
        // blackish is: 3x as rare, grayish: 2x and orange: 1x
        let lightFireflyColors: [Color] = [blackish, blackish, blackish, grayish, grayish, orange]
        
        // choose one random color
        return lightFireflyColors.randomElement()!
    }
    
    // define shadow color
    static var shadowTheme: Color {
        Colors.blackish
    }
}
