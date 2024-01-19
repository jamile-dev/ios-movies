//
//  LoadingView.swift
//  Movies
//
//  Created by Jamile Bastos on 19/01/24.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle(tint: .red))
      .scaleEffect(2.0, anchor: .center)
  }
}
