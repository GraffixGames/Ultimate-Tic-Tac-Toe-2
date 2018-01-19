//
//  ViewController.swift
//  Ultimate-Tic-Tac-Toe-2
//
//  Created by  on 12/8/17.
//  Copyright © 2017 Hi-Crew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var board = Board()
	var player = Cell.types.x
	var boardButtons = [UIButton]()
	var boardLines = [CAShapeLayer]()
	var screensize = CGRect()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		screensize = view.bounds
		reloadButtons()
		loadBoard(board)
	}
	
	func reloadButtons() {
		deleteButons()
		loadButtons()
		print("Reloaded Buttons")
	}
	
	func deleteButons() {
		for button in boardButtons.indices {
			boardButtons[button].removeFromSuperview()
		}
		boardButtons.removeAll()
		print("Deleted Buttons")
	}
	
	func loadButtons() {
		// set the size the buttons should be on the screen
		var buttonSize = CGFloat()
		var lineOffset = CGFloat()
		var screenOffsety = CGFloat()
		var screenOffsetx = CGFloat()
		deleteLines()
		switch screensize.width < screensize.height {
		case true:
			lineOffset = screensize.width / 28
			buttonSize = (screensize.width / 3) - (lineOffset - lineOffset / 3)
			screenOffsety = screensize.height / 2 - 3 * (buttonSize + lineOffset) / 2 + lineOffset / 2
			loadLines(buttonSize, lineOffset, screensize.width, screenOffsetx, screenOffsety)
		default:
			lineOffset = screensize.height / 28
			buttonSize = (screensize.height / 3) - (lineOffset - lineOffset / 3)
			screenOffsetx = screensize.width / 2 - 3 * (buttonSize + lineOffset) / 2 + lineOffset / 2
			loadLines(buttonSize, lineOffset, screensize.height, screenOffsetx, screenOffsety)
		}
		

		
		// load 9 buttons
		for i in 0..<9 {
			// add a button to the boadButtons array
			boardButtons.append(UIButton(type: UIButtonType.custom))
			// get the position in the board that the button is, and get the corrisponding screen position
			let boardPos = CGPoint(x: i % 3, y: i / 3)
			let screenPos = CGPoint(x: boardPos.x * (buttonSize + lineOffset) + screenOffsetx, y: boardPos.y * (buttonSize + lineOffset) + screenOffsety)
			// set the size and position of the button
			boardButtons[i].bounds = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
			boardButtons[i].frame.origin = screenPos
			// set button color
			if i % 2 == 0 {
				boardButtons[i].backgroundColor = .red
			} else {
				boardButtons[i].backgroundColor = .green
			}
			boardButtons[i].setTitleColor(.black, for: .normal)
			// add the funciton to the button
			boardButtons[i].addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
			// add the button to the view and print out the that it was added
			self.view.addSubview(boardButtons[i])
			print("Added Button at (\(screenPos.x), \(screenPos.y))")
		}
	}
	
	func loadSubButtons() {
		
	}
	
	func loadLines(_ buttonSize: CGFloat, _ lineOffset: CGFloat, _ boardSize: CGFloat, _ xOffset: CGFloat, _ yOffset: CGFloat) {
		// x axis
		for i in 0..<2 {
			let layer = CAShapeLayer()
			let lineRect = CGRect(x: xOffset, y: yOffset + CGFloat(i) * (buttonSize + lineOffset) + buttonSize, width: boardSize, height: lineOffset)
			let line = UIBezierPath(rect: lineRect)
			layer.path = line.cgPath
			layer.strokeColor = UIColor.black.cgColor
			layer.fillColor = UIColor.black.cgColor
			self.view.layer.addSublayer(layer)
			boardLines.append(layer)
		}
		// y axis
		for i in 0..<2 {
			let layer = CAShapeLayer()
			let lineRect = CGRect(x: xOffset + CGFloat(i) * (buttonSize + lineOffset) + buttonSize, y: yOffset, width: lineOffset, height: boardSize)
			let line = UIBezierPath(rect: lineRect)
			layer.path = line.cgPath
			layer.strokeColor = UIColor.black.cgColor
			layer.fillColor = UIColor.black.cgColor
			self.view.layer.addSublayer(layer)
			boardLines.append(layer)
		}
	}
	
	func deleteLines() {
		for line in boardLines {
			line.removeFromSuperlayer()
		}
		boardLines.removeAll()
		print("cleared all lines")
	}
	
	func getButtonBoardPos(_ sender: UIButton) -> (x: Int, y: Int) {
		var pos: (x: Int, y: Int) = (x: 0, y: 0)
		var counter = 0
		for button in boardButtons {
			if sender == button {
				pos.x = counter % 3
				pos.y = counter / 3
				break
			}
			counter += 1
		}
		return pos
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		screensize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		reloadButtons()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadBoard(_ board: Board) {
		for button in boardButtons {
			let pos = getButtonBoardPos(button)
			if board.getType(x: pos.x, y: pos.y).t != .none && board.getType(x: pos.x, y: pos.y).t != .neither {
				print("button \(getButtonBoardPos(button)) was x or o")
				button.isEnabled = false
				button.setTitle(board.getType(x: pos.x, y: pos.y).text, for: .normal)
			} else {
				print("button \(getButtonBoardPos(button)) was blank")
				button.isEnabled = true
				button.setTitle("", for: .normal)
			}
		}
	}
	
	func loadBoard(_ board: BigBoard) {
		
	}
	
	@objc func didTouchUp(_ sender: UIButton) {
		print("Tapped Button at \(getButtonBoardPos(sender))")
		let pos = getButtonBoardPos(sender)
		print(board.turn(x: pos.x, y: pos.y, t: player))
		switch player {
		case Cell.types.x:
			player = Cell.types.o
		default:
			player = Cell.types.x
		}
		loadBoard(board)
	}
}
