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
                    }
                    Button("+") {
                        if conductor.data.tempo < 560 {
                            conductor.data.tempo += 4
                        }
                    }
                }.frame(width: 32, height: 32)
                
                MetronomeView(conductor: conductor)
            }
            
            
            HStack {
                SequencerView(conductor: conductor)
                
            }
            
            
            
            
            
            
            
            
            HStack {
                VStack {
                    //Text("\(Int(conductor.data.tempo / 4)) BPM").foregroundColor(.primary)
                    Image(systemName: "waveform.path.ecg.rectangle")
                        .resizable()
                        .foregroundColor(Color(UIColor.darkGray))
                        .frame(width: 38, height: 32)
                        .onTapGesture {
                            self.kitSelectionActive.toggle()
                        }.padding(.vertical)
                    Spacer()
                    PlayButtonView(conductor: conductor).padding(.vertical)

                    RecordButtonView(isRecording: $isRecording).padding(.vertical)
                }.frame(width: 68)
                
                
                VStack {
                    
                    PadsView(conductor: conductor, isRecording: isRecording) { pad in
                        conductor.playPad(padNumber: pad)
                    }
                }
                
                HStack {
                    VStack {
                        KorgLowPassFilterView(conductor: conductor).frame(width: viewWidth / 6)
                        VariableDelayView(conductor: conductor).frame(width: viewWidth / 6)
                    }
                    
                }
                
            }
            
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
