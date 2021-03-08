//
//  SequencerConductor.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import Foundation
import AVFoundation
import AudioKit

class SequencerConductor: ObservableObject {
    let engine = AudioEngine()
    let sampler = AppleSampler()
    var callbackInst = CallbackInstrument()
    let mixer = Mixer()
    var sequencer = Sequencer()
    
    //let reverb: Reverb
    
    let delay: VariableDelay
    let dryWetDelay: DryWetMixer
    
    let filter: KorgLowPassFilter
    let dryWetFilter: DryWetMixer
    
    var samples: [Sample] = []
    
    @Published var filterData = KorgLowPassFilterData() {
        didSet {
            filter.$cutoffFrequency.ramp(to: filterData.cutoffFrequency, duration: filterData.rampDuration)
            filter.$resonance.ramp(to: filterData.resonance, duration: filterData.rampDuration)
            filter.$saturation.ramp(to: filterData.saturation, duration: filterData.rampDuration)
            dryWetFilter.balance = filterData.balance
        }
    }
    
    @Published var delayData = VariableDelayData() {
        didSet {
            delay.$time.ramp(to: delayData.time, duration: delayData.rampDuration)
            delay.$feedback.ramp(to: delayData.feedback, duration: delayData.rampDuration)
            dryWetDelay.balance = delayData.balance
        }
    }
    
    @Published var data = SequencerData() {
        didSet {
            data.isPlaying ? sequencer.play() : sequencer.stop()
            sequencer.tempo = data.tempo
        }
    }
    
    func addTrack(name: String, file: String, note: Int) {
        
        // shut down process
        stop()
        // setup process
        //let sample = Sample(name, file: file, note: note)
        //data.samples.append(sample)
        data.notes.append(note)
        data.noteStatus.append([false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false])
        data.trackSignature.append(16)
        data.trackCount += 1
        
        let _ = sequencer.addTrack(for: sampler)
        //start()
        setupMetronome()
        updateSequence(note: note, position: 0, track: data.trackCount - 1)
        
    }
    
    func updateSequence(note: Int, position: Double, track: Int) {
        var selectedTrack = sequencer.tracks[track]
        selectedTrack.sequence.add(noteNumber: MIDINoteNumber(note), position: round(position), duration: 0.95)
        
        selectedTrack = sequencer.tracks[data.trackCount]
        selectedTrack.length = Double(data.metronomeSignature)
        selectedTrack.clear()
        for beat in 0 ..< data.metronomeSignature {
            selectedTrack.sequence.add(noteNumber: MIDINoteNumber(beat), position: Double(beat), duration: 0.1)
        }
    }
    
    func setupMetronome() {
        callbackInst = CallbackInstrument(midiCallback: { (_, beat, _) in
            self.data.currentBeat[0] = Int(beat)
            for track in 0 ..< self.data.trackSignature.count {
                let currentPos = Int(self.sequencer.tracks[track].currentPosition.rounded())
                let timeSign = self.data.trackSignature[track]
                if currentPos == timeSign {
                    self.sequencer.tracks[track].rewind()
                    print("rewinded track: \(track)")
                }
            }
        })
        
        let _ = sequencer.addTrack(for: callbackInst)
    }
    
    init() {
        
        
        
        filter = KorgLowPassFilter(sampler)
        dryWetFilter = DryWetMixer(sampler, filter)
        
        delay = VariableDelay(dryWetFilter)
        dryWetDelay = DryWetMixer(dryWetFilter, delay)
        
        //reverb = Reverb(dryWetDelay)
        //reverb.dryWetMix = 0.12
        
        for _ in 0 ..< data.trackCount {
            let _ = sequencer.addTrack(for: sampler)
        }
        
        setupMetronome()
        updateSequence(note: 24, position: 0, track: 0)
        
        mixer.addInput(dryWetDelay)
        
        mixer.addInput(callbackInst)
        engine.output = mixer
        
        // add notes to every step on all tracks
        
        print(data.noteStatus)
        for _ in 1 ..< data.metronomeSignature {
            for trackIndex in 0 ..< data.noteStatus.count {
                data.noteStatus[trackIndex].append(false)
            }
            
        }
        
        for track in sequencer.tracks {
            for index in 0 ..< data.trackSignature.count {
                track.length = Double(data.trackSignature[index])
            }
        }
    }
    
    func playPad(padNumber: Int) {
        print(padNumber)
        try? sampler.play(noteNumber: MIDINoteNumber(samples[padNumber].midiNote))
        let fileName = samples[padNumber].fileName
        let lastPlayed = fileName.components(separatedBy: "/").last ?? "Name error"
        print(lastPlayed)
    }
    
    func start(kit: Int) {
        samples = data.samples[kit]
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
        
        do {
            let files = samples.map {
                $0.audioFile!
            }
            try sampler.loadAudioFiles(files)
        } catch {
            Log("Files didn't load")
        }
    }
    
    func stop() {
        sequencer.stop()
        engine.stop()
    }
    
    
    
    
}
