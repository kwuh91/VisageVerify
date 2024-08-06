//
//  SwiftUIView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 05.08.2024.
//

import SwiftUI

//struct CWSLogo: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.size.width
//        let height = rect.size.height
//        path.move(to: CGPoint(x: 0.56884*width, y: 0.71586*height))
//        path.addLine(to: CGPoint(x: 0.08333*width, y: 0.13554*height))
//        path.addLine(to: CGPoint(x: 0.49638*width, y: 0.48795*height))
//        path.addLine(to: CGPoint(x: 0.20924*width, y: 0.09839*height))
//        path.addLine(to: CGPoint(x: 0.69656*width, y: 0.53514*height))
//        path.addLine(to: CGPoint(x: 0.73732*width, y: 0.33333*height))
//        path.addLine(to: CGPoint(x: 0.63225*width, y: 0.00201*height))
//        path.addLine(to: CGPoint(x: 0.8433*width, y: 0.21084*height))
//        path.addLine(to: CGPoint(x: 0.92663*width, y: 0.46285*height))
//        path.addLine(to: CGPoint(x: 0.90942*width, y: 0.69779*height))
//        path.addLine(to: CGPoint(x: 0.99909*width, y: 0.83233*height))
//        path.addLine(to: CGPoint(x: 0.99909*width, y: 0.99598*height))
//        path.addLine(to: CGPoint(x: 0.92663*width, y: 0.91767*height))
//        path.addLine(to: CGPoint(x: 0.81431*width, y: 0.87751*height))
//        path.addLine(to: CGPoint(x: 0.53623*width, y: 0.99598*height))
//        path.addLine(to: CGPoint(x: 0.18207*width, y: 0.87751*height))
//        path.addLine(to: CGPoint(x: 0.00362*width, y: 0.64759*height))
//        path.addLine(to: CGPoint(x: 0.37772*width, y: 0.78213*height))
//        path.addLine(to: CGPoint(x: 0.56884*width, y: 0.71586*height))
//        path.closeSubpath()
//        return path
//    }
//}

//struct FullEye: Shape {
//    let multiplier:    CGFloat = 25
//    let startingPoint: CGPoint = CGPoint(x: 215, y: 419.5)
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        // let width = rect.size.width
//        // let height = rect.size.height
//        
//        // O
//        path.move(to: startingPoint)
//        
//        // A
//        path.addLine(to: CGPoint(x: startingPoint.x + 7 * multiplier,
//                                 y: startingPoint.y + -0 * multiplier))
//        // B
//        path.addLine(to: CGPoint(x: startingPoint.x + 5.56 * multiplier,
//                                 y: startingPoint.y + -2.3 * multiplier))
//        // C
//        path.addLine(to: CGPoint(x: startingPoint.x + 3.54 * multiplier,
//                                 y: startingPoint.y + -3.54 * multiplier))
//        // D
//        path.addLine(to: CGPoint(x: startingPoint.x + 1.76 * multiplier,
//                                 y: startingPoint.y + -4.14 * multiplier))
//        // E
//        path.addLine(to: CGPoint(x: startingPoint.x + 0 * multiplier,
//                                 y: startingPoint.y + -4.5 * multiplier))
//        
//        // let _ = print(width)  // 430
//        // let _ = print(height) // 839
//        
//        path.closeSubpath()
//        return path
//    }
//}

struct MainEye: Shape {
    let startingPoint: CGPoint
    let mult:          CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // let width = rect.size.width
        // let height = rect.size.height
        
        // O
        path.move(to: startingPoint)
        
        // A (+x)
        path.addLine(to: CGPoint(x: startingPoint.x + 7.19 * mult,
                                 y: startingPoint.y + -0   * mult))
        
        // C (+x) (+y)
        path.addCurve(to:       CGPoint(x: startingPoint.x + 3.54  * mult,
                                        y: startingPoint.y + -3.74 * mult),
                      control1: CGPoint(x: startingPoint.x + 7.19  * mult,
                                        y: startingPoint.y + -1    * mult),
                      control2: CGPoint(x: startingPoint.x + 5.56  * mult,
                                        y: startingPoint.y + -2.7  * mult))
                    
        // E (+y)
        path.addCurve(to:       CGPoint(x: startingPoint.x + 0     * mult,
                                        y: startingPoint.y + -4.59 * mult),
                      control1: CGPoint(x: startingPoint.x + 3.54  * mult,
                                        y: startingPoint.y + -3.74 * mult),
                      control2: CGPoint(x: startingPoint.x + 1.76  * mult,
                                        y: startingPoint.y + -4.62 * mult))
        
