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
    @State private var text = ""
    @State var user: String
    @State var showingTextField = false
    
    var body: some View {
        NavigationView {
            Text(self.user)
        }
//        .navigationBarTitle(Text(self.user), displayMode: .inline)
        .navigationBarItems(leading: HStack {
            Button(action: {
                self.showingTextField.toggle()
            }, label: {
                Image("pencil")
                    .resizable()
                    .foregroundColor(.black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 20, alignment: .center)
            })
        }, trailing: CustomTextField(text: $user, isFirstResponder: showingTextField)
            .frame(width: 175, height: 50)
            .background(Color.clear)
        )
    }
}

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
