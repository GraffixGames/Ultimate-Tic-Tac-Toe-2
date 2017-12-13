//
//  ViewController.swift
//  Ultimate-Tic-Tac-Toe-2
//
//  Created by  on 12/8/17.
//  Copyright © 2017 Hi-Crew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var board = BigBoard()
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
	}
	
	func deleteButons() {
		for button in boardButtons.indices {
			boardButtons[button].removeFromSuperview()
		}
		boardButtons.removeAll()
	}
	
	func loadButtons() {
		var buttonSize = CGFloat()
		switch screensize.width < screensize.height {
		case true:
			buttonSize = (screensize.width / 3) - (screensize.width / 16)
		default:
			buttonSize = (screensize.height / 3) - (screensize.height / 16)
		}
		
		for i in 0..<9 {
			boardButtons.append(UIButton(type: UIButtonType.custom))
			let x = (CGFloat(0 + (i % 3)) * buttonSize)
			let y = (CGFloat(0 + (i / 3)) * buttonSize)
			boardButtons[i].bounds = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
			boardButtons[i].frame.origin = CGPoint(x: x, y: y)
			if i % 2 == 0 {
				boardButtons[i].backgroundColor = .red
			}
			else {
				boardButtons[i].backgroundColor = .green
			}
			boardButtons[i].setTitle("Button\(i)", for: UIControlState.normal)
			boardButtons[i].addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
			self.view.addSubview(boardButtons[i])
			print("Added Button at (\(x), \(y))")
		}
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
		screensize = view.bounds
		reloadButtons()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadBoard(_ board: Board) {
		
	}
	
	func loadBoard(_ board: BigBoard) {
		
	}
	
	@objc func didTouchUp(_ sender: UIButton) {
		print("Tapped Button at \(getButtonBoardPos(sender))")
	}
}
