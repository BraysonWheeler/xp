//
//  MinimumPasswordLengthView.swift
//  xp
//
//  Created by Logan Wheeler on 4/16/23.
//

import SwiftUI

struct PasswordSpecialCharacterCheckView: View {
    @Binding var password:String
    @State var color:Color = Color.gray
    @State var valid:Bool = false

    
    var body: some View {
        HStack {
            Image(systemName: checkSpecialCharacterValid(password: password) ? "checkmark.circle" : "xmark.circle")
            Text("Password contains one special character.")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5, alignment: .topLeading)
        .padding()
        .foregroundColor(checkSpecialCharacterValid(password: password) ? Color.green : Color.gray)
    }
    
}

struct PasswordSpecialCharacterCheckView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPasswordView()
    }
}
