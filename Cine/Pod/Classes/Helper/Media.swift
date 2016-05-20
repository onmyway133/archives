//
//  Media.swift
//  Pods
//
//  Created by Khoa Pham on 10/5/15.
//
//

import Foundation
import AVFoundation

public enum MediaCharacteristic {
    case Audio, Subtitle

    internal func toAVMediaCharacteristic() -> String {
        switch self {
        case .Audio:
            return AVMediaCharacteristicAudible
        case .Subtitle:
            return AVMediaCharacteristicLegible
        }
    }
}

public struct MediaGroup {
    let group: AVMediaSelectionGroup
    let characteristic: MediaCharacteristic
    let options: [MediaOption]

    internal init(group: AVMediaSelectionGroup, characteristic: MediaCharacteristic, selectedOption: AVMediaSelectionOption) {
        self.group = group
        self.characteristic = characteristic
        self.options = group.options.map({ option in
            let selected = (option == selectedOption)
            let o = MediaOption(option: option, selected: selected)
            return o
        })
    }
}

public struct MediaOption {
    let option: AVMediaSelectionOption
    let name: String
    let playable: Bool
    let selected: Bool

    internal init(option: AVMediaSelectionOption, selected: Bool) {
        self.option = option
        self.selected = selected
        self.playable = option.playable

        if let item = option.commonMetadata.first {
            let title = "\(item.value)"
            self.name = title.characters.count > 0 ? title : option.displayName
        } else {
            self.name = option.displayName
        }
    }
}