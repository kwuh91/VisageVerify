
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
    // @State var rotate = false
    @State var scale  = false
    @State var hide   = false
    
    var body: some View {

        SignUpButton(padding:  40,
                     fontSize: 46,
                     quantity: 150)

        .rotationEffect(
            scale ? Angle(degrees: 0.001) : Angle(degrees: 0)
        )
        .scaleEffect(scale ? 4 : 1, anchor: .center)
        .opacity(hide ? 0.0001 : 1)
        .onTapGesture {
            // scale animation
            withAnimation(
                Animation.easeInOut(
                    duration: 2.2
                )
            ){
                scale.toggle()
            }
            
            // opacity animation
            withAnimation(
                Animation.easeInOut(
                    duration: 2.0
                ).delay(0.2)
            ){
                hide.toggle()
            }
        }
    }
}

#Preview {
    Testing()
}
