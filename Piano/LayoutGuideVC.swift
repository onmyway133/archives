//
//  LayoutGuideVC.swift
//  PIano
//
//  Created by Khoa Pham on 12/4/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

class LayoutGuideVC: UIViewController {
    var notes = [UIButton]()

    override func viewDidLoad(){
        super.viewDidLoad()

        setupWhiteNotes()
        setupBlackNotes()
    }

    func setupWhiteNotes() {

        var previousNote: UIView!

        for i in 0..<NoteType.count {
            let note = UIButton.makeWhiteNote()
            note.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(note)
            notes.append(note)

            note.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
            note.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true

            if i == NoteType.Do.rawValue {
                note.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
            } else {
                let leadingConstraint = note.leadingAnchor.constraintEqualToAnchor(previousNote.trailingAnchor)
                leadingConstraint.active = true
                leadingConstraint.constant = 1

                note.widthAnchor.constraintEqualToAnchor(previousNote.widthAnchor).active = true

                if i == NoteType.count-1 {
                    note.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
                }
            }

            previousNote = note
        }
    }

    func setupBlackNotes() {
        for (index, note) in notes.enumerate() {
            let type = NoteType(rawValue: index)!

            if type == NoteType.Mi || type == NoteType.Ti {
                continue
            }

            // Black Note
            let blackNote = UIButton.makeBlackNote()
            blackNote.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(blackNote)

            blackNote.topAnchor.constraintEqualToAnchor(note.topAnchor).active = true
            blackNote.centerXAnchor.constraintEqualToAnchor(note.trailingAnchor).active = true
            blackNote.heightAnchor.constraintEqualToAnchor(note.heightAnchor, multiplier: 2/3).active = true
            blackNote.widthAnchor.constraintEqualToAnchor(note.widthAnchor, multiplier: 2/3).active = true

        }
    }
}
