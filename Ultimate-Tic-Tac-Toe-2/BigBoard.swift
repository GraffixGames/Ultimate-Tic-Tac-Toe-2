//
//  BigBoard.swift
//  Ultimate-Tic-Tac-Toe-2
//
//  Created by  on 12/8/17.
//  Copyright © 2017 Hi-Crew. All rights reserved.
//

import Foundation

class BigBoard: Board {
	private var board: [Board]
	
	override init() {
		board = [Board]()
		for _ in 0..<9 {
			board.append(Board())
		}
	}
	
	override func getType() -> (t: Cell.types, text: String) {
		return (t: types.none, text: "")
	}
}
