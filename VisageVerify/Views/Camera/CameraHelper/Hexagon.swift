//
//  HexagonOutline.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 24.08.2024.
//

import SwiftUI

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let x = rect.midY

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addLine(
            to: CGPoint(x: rect.minX,
                        y: x / 2))
        
        path.addLine(
            to: CGPoint(x: rect.minX,
                        y: x + x / 2))

        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.addLine(
            to: CGPoint(x: rect.maxX,
                        y: x + x / 2))
        
        path.addLine(
            to: CGPoint(x: rect.maxX,
                        y: x / 2))
        
        path.closeSubpath()
        return path
    }
}

struct Hexagon2: Shape {
    let distanceToVertex: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.midY - distanceToVertex))
        
        path.addLine(
            to: CGPoint(x: rect.midX - distanceToVertex * sqrt(3) / 2,
                        y: rect.midY - distanceToVertex / 2))
        
        path.addLine(
            to: CGPoint(x: rect.midX - distanceToVertex * sqrt(3) / 2,
                        y: rect.midY + distanceToVertex / 2))
        
        path.addLine(
            to: CGPoint(x: rect.midX,
                        y: rect.midY + distanceToVertex))
        
        path.addLine(
            to: CGPoint(x: rect.midX + distanceToVertex * sqrt(3) / 2,
                        y: rect.midY + distanceToVertex / 2))
        
        path.addLine(
            to: CGPoint(x: rect.midX + distanceToVertex * sqrt(3) / 2,
                        y: rect.midY - distanceToVertex / 2))
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    ZStack {
//            Circle()
//                .stroke(.black, style: StrokeStyle(lineWidth: 10))
        
//            HexagonOutline()
//                .stroke(.black, style: StrokeStyle(lineWidth: 10))
//                .frame(height: 600)

        Hexagon2(distanceToVertex: 100)
            .stroke(.black, style: StrokeStyle(lineWidth: 10))
        
        // .frame(width: 184, height: 140)
            
            // .padding()
    }
}
