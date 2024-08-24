//
//  HexagonCameraFigure.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI

struct HexagonFigureMain: View {
    
    let size:        CGFloat
    let strokeColor: Color
    let strokeStyle: StrokeStyle
    
    var body: some View {
        
        // frist row
        Group {
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: -105)
            
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: 35)
        }
        .offset(y: -240)
        
        // second row
        Group {
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: -105)
            
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: 35)
        }
        .offset(x: 70,y: -120)
        
        // third row (initial row)
        Group {
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: -105)
            
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: 35)
        }
        
        // fourth row
        Group {
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: -105)
            
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: 35)
        }
        .offset(x: 70,y: 120)
        
        // fifth row
        Group {
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: -105)
            
            Hexagon2(distanceToVertex: size)
                .stroke(strokeColor, style: strokeStyle)
                .offset(x: 35)
        }
        .offset(y: 240)
    }
}


struct HexagonFigureHelper: View {
    
    let size:  CGFloat
    let color: Color
    
    var body: some View {

        Hexagon2(distanceToVertex: size)
            .foregroundStyle(color)
            .offset(x: -105)
            .offset(x: -70,
                    y: -120)
        
        Hexagon2(distanceToVertex: size)
            .foregroundStyle(color)
            .offset(x: -105)
            .offset(x: -70,
                    y: 120)
        
        Hexagon2(distanceToVertex: size)
            .foregroundStyle(color)
            .offset(x: -105)
            .offset(x: 280)
        
        Hexagon2(distanceToVertex: size)
            .foregroundStyle(color)
            .offset(x: -105)
            .offset(x: 280,
                    y: 240)
        
        Hexagon2(distanceToVertex: size)
            .foregroundStyle(color)
            .offset(x: -105)
            .offset(x: 280,
                    y: -240)
        
        Group {
            Hexagon2(distanceToVertex: size)
                .foregroundStyle(color)
                .offset(x: -105)
                .offset(x: -70,
                        y: 360)
            
            Hexagon2(distanceToVertex: size)
                .foregroundStyle(color)
                .offset(x: -105 + 70)
                .offset(y: 360)
            
            Hexagon2(distanceToVertex: size)
                .foregroundStyle(color)
                .offset(x: -105 + 70 + 140)
                .offset(y: 360)
        }
        
        Group {
            Hexagon2(distanceToVertex: size)
                .foregroundStyle(color)
                .offset(x: -105)
                .offset(x: -70,
                        y: 360)
            
            Hexagon2(distanceToVertex: size)
                .foregroundStyle(color)
                .offset(x: -105 + 70)
                .offset(y: 360)
            
            Hexagon2(distanceToVertex: size)
                .foregroundStyle(color)
                .offset(x: -105 + 70 + 140)
                .offset(y: 360)
        }.offset(y: -120 * 6)
    }
}

struct HexagonFigureFillingTheBlanks: View {
    var blanksStrokeColor: Color       = .red
    var blanksStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 22)
    
    var helperColor: Color = .purple
    
    var body: some View {
        ZStack {
            // helper
            HexagonFigureHelper(size: 81,
                          color: helperColor)
            
            // blanks
            HexagonFigureMain(size: 80.25,
                              strokeColor: blanksStrokeColor,
                              strokeStyle: blanksStrokeStyle)
        }
    }
}

struct HexagonFigureFireFlies: View {
    var quantity: Int
    
    var mainStrokeColor: Color       = .green
    var mainStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 5)
    
    var body: some View {
        FloatingFireflies(quantity: quantity)
            .mask(
                ZStack {
                    HexagonFigureMain(size: 70,
                                      strokeColor: mainStrokeColor,
                                      strokeStyle: mainStrokeStyle)
                }
            )
    }
}

struct HexagonFigure: View {
    
    var quantity: Int
    
    var mainStrokeColor: Color       = .green
    var mainStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 5)
    
    var blanksStrokeColor: Color       = .red
    var blanksStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 22)
    
    var helperColor: Color = .purple
    
    var body: some View {
        ZStack {
            HexagonFigureFillingTheBlanks(blanksStrokeColor: blanksStrokeColor,
                                          blanksStrokeStyle: blanksStrokeStyle,
                                          helperColor: helperColor)
            
            HexagonFigureFireFlies(quantity: quantity,
                                   mainStrokeColor: mainStrokeColor,
                                   mainStrokeStyle: mainStrokeStyle)
        }
    }
}

#Preview {
        ZStack {
            Colors.blackish
                .ignoresSafeArea()
    
//            Rectangle()
//                .frame(width: 330,
//                       height: 620)
//                .foregroundStyle(.blue)
  
            HexagonFigure(quantity: 100,
                          blanksStrokeColor: Colors.blackish,
                          helperColor: Colors.blackish)
        }
}
