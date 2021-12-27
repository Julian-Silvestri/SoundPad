//
//  Model.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-27.
//

import Foundation


struct RecordingsList {
    let recording1: String?
    let recording2: String?
    let recording3: String?
    let recording4: String?
    let recording5: String?
    let recording6: String?
    let recording7: String?
    let recording8: String?
    
    init(recording1: String, recording2: String, recording3: String, recording4: String, recording5: String, recording6: String, recording7: String, recording8: String) {
        self.recording1 = recording1
        self.recording2 = recording2
        self.recording3 = recording3
        self.recording4 = recording4
        self.recording5 = recording5
        self.recording6 = recording6
        self.recording7 = recording7
        self.recording8 = recording8
    }
    
}
