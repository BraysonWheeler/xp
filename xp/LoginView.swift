import SwiftUI

func authenticateUser(username:String, password:String) -> Bool{
    if username != "" && password != "" {
        return true
    }
    return false
}

struct MyCustomEnvironmentKey: EnvironmentKey {
    static var defaultValue: String = "default"
}


struct LoginView: View {
    // Tells swift to monitor this value for change and reload when necessary
    @State var x = false
    @State var username:String = ""
    @State var password:String = ""
    @State var generalForeGroundColor:Color = Color.gray
    @State var loginForeGroundColor:Color = Color.gray
    @State var passwordForeGroundColor:Color = Color.gray
    @State var loginButtonBackGroundColor:Color = Color.green
    @State var attempts: Int = 0
    @State var loginSuccess: Bool = false
    @State var signUp: Bool = false
    @ObservedObject var coordinator = Coordinator()
    
    var body: some View {
        let cornerRadius = 10.0

        NavigationStack(path:$coordinator.path) {
            GeometryReader { geo in
                VStack {
                    Spacer().frame(width: geo.size.width, height: geo.size.height/7)
                    
                    Text("XP")
                        .font(.system(size:20))
                        .frame(width: geo.size.width)
                    
                    Spacer().frame(width: geo.size.width, height: geo.size.height/40)
                    
                    HStack {
                        TextField("User Name", text: $username).padding()
                        Image(systemName: "person.and.background.dotted").padding()
                    }
                    .frame(width: geo.size.width/1.3, height: geo.size.height/20)
                    .background(RoundedRectangle(cornerRadius: cornerRadius).stroke( lineWidth: 1))
                    .foregroundColor(loginForeGroundColor)
                    .onTapGesture {
                        loginForeGroundColor = Color.black
                        passwordForeGroundColor = Color.gray
                    }
                    
                    Spacer().frame(width: geo.size.width, height: geo.size.height/55)
                    
                    HStack {
                        TextField("Password", text: $password).padding()
                        Image(systemName: "lock").padding()
                    }
                    .frame(width: geo.size.width/1.3, height: geo.size.height/20)
                    .background(RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 1))
                    .foregroundColor(passwordForeGroundColor)
                    .modifier(Shake(animatableData: CGFloat(attempts)))
                    .onTapGesture {
                        loginForeGroundColor = Color.gray
                        passwordForeGroundColor = Color.black
                    }
                    
                    Spacer().frame(width: geo.size.width, height: geo.size.height/55)
                    
                    Button(action: {
                        if authenticateUser(username: username, password: password) {
                            loginSuccess = true
                            coordinator.path.append("SkillsView")
                            print(loginSuccess)
                            
                        }
                        else{
                            // Makes password Shake
                            withAnimation(.default) {
                                self.attempts += 1
                                loginForeGroundColor = Color.red
                                passwordForeGroundColor = Color.red
                            }
                        }
                        
                    }, label: { Text("Login")
                            .frame(width: geo.size.width/1.5, height: geo.size.height/25)
                            .background(loginButtonBackGroundColor)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    }
                    )
                    
                    Spacer().frame(width: geo.size.width, height: geo.size.height/55)
                    
                    Button(action: {
                        signUp = true
                        print("sign up")
                        coordinator.path.append("SignUpView")
                    }, label: { Text("Sign Up")
                            .frame(width: geo.size.width/1.5, height: geo.size.height/25)
                            .background(RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 1))
                            .foregroundColor(generalForeGroundColor)
                        
                    })
                }
            }
            .background(Color.white)
            .navigationDestination(for: String.self) { string in
                switch string{
                        case "SignUpView":
                            SignUpUsernameView()
                        case "SkillsView":
                            SkillsView()
                        case "SignUpPasswordView":
                            SignUpPasswordView()
                        default:
                            Text("No view has been set for \(string)")
                    }
            }
        }.environmentObject(coordinator)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
