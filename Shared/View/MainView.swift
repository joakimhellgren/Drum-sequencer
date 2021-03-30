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
    let viewWidth = UIScreen.main.bounds.width
    let viewHeight = UIScreen.main.bounds.height
    let lightGray = Color(UIColor.secondarySystemBackground)
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Button("-") {
                        if conductor.data.tempo > 50 {
                            conductor.data.tempo -= 4
                        }
                    }.accentColor(.red)
                    Button("+") {
                        if conductor.data.tempo < 560 {
                            conductor.data.tempo += 4
                        }
                    }.accentColor(.red)
                }.frame(width: 32, height: 32)
                MetronomeView(conductor: conductor)
            }
            
            SequencerView(conductor: conductor)
            
            HStack {
                VStack {
                    Image(systemName: "waveform.path.ecg.rectangle")
                        .resizable()
                        .foregroundColor(Color(UIColor.darkGray))
                        .frame(maxWidth: 38, maxHeight: 32)
                        .onTapGesture {
                            self.kitSelectionActive.toggle()
                        }.padding(.vertical)
                    Spacer()
                    PlayButtonView(conductor: conductor).padding(.vertical)
                    RecordButtonView(isRecording: $isRecording).padding(.vertical)
                }.frame(maxWidth: 68)
                
                VStack {
                    PadsView(conductor: conductor, isRecording: isRecording) { pad in
                        conductor.playPad(padNumber: pad)
                    }
                }
                
                VStack {
                    HStack {
                        VStack {
                            KorgLowPassFilterView(conductor: conductor)
                            VariableDelayView(conductor: conductor)
                        }
                        
                        VStack {
                            CostelloReverbView(conductor: conductor)
                            ClipperView(conductor: conductor)
                        }
                    }
                }
            }.padding()
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
