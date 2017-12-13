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
	
	public func getType() -> types {
		return type
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
