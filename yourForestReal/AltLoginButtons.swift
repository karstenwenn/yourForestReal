//
//  AltLoginButtons.swift
//  yourForestReal
//
//  Created by Karsten Wennerlund on 7/1/24.
//

import SwiftUI

struct AltPlatform: Hashable {
    let name: String
    let icon: String
    let color: Color
    var hasColor = false
}

var altPlatforms: [AltPlatform] = [.init(name:"Google", icon: "google.logo", color: .gray.opacity(0.08)),
                                   .init(name: "Apple", icon: "apple.logo", color: .white, hasColor: true),
                             //.init(name: "PC", icon: "pc", color: .pink),
                             //.init(name: "Mobile", icon: "iphone", color: .mint)
]

struct AltLoginButtons: View {
    var body: some View {
        HStack{ //replace with navigation link later on
            ForEach(altPlatforms, id: \.name) { curPlatform in
                HStack {
                    Image(systemName: curPlatform.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                }
                .foregroundStyle(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray ,lineWidth: 0.8)
                    .background(curPlatform.color)
                    .clipped())
                
                //.clipShape(Capsule())
                .onTapGesture {
                    withAnimation{
                        
                    }
                }
                
                
                
//                Label(curPlatform.name, systemImage: curPlatform.imageName)
//                    .foregroundColor (curPlatform.color)
//
                
//                ZStack{
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(curPlatform.color)
//                    systemImage(curPlatform.imageName)
//                }
                
            }
            //.scaledToFit()

                
        }
    }
}

#Preview {
    AltLoginButtons()
}
