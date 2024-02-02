//
//  MPVolumeViewExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import MediaPlayer

extension MPVolumeView {
  // Điều chỉnh âm lượng qua thanh trượt.
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
      slider?.value = volume
    }
  }
}
