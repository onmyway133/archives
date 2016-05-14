//
//  StackViewVC.swift
//  PIano
//
//  Created by Khoa Pham on 12/4/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

class StackViewVC: UIViewController {
    var notes: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWhiteNotes()
        setupBlackNotes()
    }

    func setupWhiteNotes() {
        notes = Array(0..<NoteType.count).map { (index) -> UIButton in
            let note = UIButton.makeWhiteNote()
            note.translatesAutoresizingMaskIntoConstraints = false

            return note
        }

        // StackView
        let stackView = UIStackView(arrangedSubviews: notes)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .Horizontal
        stackView.spacing = 1.0
        stackView.distribution = .FillEqually

        view.addSubview(stackView)

        stackView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        stackView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        stackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
    }

    func setupBlackNotes() {
        // Sample white note
        let note = notes.first!

        // LayoutGuide
        let leadingLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(leadingLayoutGuide)
        leadingLayoutGuide.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        leadingLayoutGuide.widthAnchor.constraintEqualToAnchor(note.widthAnchor, multiplier: 2/3).active = true

        let trailingLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(trailingLayoutGuide)
        trailingLayoutGuide.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        trailingLayoutGuide.widthAnchor.constraintEqualToAnchor(note.widthAnchor, multiplier: 2/3).active = true

        // StackView
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .Horizontal
        stackView.distribution = .EqualSpacing

        view.addSubview(stackView)

        stackView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        stackView.leadingAnchor.constraintEqualToAnchor(leadingLayoutGuide.trailingAnchor).active = true
        stackView.trailingAnchor.constraintEqualToAnchor(trailingLayoutGuide.leadingAnchor).active = true
        stackView.heightAnchor.constraintEqualToAnchor(note.heightAnchor, multiplier: 2/3).active = true

        // Black note
        for i in 0..<NoteType.count-1 {
            let blackNote = UIButton.makeBlackNote()
            stackView.addArrangedSubview(blackNote)

            // Hide Mi-Fa black note
            if i == NoteType.Mi.rawValue {
                blackNote.alpha = 0
            }

            blackNote.widthAnchor.constraintEqualToAnchor(note.widthAnchor, multiplier: 2/3).active = true
        }
    }
}
