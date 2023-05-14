//
//  SignUp.swift
//  xp
//

import SwiftUI



struct SignUpUsernameView: View {
    @State var username:String = ""
    @State var userMessage:String = ""
    @State var attempts: Int = 0
    @State var foregroundColor: Color = Color.black
    @EnvironmentObject var coordinator: Coordinator
    
    @State var messages:[Message] = []
    
    var body: some View {
        NavigationView(){
            GeometryReader { geo in
                VStack{
                    Spacer().frame(width: geo.size.width, height: geo.size.height/7)
                    Text("What's Your Username?").font(.system(size:20))
                    Text("You will be using this to login in a second.")
                    Spacer().frame(width: geo.size.width, height: geo.size.height/30)
                    HStack{
                        TextField("Username", text: $username).padding()
                    }
                    .frame(width: geo.size.width*0.9, height: geo.size.height/20)
                    .background(RoundedRectangle(cornerRadius: 10.0).stroke( lineWidth: 1))
                    .modifier(Shake(animatableData: CGFloat(attempts)))
                    .foregroundColor(foregroundColor)
                    Button("Continue"){
                        messages = validateUsername(username: username)
                        if messages.count != 0 {
                            withAnimation(.default) {
                                attempts+=1
                                foregroundColor = Color.red
                            }
                        }
                        else{
                            print("sucess")
                            coordinator.path.append("SignUpPasswordView")
                        }

                    }
                    .frame(width: geo.size.width*0.5, height: geo.size.height*0.04)
                    .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.green))
                    .foregroundColor(Color.white)
                    ForEach(messages){ msg in
                        Text("\(msg.text)").foregroundColor(Color.red)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:Button(action: {
                coordinator.path.removeLast()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
        )
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpUsernameView()
    }
}
