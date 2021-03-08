//
//  TestView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-05.
//

import SwiftUI
import Foundation

struct TestView: View {
    @State var gestureValue = 0
            var body: some View {
                
                
                
                Text("Hello, World!")
                    .frame(width: 150, height: 60)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(15)
                    .rotationEffect(Angle(degrees: Double(-gestureValue)))
                    .gesture(
                        DragGesture().onChanged({ (value) in
                            self.gestureValue = Int(value.translation.height)
                            print(max(0, gestureValue))
                        })
                        
                        .onEnded({ (value) in
                            self.gestureValue = Int(value.translation.height)
                        })
                        
                    )
             
                
                
                
                
            }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
        }
}
