
import SwiftUI

//struct Testing: View {
//    @Namespace var namespace
//    @State var show = false
//    
//    var body: some View {
//        ZStack {
//            if !show {
//                SignUpButton(padding:  40,
//                             fontSize: 46,
//                             quantity: 150)
//                    .matchedGeometryEffect(id: "title", in: namespace)
//                    .padding(1)
//            } else {
//                SignUpButton(padding:  40,
//                             fontSize: 46,
//                             quantity: 150)
//                    .matchedGeometryEffect(id: "title", in: namespace)
//                    .padding(-200)
//                    //.opacity(0)
//            }
//        }
//        .onTapGesture {
//            withAnimation {
//                show.toggle()
//            }
//        }
//    }
//}

struct Testing: View {
    //    let iconName:   String
    //    let iconColor:  Color
    //    let iconSize:   CGFloat
    //    let fontWeight: Font.Weight
    
    @State private var action  = false
    @State private var pulsate = false
    
    var body: some View {
        ZStack {
            // background color
            Colors.boneColor
                .ignoresSafeArea()
                
            // main body
            ZStack {
                // eye
                Icon(iconName:   "eye.fill",
                     //                 iconColor:  action ? .red : Colors.blackish,
                     iconColor:  .black,
                     iconSize:   70,
                     fontWeight: .thin)
                .rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
                .scaleEffect(action ? 4 : 1)
                //.opacity(0)
                
                // pupil
                Circle()
                    .frame(height: action ? 30 * 3.1 : 0) // 20 -> 30
                    .foregroundStyle(action ? .red : Colors.blackish)
                    // .scaleEffect(pulsate ? 3.1 : 1)
                    // .opacity(action ? 1 : 0)
                
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   action ? 100 : 1,
                     fontWeight: .thin)
                //.rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
                // .scaleEffect(action ? 90 : 1)
                
                //            Icon(iconName:   "eye.fill",
                //                 iconColor:  Colors.blackish,
                //                 iconSize:   action ? 50 : 1,
                //                 fontWeight: .thin)
                // .rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
                // .scaleEffect(action ? 90 : 1)
            }
            .onTapGesture {
                // rotate
                // scale
                // color
                withAnimation (
                    Animation.easeInOut(
                        duration: 2
                    )
                ){
                    action.toggle()
                }
                
                // pulsate
                withAnimation(
                    Animation.easeInOut(
                        duration: 2
                    ).repeatForever(autoreverses: true).delay(1)
                ){
                    pulsate.toggle()
                }
            }
        }
    }
}
    
#Preview {
    Testing()
}
