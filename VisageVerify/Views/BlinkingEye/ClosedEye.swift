//
//  ClosedEye.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 06.08.2024.
//

import SwiftUI

struct MainClosedEyeBody: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define scaling factors based on the rect size
        let widthScale  = rect.width  / 14.5
        let heightScale = rect.height / 28.0

        // A (+x)
        path.move(to: CGPoint(x: rect.midX + 7.19 * widthScale,
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
        
        // Cy+ (-x) (-y)
        path.addCurve(
            to: CGPoint(x: rect.midX + 0.9  * widthScale,
                        y: rect.midY + 3.84 * heightScale),
            
            control1: CGPoint(x: rect.midX - 7.0  * widthScale,
                              y: rect.midY - 0.42 * heightScale),
            
            control2: CGPoint(x: rect.midX - 4.54 * widthScale,
                              y: rect.midY + 4.34 * heightScale))
        
        path.addCurve(
            to: CGPoint(x: rect.midX + 7.19 * widthScale,
                        y: rect.midY + 0    * heightScale),
            
            control1: CGPoint(x: rect.midX + 4.54 * widthScale,
                              y: rect.midY + 3.34 * heightScale),
            
            control2: CGPoint(x: rect.midX + 7.0  * widthScale,
                              y: rect.midY - 0.42 * heightScale))
        
        path.closeSubpath()
        return path
    }
}

//struct MyFullCircle: Shape {
//    let radius: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        
//        let radiusScale = rect.width / 14.0
//        
//        path.addArc(center:     CGPoint(x: rect.midX,
//                                        y: rect.midY),
//                    radius:     radius * radiusScale ,
//                    startAngle: .degrees(0),
//                    endAngle:   .degrees(360),
//                    clockwise:  true)
//        
//        path.closeSubpath()
//        return path
//    }
//}
//
//struct SimpleEyeShape: Shape {
//    let startingPoint: CGPoint
//    let mult:          CGFloat
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        // let width = rect.size.width
//        // let height = rect.size.height
//        
//        path.move(to: startingPoint)
//        
//        path.addLine(to: CGPoint(x: startingPoint.x + 7.19 * mult,
//                                 y: startingPoint.y + -0   * mult))
//        
//        path.addCurve(to:       CGPoint(x: startingPoint.x + 0     * mult,
//                                        y: startingPoint.y + -4.59 * mult),
//                      control1: CGPoint(x: startingPoint.x + 5.54  * mult,
//                                        y: startingPoint.y + -3.74 * mult),
//                      control2: CGPoint(x: startingPoint.x + 1.76  * mult,
//                                        y: startingPoint.y + -4.62 * mult))
//        
//        path.addCurve(to:       CGPoint(x: startingPoint.x - 7.19 * mult,
//                                        y: startingPoint.y + -0   * mult),
//                      control1: CGPoint(x: startingPoint.x - 1.76  * mult,
//                                        y: startingPoint.y + -4.62 * mult),
//                      control2: CGPoint(x: startingPoint.x - 5.54  * mult,
//                                        y: startingPoint.y + -3.74 * mult))
//        
//        path.addCurve(to:       CGPoint(x: startingPoint.x + 0     * mult,
//                                        y: startingPoint.y + 4.59 * mult),
//                      control1: CGPoint(x: startingPoint.x - 5.54  * mult,
//                                        y: startingPoint.y + 3.74 * mult),
//                      control2: CGPoint(x: startingPoint.x - 1.76  * mult,
//                                        y: startingPoint.y + 4.62 * mult))
//        
//        path.addCurve(to:       CGPoint(x: startingPoint.x + 7.19 * mult,
//                                        y: startingPoint.y + -0   * mult),
//                      control1: CGPoint(x: startingPoint.x + 1.76  * mult,
//                                        y: startingPoint.y + 4.62 * mult),
//                      control2: CGPoint(x: startingPoint.x + 5.54  * mult,
//                                        y: startingPoint.y + 3.74 * mult))
//        
//        path.closeSubpath()
//        return path
//    }
//}
//
//struct OpenedEye: View {
//    let mainEyeColor: Color
//    let sectorColor:  Color
//    let pupilColor:   Color
//    
//    var body: some View {
//        ZStack {
//            // main eye body
//            MainOpenedEyeBody()
//                .foregroundStyle(mainEyeColor)
//            
//            // sector
//            MyFullCircle(radius: 3)
//                .foregroundStyle(sectorColor)
//
//            // pupil
//            MyFullCircle(radius: 0.9)
//                .foregroundStyle(pupilColor)
//        }
//        .contentShape(MainOpenedEyeBody())
//    }
//}

struct ClosedEye: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ZStack {
        let rectWidth:  CGFloat = 430
        let rectHeight: CGFloat = 839
        
        let widthScale  = rectWidth  / 14.5
        let heightScale = rectHeight / 28.0
        
        MainClosedEyeBody()
        
//        Circle()
//            .frame(height: 5)
//            .position(x: rectWidth / 2 - 4.1 * widthScale,
//                      y: rectHeight / 2 + 2.24 * heightScale)
//            .foregroundStyle(.red)
//        
//        Circle()
//            .frame(height: 5)
//            .position(x: rectWidth / 2 - 7 * widthScale,
//                      y: rectHeight / 2 - 0.42 * heightScale)
//            .foregroundStyle(.red)
//        
//        Circle()
//            .frame(height: 5)
//            .position(x: rectWidth / 2 - 4.54 * widthScale,
//                      y: rectHeight / 2 + 3.74 * heightScale)
//            .foregroundStyle(.red)
    }
}

//path.addCurve(
//    to: CGPoint(x: rect.midX - 4.1  * widthScale,
//                y: rect.midY + 2.24 * heightScale),
//    
//    control1: CGPoint(x: rect.midX - 7.0  * widthScale,
//                      y: rect.midY - 0.42 * heightScale),
//    
//    control2: CGPoint(x: rect.midX - 4.54  * widthScale,
//                      y: rect.midY + 3.74 * heightScale))


//// A (-x)
//path.addCurve(
//    to: CGPoint(x: rect.midX - 7.19 * widthScale,
//                y: rect.midY - 0    * heightScale),
