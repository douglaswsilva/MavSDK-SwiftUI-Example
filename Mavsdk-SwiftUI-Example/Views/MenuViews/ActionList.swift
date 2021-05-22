//
//  ActionList.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 13/05/21.
//

import SwiftUI

struct ActionList: View {
    var action = ActionViewModel()
    
    var body: some View {
        List {
            ButtonContent(text: "Arm", action: action.armAction)
            ButtonContent(text: "Disarm", action: action.disarmAction)
            ButtonContent(text: "TakeOff", action: action.takeOffAction)
            ButtonContent(text: "Land", action: action.landAction)
            ButtonContent(text: "RTL", action: action.rtlAction)
        }
        .listStyle(PlainListStyle())
    }
}

struct ActionList_Previews: PreviewProvider {
    static var previews: some View {
        ActionList()
    }
}

struct ButtonContent: View {
    @State var text: String
    @State var action: () -> ()
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action, label: {
                Text(text)
                    .font(.system(size: 14, weight: .medium, design: .default))
            })
            Spacer()
        }
        .padding()
    }
}
