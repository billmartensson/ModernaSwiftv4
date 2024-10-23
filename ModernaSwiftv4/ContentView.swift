//
//  ContentView.swift
//  ModernaSwiftv4
//
//  Created by BillU on 2024-10-23.
//

import SwiftUI

struct ContentView: View {
    
    @State var joketext : String = "NO JOKE"
    
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text(joketext)
            
            Button("New joke") {
                Task {
                    await loadjoke()
                }
            }
            
        }
        .padding()
        .onAppear() {
            //loadjoke()
        }
        .task {
            await loadjoke()
        }
        
    }
        
    func loadjoke() async {
        //print("THIS IS A JOKE")
        
        let jokeapi = "https://api.chucknorris.io/jokes/random"
        
        let jokeurl = URL(string: jokeapi)
        
        do {
            let (jokedata, _) = try await URLSession.shared.data(from: jokeurl!)
            
            if let decodedJoke = try? JSONDecoder().decode(ChuckJoke.self, from: jokedata) {
                
                print(decodedJoke.value)
                joketext = decodedJoke.value
            }
            
            
        } catch {
            print("LOAD FAIL.")
        }
    }
    
}

#Preview {
    ContentView()
}

struct ChuckJoke : Codable {
    var icon_url : String
    var id : String
    var url : String
    var value : String
}

/*
 https://api.chucknorris.io/jokes/random

 {
 "icon_url" : "https://api.chucknorris.io/img/avatar/chuck-norris.png",
 "id" : "MHycK9R7R-uIPrhgyceVBw",
 "url" : "",
 "value" : "Jesus didn't rise and ascend to the heavens on the 3rd day. Chuck Norris round kick him back to life and simultaneously killed him again sending him to heaven."
 }

*/
