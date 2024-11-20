//
//  MenuButton.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

struct MenuButton: View {
    var text: String
    var fontSize: CGFloat
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Image("menuBtn")
                    .resizable()
                    .scaledToFit()
                Text(text)
                    .font(.custom("AbhayaLibre-Regular", size: fontSize))
                    .foregroundColor(.white)
            }
            .padding(-5)
        })
      
        //.background(Color.green)
        
    }
}



#Preview {
    MenuButton(text: "Hello", fontSize: 25) {
        print("Test")
    }
        .frame(height: 88)
       
}
