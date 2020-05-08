//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Struct that holds our view
// Structs are value-based
struct ContentView: View {
    
    @State var artistName: String = ""
    @State var artistGenre: String = ""
    
    var body: some View {
        VStack() {
            Text("Search for artists in iTunes")
                .font(.subheadline)
            
            // Textfield is expecting a binding
            // A binding will help SwiftUI know that it needs to update on of our own custom variables
            // In order for us to have a custom variable like that, we need to use @State to wrap it.
            SearchView(artistNameBinding: $artistName,
                       artistGenreBinding: $artistGenre)
            
            Text(artistName) // Create our object
                .font(.largeTitle) // Modify the text
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
            
            HStack() {
                Text("Artist Genre:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(artistGenre)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
}

// Struct that holds our preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
