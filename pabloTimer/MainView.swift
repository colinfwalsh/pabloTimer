//
//  MainView.swift
//  pabloTimer
//
//  Created by Colin Walsh on 10/16/17.
//  Copyright © 2017 Colin Walsh. All rights reserved.
//

import Cocoa
import AppKit

protocol SpaceKeyPressProtocol {
    func didPressSpaceKey(child: MainView)
    func didPressEnterKey(child: MainView)
}

class MainView: NSView {
    
    var delegate: SpaceKeyPressProtocol?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        interpretKeyEvents([event]) // calls insertText(_:), moveUp(_:), etc.
    }
    
    override func insertNewline(_ sender: Any?) {
        self.delegate?.didPressEnterKey(child: self)
    }
    
    override func insertText(_ insertString: Any) {
        let str = insertString as! String
        switch str {
        case " ":
            self.delegate?.didPressSpaceKey(child: self)
        default:
            print("Unrecognized input: \(str)")
        }
    }
}


