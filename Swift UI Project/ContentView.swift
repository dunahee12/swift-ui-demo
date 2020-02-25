//
//  ContentView.swift
//  Swift UI Project
//
//  Created by Jake Dunahee on 2/24/20.
//  Copyright © 2020 Jake Dunahee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  let rTarget = Double.random(in: 0..<1)
  let gTarget = Double.random(in: 0..<1)
  let bTarget = Double.random(in: 0..<1)
  @State var rGuess: Double
  @State var gGuess: Double
  @State var bGuess: Double
  @State var showAlert = false
  
  var body: some View {
    VStack {
      HStack {
        VStack {
          Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
          Text("Match this color")
        }
        
        VStack {
          Rectangle().foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
          HStack {
            Text("R: xxx")
            Text("G: xxx")
            Text("B: xxx")
          }
        }
      }
      
      Button(action: {
        self.showAlert = true
      }) {
        Text("Check score")
      }.padding()
      
      .alert(isPresented: $showAlert) { () -> Alert in
        Alert(title: Text("Your score"), message: Text("\(computeScore())"), dismissButton: nil)
      }
      
      ColorSlider(value: $rGuess, textColor: .red)
      ColorSlider(value: $gGuess, textColor: .green)
      ColorSlider(value: $bGuess, textColor: .blue)
    }
  }
  
  func computeScore() -> Int {
    let rDiff = rGuess - rTarget
    let gDiff = gGuess - gTarget
    let bDiff = bGuess - bTarget
    let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
    return Int((1.0 - diff) * 100.0 + 0.5)
  }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}


struct ColorSlider: View {
  @Binding var value: Double
  var textColor: Color
  
  var body: some View {
    HStack {
      Text("0").foregroundColor(textColor).padding()
      Slider(value: $value)
      Text("255").foregroundColor(textColor).padding()
    }
  }
}
