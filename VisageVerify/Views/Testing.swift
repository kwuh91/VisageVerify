
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
    let initialSize:     CGFloat
    let scaleMultiplier: CGFloat
    
    @State private var action  = false
    
    var body: some View {
        ZStack {
            // background color
            Colors.boneColor
                .ignoresSafeArea()
                
            // main body
            ZStack {
                // eye 1
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   30,
                     fontWeight: .thin)
                .rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
                .scaleEffect(action ? 2 : 1)
                
                // pupil
                Circle()
                    .frame(height: action ? 15 : 1)
                    .foregroundStyle(action ? .red : Colors.blackish)
                
                // eye 2
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   action ? 20 : 1,
                     fontWeight: .thin)
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
            }
        }
    }
}
    
#Preview {
//    Testing(initialSize: 70, scaleMultiplier: 4)
    Testing(initialSize: 30, scaleMultiplier: 4)
}
