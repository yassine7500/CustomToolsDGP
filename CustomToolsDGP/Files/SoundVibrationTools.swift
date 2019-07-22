//
//  SoundVibrationTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import AVFoundation

public class SoundVibrationTools {
    
    public init() {
        
    }
    
    public enum SoundExtensionType: String {
        case wav
        case mp3
        case mp4
    }
    
    public func generateVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    public func generateSoundAlert(soundName: String = "", extentionFile: SoundExtensionType = .wav, soundId: Int = 1000) {
        
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: extentionFile.rawValue) {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            AudioServicesPlaySystemSound(mySound);
        } else {
            AudioServicesPlayAlertSound(SystemSoundID(soundId))
        }
    }
    
}
