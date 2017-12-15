//
//  Cell.swift
//  Ultimate-Tic-Tac-Toe-2
//
//  Created by  on 12/8/17.
//  Copyright © 2017 Hi-Crew. All rights reserved.
//

import Foundation

class Cell {
	internal enum types {
		case x
		case o
		case none
		case neither
	}
	
	internal var type: types
	
	internal func getType() -> (t: types, text:String) {
		var text: String
		switch type {
		case .x:
			text = "X"
		case .o:
			text = "O"
		case .neither:
			text = "neither"
		default:
			text = "none"
		}
		return (t: type, text: text)
	}
	
	init() {
		type = .none
	}
	
	init(t: types) {
		type = t
	}
	
	internal func checkWinner() -> types {
		return type
	}
}
