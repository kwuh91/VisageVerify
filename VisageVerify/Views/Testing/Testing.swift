
import SwiftUI
// import PythonKit

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

//struct Testing: View {
//    let initialSize:     CGFloat
//    let scaleMultiplier: CGFloat
//    
//    @State private var action  = false
//    
//    var body: some View {
//        ZStack {
//            // background color
//            Colors.boneColor
//                .ignoresSafeArea()
//                
//            // main body
//            ZStack {
//                // eye 1
//                Icon(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   30,
//                     fontWeight: .thin)
//                .rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
//                .scaleEffect(action ? 2 : 1)
//                
//                // pupil
//                Circle()
//                    .frame(height: action ? 15 : 1)
//                    .foregroundStyle(action ? .red : Colors.blackish)
//                
//                // eye 2
//                Icon(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   action ? 20 : 1,
//                     fontWeight: .thin)
//            }
//            .onTapGesture {
//                // rotate
//                // scale
//                // color
//                withAnimation (
//                    Animation.easeInOut(
//                        duration: 2
//                    )
//                ){
//                    action.toggle()
//                }
//            }
//        }
//    }
//}
  
//struct Testing: View {
//    
////    @State private var action  = false
//    
//    var body: some View {
//        ZStack{
//            // background color
////            Colors.boneColor
////                .edgesIgnoringSafeArea(.all)
//            
//            // eye 1
//            EyeSF(iconName:   "eye.fill",
//                 iconColor:  .black,
//                 iconSize:   30,
//                 fontWeight: .thin)
//            
//            // generate eyes and put them on screen
//            ForEach(0..<150, id: \.self) { _ in
//                EyeSF(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   CGFloat.random(in: 10...50),
//                     fontWeight: .thin)
//                .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
//                          y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
//            }
//        }
////        .onTapGesture {
////            withAnimation (
////                Animation.spring(
////                    duration: 2
////                )
////            ){
////                action.toggle()
////            }
////        }
//    }
//}
    
//struct Testing: View {
//    var body: some View {
//        Button {
//            MultipleBlinkingEyes(...)
//        } label: {
//            Text("Tap me!")
//        }
//    }
//}
//

//struct Testing: View {
//    @State private var showEyes = false
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                showEyes.toggle()
//            }) {
//                Text("Tap me!")
//            }
//            
//            if showEyes {
//                ZStack {
//                    Color.blue.ignoresSafeArea() // Background color or any other background view
//                    MultipleBlinkingEyes(
//                        quantity: 10,
//                        mainEyeColor: .white,
//                        sectorColor: .black,
//                        pupilColor: .red
//                    )
//                }
//                // .transition(.slide)
//                .animation(.default)
//            }
//        }
//    }
//}
//
//#Preview {
//    Testing()
//}

//// Shared state object
//class ButtonTapState: ObservableObject {
//    @Published var isButtonTapped: Bool = false
//}
//
//// View1 with button
//struct View1: View {
//    @ObservedObject var buttonTapState: ButtonTapState
//
//    var body: some View {
//        Button(action: {
//            buttonTapState.isButtonTapped = true
//        }) {
//            Text("Tap me")
//        }
//    }
//}
//
//// View2 observing the button tap state
//struct View2: View {
//    @StateObject private var buttonTapState = ButtonTapState()
//
//    var body: some View {
//        VStack {
//            View1(buttonTapState: buttonTapState)
//            Text(buttonTapState.isButtonTapped ? "Button from View1 tapped!" : "Waiting for tap...")
//        }
//        .onChange(of: buttonTapState.isButtonTapped) {
//            print("Button from View1 tapped!")
//            
//            // Reset the state if needed
//            // buttonTapState.isButtonTapped = false
//        }
//    }
//}

// struct Testing: View  {
//    @State private var inputString:  String = ""
//    @State private var outputString: String = "Press me"
//    
//    @State private var scriptCalled: Bool = false
//    
//    @State private var num1: String = ""
//    @State private var num2: String = ""
//    
//    var body: some View {
//        VStack {
//            TextField("Enter a string", text: $inputString)
//            
//            Text("Enter two numbers:")
//            HStack {
//                TextField("number 1", text: $num1)
//                
//                TextField("number 2", text: $num2)
//            }
//            
//            Button(action: {
//                self.callPythonScript(str:  inputString,
//                                      num1: Int(num1) ?? 0,
//                                      num2: Int(num2) ?? 0)
//            }) {
//                Text(outputString)
//            }
//            
//            Text(outputString)
//                .padding()
//                .opacity(scriptCalled ? 1 : 0)
//        }
//        .textFieldStyle(RoundedBorderTextFieldStyle())
//        .padding()
//    }
//    
//    func callPythonScript(str: String, num1: Int, num2: Int) {
//        let sys = Python.import("sys")
//        sys.path.append("/Users/nikita/VScodeProjects/stuff/stuff")
//        
//        let script: PythonObject
//        do {
//            script = try Python.attemptImport("scriptForSwift")
//        } catch {
//            print("Error importing Python script: \(error)")
//            outputString = "Error importing script"
//            return
//        }
//
//        let result: PythonObject
//        do {
//            result = script.returnString(str, num1, num2)
//        } catch {
//            print("Error calling Python function: \(error)")
//            outputString = "Error calling function"
//            return
//        }
//
//        // Ensure the Python result is properly converted to a Swift String
//        outputString = String(result) ?? "Conversion failed"
//        
//        withAnimation(Animation.spring(duration: 1, bounce: 0.7)) {
//            scriptCalled.toggle()
//        }
//    }
//    var body: some View {
//        Text("Running Python Script...")
//            .onAppear {
//                runPythonScript()
//            }
//    }
//    
//    func runPythonScript() {
//        let sys = Python.import("sys")
//        sys.path.append("/Users/nikita/VScodeProjects/stuff/stuff")
//        
//        let script = Python.import("scriptForSwift.py") // Import your Python script
//        let result = script.test() // Call a function from your script
//        
//        print(result)
//    }
//}
//
//#Preview {
//    Testing()
//}

import SwiftUI

struct Testing: View {
    @State private var getResult: String = ""
    @State private var postResult: String = ""

    let ip = "91.107.123.50"

    var body: some View {
        VStack {
            Text("GET Request Result:")
            Text(getResult)
                .padding()
            
            Button("Send GET Request") {
                sendGetRequest()
                print("sent get request")
            }
            .padding()

            Text("POST Request Result:")
            Text(postResult)
                .padding()
            
            Button("Send POST Request") {
                sendPostRequest()
            }
            .padding()
        }
    }

    func sendGetRequest() {
        guard let url = URL(string: "http://\(ip):5000/echo?input_string=yepyepyep") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.getResult = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.getResult = "No data or response."
                }
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.getResult = String(decoding: data, as: UTF8.self)
                }
            } else {
                DispatchQueue.main.async {
                    self.getResult = "Error: \(response.statusCode)"
                }
            }
        }

        task.resume()
    }

    func sendPostRequest() {
        guard let url = URL(string: "http://\(ip):5000/upload"),
              let filePath = Bundle.main.path(forResource: "ben", ofType: "jpeg"),
              let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            print("Invalid URL or file path")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"ben.jpeg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.postResult = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.postResult = "No data or response."
                }
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.postResult = String(decoding: data, as: UTF8.self)
                }
            } else {
                DispatchQueue.main.async {
                    self.postResult = "Error: \(response.statusCode)"
                }
            }
        }

        task.resume()
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

#Preview {
    Testing()
}
