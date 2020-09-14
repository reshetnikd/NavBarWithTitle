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
                    NavigationLink(destination: UserView(user: user)) {
                        Text(user)
                    }
                }.navigationBarTitle(Text("Users"), displayMode: .large)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserView: View {
    @State var user: String
    
    var body: some View {
        NavigationView {
            Text(self.user)
        }.navigationBarItems(trailing:
            HStack {
                TextField("\(user)", text: self.$user)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.black)
            }
            .padding(.trailing, 140)
        )
    }
}
