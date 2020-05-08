//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by Matthew Martindale on 5/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

final class SearchView: NSObject, UIViewRepresentable {
    
    // Binding - 2 way street between two variables
    // Binding itself is just a wrapper around 'artistName: String'
    @Binding // The property wrapper (two-way street wrapper)
    var artistName: String // The property it's wrapping is 'artistName: String'
    @Binding var artistGenre: String
    
    init(artistNameBinding: Binding<String>, artistGenreBinding: Binding<String>) {
        // In order to assign a binding to our variable
            _artistName = artistNameBinding
            _artistGenre = artistGenreBinding
    }
    
    // Tell the complier what view we'll be using while being UIViewRepresentable
    // Generics via AssociatedType
    typealias UIViewType = UISearchBar
    
    // Create our UIView
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .sentences
        searchBar.delegate = self
        return searchBar
    }
    
    // Update it every single time that SwiftUI updates it.
    func updateUIView(_ searchBar: UISearchBar, context: Context) {
        searchBar.delegate = self
    }
    
}

// In order to become a searchBarDelegate
// 1. Be a class
// 2. Be a final class
// 3. Inherit from NSObject
extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        iTunesAPI.searchArtists(for: searchBar.text!) { result in
            // When the iTunes server responds, we either get an array of artist or an error
            switch result {
            case .success(let artists):
                
                // If we got an array of artists, make sure is at least on artist
                guard let firstArtist = artists.first else { return }
                
                // Update our 'artistName' string, which triggers its own binding
                self.artistName = firstArtist.artistName
                self.artistGenre = firstArtist.primaryGenreName
                
            case .failure(let error):
                print(error)
            }
        }
        searchBar.endEditing(true)
    }
}
