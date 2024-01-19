//
//  ResultType.swift
//  Movies
//
//  Created by Jamile Bastos on 19/01/24.
//

import Foundation

enum ResultType<T> {
  case success(T)
  case loading
  case failure(Error)
}
