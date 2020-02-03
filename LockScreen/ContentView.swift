//
//  ContentView.swift
//  LockScreen
//
//  Created by ramil on 03.02.2020.
//  Copyright © 2020 com.ri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapCount = UserDefaults.standard.string(forKey: "Taps") ?? ""
    
    var body: some View {
        VStack {
            
            Button("Tap count: " + tapCount) {
                var tapInt = Int(self.tapCount) ?? 0
                tapInt += 1
                self.tapCount = "\(tapInt)"
                UserDefaults.standard.set(self.tapCount, forKey: "Taps")
            }
            Spacer()
            
            SheetView(btnTitle: "Reset Passcode", showTriggers: false)
            
            Spacer()
            
            SheetView(btnTitle: "Lock Screen", showTriggers: true)
            
            Spacer()
            
            Image("100")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }.font(.custom("SFProText-Bold", size: 25))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SheetView: View {
    @State var btnTitle: String
    @State var showTriggers = true
    
    var body: some View {
        VStack {
            Button(self.btnTitle) {
                self.showTriggers = true
                
                if self.btnTitle == "Reset Passcode" {
                    UserDefaults.standard.set("", forKey: "pass")
                    UserDefaults.standard.set("Create New Passcode", forKey: "message")
                }
            }
        }.sheet(isPresented: $showTriggers, onDismiss: {
            print("sheet actions")
        }) {
            LockView()
        }
    }
}

struct LockView: View {
    @State private var text: String = ""
    @State private var titleMessage = UserDefaults.standard.string(forKey: "message") ?? "Create New Passcode"
    @State private var keyPass = UserDefaults.standard.string(forKey: "pass") ?? ""
    @State var errorMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(self.errorMessage).foregroundColor(.red)
            Text(self.titleMessage).font(.headline)
            
            TextField("Passcode Field", text: $text).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                
                if self.keyPass == self.text {
                    print("Incorrect Passcode")
                    
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: false, completion: {})
                    
                    print("done with", self.text)
                } else if self.keyPass == "" {
                    print("Start Settings")
                    UserDefaults.standard.set(self.text, forKey: "pass")
                    UserDefaults.standard.set("Input the passcode", forKey: "message")
                    
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: false, completion: {})
                } else {
                    print("Incorrect Passcode")
                    self.errorMessage = "Incorrect Passcode"
                }
            }) {
                Text("Done")
            }
            
            Spacer()
            
        }.font(.custom("SFProText-Bold", size: 25))
    }
}
