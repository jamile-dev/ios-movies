//
//  ErrorView.swift
//  Movies
//
//  Created by Jamile Bastos on 19/01/24.
//

import SwiftUI

struct ErrorView: View {
  let message: String
  
  var body: some View {
    VStack {
      Image(systemName: "exclamationmark.shield")
        .foregroundColor(.red)
        .font(.system(size: 60))
        .padding(5)
      Text(message)
        .font(.title2)
    }
  }
}

