import SwiftUI

enum KeychainError: Error {
    case noPassword
    case duplicateItem
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

struct PasswordSubmitButton: View {
    @Binding var password: String
    @State var isDisabled: Bool = true
    @State var successfullAccountCreation: Bool? = nil
    let title: String
    let geo: GeometryProxy
    
    var body: some View {
        Button(action:{print("asd")}) {
            Text(title)
        }
        .disabled((checkPasswordLengthValid(password: password) == true && checkSpecialCharacterValid(password: password) == true) ? false : true)
        .frame(width: geo.size.width*0.5, height: geo.size.height*0.04)
        .background(RoundedRectangle(cornerRadius: 10.0).fill(password.count > 10 ? Color.green : Color.gray))
        .foregroundColor(Color.white)
    }
    
    func create(username:String, password:String) -> Bool {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: username,
                                    kSecAttrService as String: "xp-app",
                                    kSecValueData as String: password.data(using: String.Encoding.utf8) as Any]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            return false
        }
        return true
    }
}

struct PasswordSubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        @State var pwd: String = ""
        VStack{
            SignUpPasswordView()
        }
    }
}
