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
	var boardButtons = [UIButton]()
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
		switch screensize.width < screensize.height {
		case true:
			lineOffset = screensize.width / 28
			buttonSize = (screensize.width / 3) - (lineOffset - lineOffset / 3)
			screenOffsety = screensize.height / 2 - 3 * (buttonSize + lineOffset) / 2 + lineOffset / 2
		default:
			lineOffset = screensize.height / 28
			buttonSize = (screensize.height / 3) - (lineOffset - lineOffset / 3)
			screenOffsetx = screensize.width / 2 - 3 * (buttonSize + lineOffset) / 2 + lineOffset / 2
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
			//color every other button red and green
			if i % 2 == 0 {
				boardButtons[i].backgroundColor = .red
			}
			else {
				boardButtons[i].backgroundColor = .green
			}
			// add the funciton to the button
			boardButtons[i].addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
			// add the button to the view and print out the that it was added
			self.view.addSubview(boardButtons[i])
			print("Added Button at (\(screenPos.x), \(screenPos.y))")
		}
	}
	
	func loadLines() {
		
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
			button.setTitle(board.getType(x: pos.x, y: pos.y).text, for: .normal)
		}
	}
	
	func loadBoard(_ board: BigBoard) {
		
	}
	
	@objc func didTouchUp(_ sender: UIButton) {
		print("Tapped Button at \(getButtonBoardPos(sender))")
		sender.setTitle("Tapped", for: UIControlState.normal)
	}
}
