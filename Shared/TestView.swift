//
//  TestView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-05.
//

import SwiftUI

struct TestView: View {
    @Binding var kitSelectionActive: Bool
    
    var body: some View {
        Text("congratus u managed to click something and get redirected here.")
            .onTapGesture {
                self.kitSelectionActive.toggle()
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
