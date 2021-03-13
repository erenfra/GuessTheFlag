//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Renato Oliveira Fraga on 3/12/21.
//

import SwiftUI

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    @State private var scoreValue: Int = 0
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                VStack {
                
                    Text("Tap the frag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                            
                    }
                    
                }
                
                Text("Score: \(scoreValue) ")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.black)
                Spacer()
            }
            
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(scoreValue)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
            
        } else {
            scoreTitle = "Worng! That's the flag of \(countries[number])"
            scoreValue -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
