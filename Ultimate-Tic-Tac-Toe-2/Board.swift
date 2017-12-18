//
//  Board.swift
//  Ultimate-Tic-Tac-Toe-2
//
//  Created by  on 12/8/17.
//  Copyright © 2017 Hi-Crew. All rights reserved.
//

import Foundation

class Board: Cell {
	private var board: [Cell]
	
	internal var winningCombos: [[(x: Int, y: Int)]] = [ [ (0, 0), (1, 0), (2, 0) ],  // across the top
														[ (0, 1), (1, 1), (2, 1) ],  // across the middle
														[ (0, 2), (1, 2), (2, 2) ],  // across the bottom
														[ (0, 0), (0, 1), (0, 2) ],  // down the left
														[ (1, 0), (1, 1), (1, 2) ],  // down the middle
														[ (2, 0), (2, 1), (2, 2) ],  // down the right
														[ (0, 0), (1, 1), (2, 2) ],  // top left to bottom right
														[ (2, 0), (1, 1), (0, 2) ] ] // top right to bottom left
	
	override init() {
		board = [Cell]()
		super.init()
		for _ in 0..<9 {
			board.append(Cell())
		}
	}
	
	public func getType(x: Int, y: Int) -> (t: types, text: String) {
		return board[x + y * 3].getType()
	}
	
	public func turn(x: Int, y: Int, t: types) -> Bool {
		if (board[x + y * 3].type != .none) {
			return false
		}
		board[x + y * 3].type = t
		return true
	}
	
	override public func checkWinner() -> types {
		var count: Int = 0
		for combo in winningCombos {
			var row: [types] = []
			for point in combo {
				row.append(board[point.x % 3 + point.y / 3].checkWinner())
			}
			if (row[0] != .none && row[0] != .neither) && row[0] == row[1] && row[1] == row[2] {
				return row[0]
			}
			count += 1
			if count == 9 {
				return .neither
			}
		}
		return .none
	}
}