        // C (-x) (+y)
        path.addCurve(to:       CGPoint(x: startingPoint.x - 3.54  * mult,
                                        y: startingPoint.y + -3.74 * mult),
                      control1: CGPoint(x: startingPoint.x - 1.76  * mult,
                                        y: startingPoint.y + -4.62 * mult),
                      control2: CGPoint(x: startingPoint.x - 3.54  * mult,
                                        y: startingPoint.y + -3.74 * mult))
        
        // A (-x)
        path.addCurve(to:       CGPoint(x: startingPoint.x - 7.19 * mult,
                                        y: startingPoint.y + -0   * mult),
                      control1: CGPoint(x: startingPoint.x - 5.56 * mult,
                                        y: startingPoint.y + -2.7 * mult),
                      control2: CGPoint(x: startingPoint.x - 7.19 * mult,
                                        y: startingPoint.y + -1   * mult))
        
        // C (-x) (-y)
        path.addCurve(to:       CGPoint(x: startingPoint.x - 3.54  * mult,
                                        y: startingPoint.y - -3.74 * mult),
                      control1: CGPoint(x: startingPoint.x - 7.19  * mult,
                                        y: startingPoint.y - -1    * mult),
                      control2: CGPoint(x: startingPoint.x - 5.56  * mult,
                                        y: startingPoint.y - -2.7  * mult))
        
        // E (-y)
        path.addCurve(to:       CGPoint(x: startingPoint.x + 0     * mult,
                                        y: startingPoint.y - -4.59 * mult),
                      control1: CGPoint(x: startingPoint.x - 3.54  * mult,
                                        y: startingPoint.y - -3.74 * mult),
                      control2: CGPoint(x: startingPoint.x - 1.76  * mult,
                                        y: startingPoint.y - -4.62 * mult))
        
        // C (+x) (-y)
        path.addCurve(to:       CGPoint(x: startingPoint.x + 3.54  * mult,
                                        y: startingPoint.y - -3.74 * mult),
                      control1: CGPoint(x: startingPoint.x + 1.76  * mult,
                                        y: startingPoint.y - -4.62 * mult),
                      control2: CGPoint(x: startingPoint.x + 3.54  * mult,
                                        y: startingPoint.y - -3.74 * mult))
        
        // A (+x)
        path.addCurve(to:       CGPoint(x: startingPoint.x + 7.19 * mult,
                                        y: startingPoint.y - -0   * mult),
                      control1: CGPoint(x: startingPoint.x + 5.56 * mult,
                                        y: startingPoint.y - -2.7 * mult),
                      control2: CGPoint(x: startingPoint.x + 7.19 * mult,
                                        y: startingPoint.y - -1   * mult))
        
        // let _ = print(width)  // 430
        // let _ = print(height) // 839
        
        path.closeSubpath()
        return path
    }
}

//struct MainEye: View {
//    
//    let position: CGPoint
//    let size:     CGFloat
//    
//    var body: some View {
//        ZStack {
//            QuarterEye(startingPoint: position,
//                       mult:          size)
//            
//            QuarterEye(startingPoint: position,
//                       mult:          size)
//                .rotation(Angle(degrees: 180))
//            //.scaledToFit()
//            //.padding()
//            
//            QuarterEye(startingPoint: position,
//                       mult:          size)
//                .scaleEffect(x: -1, y: 1)  // flip horizontally
//            
//            QuarterEye(startingPoint: position,
//                       mult:          size)
//                .rotation(Angle(degrees: 180))
//                .scaleEffect(x: -1, y: 1)  // flip horizontally
//        }
//        // .foregroundStyle(.red)
//        // .offset(y: -310)
//    }
//}

//struct MainEye: View {
//    
//    let position: CGPoint
//    let size:     CGFloat
//    
//    var body: some Shape {
//        QuarterEye(startingPoint: position, mult: size)
////            .union(
////                QuarterEye(startingPoint: position, mult: size)
////                    .rotation(Angle(degrees: 180))
////            )
////            .union(
////                QuarterEye(startingPoint: position, mult: size)
////                    .scale(x: -1, y: 1, anchor: .center)
////            )
////            .union(
////                QuarterEye(startingPoint: position, mult: size)
////                    .scale(x: 1, y: -1, anchor: .center)
////            )
//        }
//        // .foregroundStyle(.red)
//        // .offset(y: -310)
//}

