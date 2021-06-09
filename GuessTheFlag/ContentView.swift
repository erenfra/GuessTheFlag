//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Renato Oliveira Fraga on 3/12/21.
//

import SwiftUI

struct FlagImage: ViewModifier{
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
    }
}

extension View{
    func something() -> some View{
        self.modifier(FlagImage())
    }
}

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    @State private var scoreValue: Int = 0
    @State private var animationAmount = 0.0
    @State private var correctFlag = false

    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                VStack {
                
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        withAnimation {
                            self.animationAmount = 360
                        }
                        
                    }) {
                        if self.correctFlag{
                            if number == self.correctAnswer{
                                withAnimation{
                                    Image(self.countries[number])
                                        .renderingMode(.original)
                                        .something()
                                        .rotation3DEffect(Angle(degrees: self.animationAmount), axis: (x: 0, y: 1, z: 0))
                                }
                            }
                            else {
                                Image(self.countries[number])
                                    .renderingMode(.original)
                                    .something()
                                    .opacity(0.75)
                            }
                        }
                        else {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .something()
                        }
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
            correctFlag = true
            
        } else {
            scoreTitle = "Worng! That's the flag of \(countries[number])"
            scoreValue -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        correctFlag = false
        animationAmount = 0
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
          
        }
    }
}
