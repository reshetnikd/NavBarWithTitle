//
//  ContentView.swift
//  NavBarWithTitle
//
//  Created by Dmitry Reshetnik on 14.09.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let users = (1...100).map { number in "User \(number)" }
    @State private var text = ""

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List(self.users, id: \.self) { user in
                    NavigationLink(destination: Text("Detail for \(user)")) {
                        Text(user)
                    }
                }
                .navigationBarItems(leading:
                    HStack {
                        TextField("Users", text: self.$text)
                            .font(.largeTitle)
                            .lineLimit(1)
                            .foregroundColor(.black)
                        
                    }
                    .padding()
                    .position(CGPoint(x: geometry.size.width / 2, y: 40))
                    .frame(width: geometry.size.width)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
