//
//  CustomDialog.swift
//  Movies
//
//  Created by Jamile Bastos on 19/01/24.
//

import SwiftUI

struct CustomDialog: View {
  @Binding var isActive: Bool
  
  let title: String
  let message: String
  let buttonTitle: String
  let action: () -> ()
  @State private var offset: CGFloat = 1000
  
  var body: some View {
    ZStack {
      Color(.black)
        .opacity(0.5)
        .onTapGesture {
          close()
        }
      
      VStack {
        Text(title)
          .font(.title2)
          .bold()
          .padding()
        
        Text(message)
          .font(.body)
        
        Button {
          action()
          close()
        } label: {
          ZStack {
            RoundedRectangle(cornerRadius: 20)
              .foregroundColor(.red)
            
            Text(buttonTitle)
              .font(.system(size: 16, weight: .bold))
              .foregroundColor(.white)
              .padding()
          }
          .padding()
        }
      }
      .fixedSize(horizontal: false, vertical: true)
      .padding()
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(alignment: .topTrailing) {
        Button {
          close()
        } label: {
          Image(systemName: "xmark")
            .font(.title2)
            .fontWeight(.medium)
        }
        .tint(.black)
        .padding()
      }
      .shadow(radius: 20)
      .padding(30)
      .offset(x: 0, y: offset)
      .onAppear {
        withAnimation(.spring()) {
          offset = 0
        }
      }
    }
    .ignoresSafeArea()
  }
  
  func close() {
    withAnimation(.spring()) {
      offset = 1000
      isActive = false
    }
  }
}

#Preview {
  CustomDialog(isActive: .constant(true), title: "Custom Dialog", message: "This is a message for custom dialog", buttonTitle: "Cancel", action: {})
}
