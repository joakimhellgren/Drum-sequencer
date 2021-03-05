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
           
            HStack {
                PlayButtonView(conductor: conductor)
                Spacer()
                Text("Change kit")
                    .onTapGesture {
                        self.kitSelectionActive.toggle()
                    }
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
              
                Group {
                    Button("-") {
                        if conductor.data.tempo > 50 {
                            conductor.data.tempo -= 5
                        }
                    }
                    Button("+") {
                        if conductor.data.tempo < 560 {
                            conductor.data.tempo += 5
                        }
                    }
                }.frame(width: 32, height: 32)
                
                MetronomeView(conductor: conductor)
            }
            
            
            HStack {
                SequencerView(conductor: conductor)
                MuteButtonView(conductor: conductor)
            }
           
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
