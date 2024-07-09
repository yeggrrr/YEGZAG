//
//  ImageSettingViewModel.swift
//  YEGZAG
//
//  Created by YJ on 7/9/24.
//

import Foundation

class ImageSettingViewModel {
    var inputImageName = Observable("")
    
    init() {
        inputImageName.bind { _ in
            self.selectedImage()
        }
    }
    
    func selectedImage() {
        if !inputImageName.value.isEmpty {
            DataStorage.userTempProfileImageName = inputImageName.value
        }
    }
}
