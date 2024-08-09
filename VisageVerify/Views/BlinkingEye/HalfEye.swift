//
//  HalfEye.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 06.08.2024.
//

import SwiftUI

struct MainHalfEyeBody: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define scaling factors based on the rect size
        let widthScale  = rect.width  / 14.5
        let heightScale = rect.height / 28.0

        // O
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        
        // A (+x)
        path.addLine(
            to: CGPoint(x: rect.midX + 7.19 * widthScale,
                        y: rect.midY + 0    * heightScale))
        
        // C (+x) (-y)
        path.addCurve(
            to: CGPoint(x: rect.midX + 3.54  * widthScale,
                        y: rect.midY - -3.74 * heightScale),
            
            control1: CGPoint(x: rect.midX + 7.19 * widthScale,
                              y: rect.midY - -1   * heightScale),
            
            control2: CGPoint(x: rect.midX + 5.56 * widthScale,
                              y: rect.midY - -2.7 * heightScale))
        
        // E (-y)
        path.addCurve(
            to: CGPoint(x: rect.midX + 0     * widthScale,
                        y: rect.midY - -4.59 * heightScale),
            
            control1: CGPoint(x: rect.midX + 3.54  * widthScale,
                              y: rect.midY - -3.74 * heightScale),
            
            control2: CGPoint(x: rect.midX + 1.76  * widthScale,
                              y: rect.midY - -4.62 * heightScale))

        // C (-x) (-y)
        path.addCurve(
            to: CGPoint(x: rect.midX - 3.54  * widthScale,
                        y: rect.midY - -3.74 * heightScale),
            
            control1: CGPoint(x: rect.midX - 1.76  * widthScale,
                              y: rect.midY - -4.62 * heightScale),
            
            control2: CGPoint(x: rect.midX - 3.54  * widthScale,
                              y: rect.midY - -3.74 * heightScale))
        
        // A (-x)
        path.addCurve(
            to: CGPoint(x: rect.midX - 7.19 * widthScale,
                        y: rect.midY - 0    * heightScale),
            
            control1: CGPoint(x: rect.midX - 5.56 * widthScale,
                              y: rect.midY - -2.7 * heightScale),
            
            control2: CGPoint(x: rect.midX - 7.19 * widthScale,
                              y: rect.midY - -1   * heightScale))
        
        path.closeSubpath()
        return path
    }
}

struct MyHalfCircle: Shape {
    let radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radiusScale = rect.width / 14.0
        
        path.addArc(center:     CGPoint(x: rect.midX,
                                        y: rect.midY),
                    radius:     radius * radiusScale ,
                    startAngle: .degrees(0),
                    endAngle:   .degrees(180),
                    clockwise:  false)
        
        path.closeSubpath()
        return path
    }
}

struct MyCustomCircle: Shape {
    let radius:     CGFloat
    let startAngle: CGFloat
    let endAngle:   CGFloat
    let clockwise:  Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radiusScale = rect.width / 14.0
        
        path.addArc(center:     CGPoint(x: rect.midX,
                                        y: rect.midY),
                    radius:     radius * radiusScale ,
                    startAngle: .degrees(startAngle),
                    endAngle:   .degrees(endAngle),
                    clockwise:  clockwise)
        
        path.closeSubpath()
        return path
    }
}

struct HalfEye: View {
    let mainEyeColor: Color
    let sectorColor:  Color
    let pupilColor:   Color
    
    var body: some View {
        ZStack {
            // main eye body
            MainHalfEyeBody()
                .foregroundStyle(mainEyeColor)
            
            // sector
            MyHalfCircle(radius: 3)
                .foregroundStyle(sectorColor)

            // pupil
            MyHalfCircle(radius: 0.9)
                .foregroundStyle(pupilColor)
        }
        .contentShape(MainHalfEyeBody())
    }
}

#Preview {
    HalfEye(mainEyeColor: .black,
            sectorColor:  .white,
            pupilColor:   .black)
    .aspectRatio(0.5, contentMode: .fit)
    .frame(height: 500)
    .onTapGesture{
        print("eye tapped!")
    }
}
