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
    
    
    let reverb: CostelloReverb
    let dryWetReverb: DryWetMixer
    
    let delay: VariableDelay
    let dryWetDelay: DryWetMixer
    
    let filter: KorgLowPassFilter
    let dryWetFilter: DryWetMixer
    
    
    let clipper: Clipper
    let amplifier: Fader
    let dryWetClipper: DryWetMixer
    
    var samples: [Sample] = []
    
    @Published var clipperData = ClipperData() {
        didSet {
            clipper.$limit.ramp(to: clipperData.limit, duration: clipperData.rampDuration)
            if clipperData.limit > 0.25 {
                amplifier.gain = 1.0 / clipperData.limit
            }
            dryWetClipper.balance = clipperData.balance
        }
    }
    
    @Published var reverbData = CostelloReverbData() {
        didSet {
            reverb.$feedback.ramp(to: reverbData.feedback, duration: reverbData.rampDuration)
            reverb.$cutoffFrequency.ramp(to: reverbData.cutoffFrequency, duration: reverbData.rampDuration)
            dryWetReverb.balance = reverbData.balance
        }
    }
    
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
    
        let notes = data.noteStatus[track]
        if notes[(Int(position) + 1) % notes.count] {
            selectedTrack.sequence.add(noteNumber: MIDINoteNumber(note), position: round(position), duration: 0.95)
            if notes[Int(position) % notes.count] {
                if position == 0 {
                    selectedTrack.sequence.add(noteNumber: MIDINoteNumber(note), position: Double(selectedTrack.sequence.notes.count), duration: 0.95)
                }
                if Int(round(position)) == notes.count {
                    selectedTrack.sequence.add(noteNumber: MIDINoteNumber(note), position: 0.0, duration: 0.95)
                }
            }
        } else {
            selectedTrack.sequence.add(noteNumber: MIDINoteNumber(note), position: round(position), duration: 1.95)
        }
    

        
        
        
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
       
        Settings.bufferLength = .shortest
       
        
        
        
        clipper = Clipper(sampler)
        amplifier = Fader(clipper)
        dryWetClipper = DryWetMixer(sampler, amplifier)
        
        filter = KorgLowPassFilter(dryWetClipper)
        dryWetFilter = DryWetMixer(dryWetClipper, filter)
        
        delay = VariableDelay(dryWetFilter)
        dryWetDelay = DryWetMixer(dryWetFilter, delay)
        
        reverb = CostelloReverb(dryWetDelay)
        dryWetReverb = DryWetMixer(dryWetDelay, reverb)
        
        for _ in 0 ..< data.trackCount {
            let _ = sequencer.addTrack(for: sampler)
        }
        
        setupMetronome()
        updateSequence(note: 24, position: 0, track: 0)
        
        mixer.addInput(dryWetReverb)
        
        mixer.addInput(callbackInst)
        engine.output = mixer
    
        // add note info to every step on all tracks
        
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
