import SwiftUI

struct SignUpPasswordView: View {
    @State var password:String = ""
    @State var attempts:Int = 0
    @State var foregroundColor: Color = Color.black
    @EnvironmentObject var coordinator: Coordinator

        
    var body: some View {
        NavigationView(){
            GeometryReader { geo in
                VStack{
                    Spacer().frame(width: geo.size.width, height: geo.size.height/7)
                    Text("Create a Password").font(.system(size:20))
                    Text("You will be using this to login in a second.")
                    Spacer().frame(width: geo.size.width, height: geo.size.height/30)
                    HStack{
                        TextField("Password", text: $password).padding()
                    }
                    .frame(width: geo.size.width*0.9, height: geo.size.height/20)
                    .background(RoundedRectangle(cornerRadius: 10.0).stroke( lineWidth: 1))
                    .modifier(Shake(animatableData: CGFloat(attempts)))
                    .foregroundColor(foregroundColor)
                    Spacer().frame(width: geo.size.width, height: geo.size.height/30)
                    
                    PasswordSubmitButton(password: $password, title: "Continue", geo: geo)
                    MinimumPasswordLengthView(password: $password)
                    PasswordSpecialCharacterCheckView(password: $password)

                    
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

struct SignUpPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPasswordView()
    }
}