struct MyCircle: Shape {
    let startingPoint: CGPoint
    let radius:        CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // let width = rect.size.width
        // let height = rect.size.height
        
        path.addArc(center: startingPoint,
                 radius:     radius,
                 startAngle: .degrees(0),
                 endAngle:   .degrees(360),
                 clockwise:  true)
        
        path.closeSubpath()
        return path
    }
}

//func sizeToWidthRatio(size: CGFloat) -> CGFloat {
//    58*sqrt(size + 47) - 410
//}
//
//func sizeToHeightRatio(size: CGFloat) -> CGFloat {
//    16*sqrt(size + 10) - 60
//}

struct SimpleEyeShape: Shape {
    let startingPoint: CGPoint
    let mult:          CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // let width = rect.size.width
        // let height = rect.size.height
        
        path.move(to: startingPoint)
        
        path.addLine(to: CGPoint(x: startingPoint.x + 7.19 * mult,
                                 y: startingPoint.y + -0   * mult))
        
        path.addCurve(to:       CGPoint(x: startingPoint.x + 0     * mult,
                                        y: startingPoint.y + -4.59 * mult),
                      control1: CGPoint(x: startingPoint.x + 5.54  * mult,
                                        y: startingPoint.y + -3.74 * mult),
                      control2: CGPoint(x: startingPoint.x + 1.76  * mult,
                                        y: startingPoint.y + -4.62 * mult))
        
        path.addCurve(to:       CGPoint(x: startingPoint.x - 7.19 * mult,
                                        y: startingPoint.y + -0   * mult),
                      control1: CGPoint(x: startingPoint.x - 1.76  * mult,
                                        y: startingPoint.y + -4.62 * mult),
                      control2: CGPoint(x: startingPoint.x - 5.54  * mult,
                                        y: startingPoint.y + -3.74 * mult))
        
        path.addCurve(to:       CGPoint(x: startingPoint.x + 0     * mult,
                                        y: startingPoint.y + 4.59 * mult),
                      control1: CGPoint(x: startingPoint.x - 5.54  * mult,
                                        y: startingPoint.y + 3.74 * mult),
                      control2: CGPoint(x: startingPoint.x - 1.76  * mult,
                                        y: startingPoint.y + 4.62 * mult))
        
        path.addCurve(to:       CGPoint(x: startingPoint.x + 7.19 * mult,
                                        y: startingPoint.y + -0   * mult),
                      control1: CGPoint(x: startingPoint.x + 1.76  * mult,
                                        y: startingPoint.y + 4.62 * mult),
                      control2: CGPoint(x: startingPoint.x + 5.54  * mult,
                                        y: startingPoint.y + 3.74 * mult))
        
        path.closeSubpath()
        return path
    }
}

struct MyEye: View {
    let position:     CGPoint
    let size:         CGFloat
    let mainEyeColor: Color
    let sectorColor:  Color
    let pupilColor:   Color
    
    var body: some View {
        ZStack {
            // main eye body
            MainEye(startingPoint: position,
                    mult:          size)
            .foregroundStyle(mainEyeColor)
            
            // sector
            MyCircle(startingPoint: position,
                     radius:        size * 3)
            .foregroundStyle(sectorColor)

            
            // pupil
            MyCircle(startingPoint: position,
                     radius:        size * 0.95)
            .foregroundStyle(pupilColor)
        }

        .contentShape(MainEye(startingPoint: position, mult: size))
    }
}

#Preview {
    VStack {
        EyeSF(iconName:   "eye.fill",
             iconColor:  Colors.blackish,
             iconSize:   70,
             fontWeight: .thin)
        
        MainEye(startingPoint: CGPoint(x: 215,
                                       y: 419.5),
                   mult: 25)
        
//        MyEye(position: CGPoint(x: 215,
//                                y: 419.5),
//              size: 25,
//              mainEyeColor: .black,
//              sectorColor:  .red,
//              pupilColor:   .black)
    }
//    ZStack {
//        MainEye(startingPoint: CGPoint(x: 215,
//                                       y: 419.5),
//                   mult: 25)
//        
//        EyeSF(iconName:   "eye.fill",
//              iconColor:  .red,
//             iconSize:    230,
//             fontWeight:  .thin)
//        .opacity(0.5)
//    }
//    MyEye(position: CGPoint(x: 215,
//                            y: 419.5),
//          size: 25,
//          mainEyeColor: .black,
//          sectorColor:  .red,
//          pupilColor:   .black)
//    .onTapGesture{
//        print("Eye Tapped!!")
//    }
}

