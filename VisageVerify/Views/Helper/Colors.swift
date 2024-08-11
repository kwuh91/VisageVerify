//
//  Colors.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 14.07.2024.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Colors {
    
    static var boneColor: Color {
        Color(red: 255/255, green: 252/255, blue: 242/255)
    }
    
    static var orangeColor: Color {
        Color(red: 235/255, green: 94/255, blue: 40/255)
    }
    
    static var grayish: Color {
        Color(red: 64/255, green: 61/255, blue: 57/255)
    }
    
    static var blackish: Color {
        Color(red: 37/255, green: 36/255, blue: 34/255)
    }

}
