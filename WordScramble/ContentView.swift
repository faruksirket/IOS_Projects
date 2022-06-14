//
//  ContentView.swift
//  WordScramble
//
//  Created by faruk sirket on 5.12.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .keyboardType(.default)
                
                }
                Section{
                    ForEach(usedWords, id: \.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
                Section("score"){
                    Text("\(score)")
                }
                
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                ToolbarItem(placement: .navigation){
                    Button("Restart Game"){
                        startGame()
                    }
                }
            }
        }
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            score = score - answer.count
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            score = score - answer.count
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            score = score - answer.count
            return
        }
        
        guard isThreeWords(word: answer) else {
            wordError(title: "Word cannot be less than 3 letters", message: "You have to enter longer words")
            score = score - answer.count
            return
        }
        
        guard isSame(word: answer) else {
            wordError(title: "Word cannot be the same as the rootword", message: "You have to enter a different word")
            score = score - answer.count
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
            score = score + answer.count
        }
        newWord = ""
    }
    func startGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsUrl){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                usedWords = [String]()
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledrange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledrange.location == NSNotFound
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    func isThreeWords(word: String) -> Bool {
        if newWord.count < 3 {
            return false
        }
        return true
    }
    func isSame (word: String) -> Bool {
        if rootWord == word {
            return false
        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
