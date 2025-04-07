//
//  BirdViewController + VoiceSearch.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import Speech
import AVFoundation

extension BirdViewController {
    
    // MARK: - Voice Search
    
    // Called when the mic button is tapped
    @objc func startVoiceSearch() {
        if audioEngine.isRunning {
            // If it's recording, stop recording.
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            do {
                try startRecording()
            } catch {
                print("Error starting voice recognition: \(error.localizedDescription)")
            }
        }
    }
    
    private func startRecording() throws {
        // Cancel any previous recognition task
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        // Configure audio session
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // Create a new recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create a recognition request")
        }
        recognitionRequest.shouldReportPartialResults = true
        
        let inputNode = audioEngine.inputNode
        
        // Start the recognition task
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            var isFinal = false
            
            if let result = result {
                // Updates the searchBar with the transcript and filters the data
                let spokenText = result.bestTranscription.formattedString
                self.searchController.searchBar.text = spokenText
                self.filterContentForSearchText(spokenText)
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        // Configure the audio engine input
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, when) in
            self?.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
}

