//
//  ContentView.swift
//  WordGarden-SwiftUI
//
//  Created by TheForce on 2/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
    
    private let wordsToGuess = ["MASERATI", "LAMBO", "CYBERTRUCK"]
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
                    Text("Words Guessed: \(wordsGuessed)")
                    Text("Words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text("Words To Guess: \(wordsToGuess.count - (wordsGuessed + wordsMissed))")
                    Text("Words In Game: \(wordsToGuess.count)")
                }
                
            }
            .padding(.horizontal)
            
            Spacer()
            Text(gameStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            //TODO: Switch to wordsToGuess[currentWord]
            Text(revealedWord)
                .font(.title)
            
            if playAgainHidden {
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) { _ in
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .onSubmit {
                            guard guessedLetter != "" else {
                                return
                            }
                            guessALetter()
                        }
                        .focused($textFieldIsFocused)
                    
                    Button("Guess A Letter") {
                        guessALetter()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                    
                }
            } else {
                Button("Another Word") {
                    //TODO: Another Word Button action Here
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
            
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear() {
            wordToGuess = wordsToGuess[currentWordIndex]
            // CREATE A STRING FROM A REPEATING VALUE
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        }
    }
    
    func guessALetter() {
        textFieldIsFocused = false
        lettersGuessed = lettersGuessed + guessedLetter
        
        revealedWord = ""
        //loop through all the letters in wordToGuess
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                // check if letter in wordToGuess is in lettersGuessed (i.e. did you guess this letter already?)
                revealedWord = revealedWord + "\(letter) "
            } else {
                // if not, add an underscore + a blank space, to revealedWorld
                revealedWord = revealedWord + "_ "
            }
        }
        revealedWord.removeLast()
        guessedLetter = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
