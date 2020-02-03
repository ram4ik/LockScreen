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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
