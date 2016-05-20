//
//  Player+Media.swift
//  Pods
//
//  Created by Khoa Pham on 10/5/15.
//
//

import Foundation
import AVFoundation

public extension Player {
    func mediaGroupWithCharacteristic(characteristic: MediaCharacteristic) -> MediaGroup? {
        if isReadyToPlay,
            let group = player?.currentItem?.asset.mediaSelectionGroupForMediaCharacteristic(characteristic.toAVMediaCharacteristic()),
            let selectedOption = player?.currentItem?.selectedMediaOptionInMediaSelectionGroup(group) {

                return MediaGroup(group: group,
                    characteristic: characteristic,
                    selectedOption: selectedOption)
        }

        return nil
    }

    func selectMediaOption(option: MediaOption, inside group: MediaGroup) {
        player?.currentItem?.selectMediaOption(option.option, inMediaSelectionGroup: group.group)
    }
}

extension Player {

}