//
//  MinimumPasswordLengthView.swift
//  xp
//
//  Created by Logan Wheeler on 4/16/23.
//

import SwiftUI

struct MinimumPasswordLengthView: View {
    @Binding var password:String
    
    var body: some View {
        HStack {
            Image(systemName: checkPasswordLengthValid(password: password) ? "checkmark.circle" : "xmark.circle")
            Text("Password must be atleast 8 character")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5, alignment: .topLeading).padding().foregroundColor(password.count > 10 ? Color.green : Color.gray)
    }
}

struct MinimumPasswordLengthView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPasswordView()
    }
}
