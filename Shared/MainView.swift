//
//  MainView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var conductor = SequencerConductor()
    @State var isRecording: Bool = false
    @Binding var kitSelectionActive: Bool
    @State var kit: Int
    
    let lightGray = Color(UIColor.secondarySystemBackground)
    
    var body: some View {

            
        VStack {
            Text("congratus u managed to click something and get redirected here.")
                .onTapGesture {
                    self.kitSelectionActive.toggle()
                }
            HStack {
                PlayButtonView(conductor: conductor)
                Spacer()
                Text("Change kit")
                Spacer()
                RecordButtonView(isRecording: $isRecording)
            }.frame(height: 32).padding(8)
            
            Spacer()
            
            HStack {
                ZStack {
                    Rectangle().foregroundColor(Color(UIColor.secondarySystemBackground))
                    Text("\(Int(conductor.data.tempo)) BPM").foregroundColor(.primary)
                }.frame(width: 100, height: 32)
                Spacer()
            }
            
            HStack {
                VStack {
                    Stepper("", onIncrement: {
                        if conductor.data.tempo < 560 {
                            conductor.data.tempo += 5
                        }
                    }, onDecrement: {
                        if conductor.data.tempo > 50 {
                            conductor.data.tempo -= 5
                        }
                    })
                    .frame(width: 100)
                }
                MetronomeView(conductor: conductor)
            }
            
            
            HStack {
                SequencerView(conductor: conductor)
                MuteButtonView(conductor: conductor)
            }
            Spacer()
            PadsView(conductor: conductor, isRecording: isRecording) { pad in
                    conductor.playPad(padNumber: pad)
            }.frame(height: 128)
            
        }
        .onAppear {
            self.conductor.start(kit: kit)
            print("initiated MainView.swift with kit: \(kit)")
        }
        .onDisappear {
            self.conductor.stop()
        }
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
