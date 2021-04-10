//
//  MainView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var conductor = SequencerConductor()
    
    @Binding var kitSelectionActive: Bool
    @State var kit: Int
    
    @State var isRecording: Bool = false
    @State var padViewActive: Bool = true
    
    let viewWidth = UIScreen.main.bounds.width, viewHeight = UIScreen.main.bounds.height, lightGray = Color(UIColor.secondarySystemBackground)
    
    var body: some View {
        var data = conductor.data
        VStack {
            // Main timeline / metronome view.
            HStack {
                VStack {
                    Button("-") { if data.tempo > 50 { data.tempo -= 4 }}
                        .accentColor(.red)
                    Button("+") { if data.tempo < 860 { data.tempo += 4 }}
                        .accentColor(.red)
                }.frame(minWidth: 24)
                MetronomeView(conductor: conductor)
            }
            
            // Main sequencer (top part of the screen)
            SequencerView(conductor: conductor)
            
            // Drum pads + Effects
            HStack {
                if padViewActive {
                    PadsView(conductor: conductor, isRecording: isRecording) { pad in
                        conductor.playPad(padNumber: pad)
                    }
                } else {
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
            
            // Switch view / Play button + Record button (AKA bottom bar, i guess?)
            HStack {
                Image(systemName: padViewActive ? "waveform.path.ecg.rectangle" : "waveform.path.ecg.rectangle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(UIColor.darkGray))
                    .onTapGesture {
                        //self.kitSelectionActive.toggle()
                        self.padViewActive.toggle()
                    }.padding(.vertical)
                Spacer()
                PlayButtonView(conductor: conductor).padding(.vertical)
                RecordButtonView(isRecording: $isRecording).padding(.vertical)
            }.padding(.horizontal)
            .frame(height: 18)
            
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
