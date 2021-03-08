//
//  RecordButtonView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-05.
//

import SwiftUI

struct RecordButtonView: View {
    
    @Binding var isRecording: Bool
    var body: some View {
        Group {
            Circle()
                .strokeBorder(Color(UIColor.darkGray), lineWidth: 3)
                .frame(width: 32, height: 32)
                .background(Circle().foregroundColor(isRecording ? Color.red : Color.clear))
                .onTapGesture {
                    isRecording.toggle()
                }
        }
    }
}

