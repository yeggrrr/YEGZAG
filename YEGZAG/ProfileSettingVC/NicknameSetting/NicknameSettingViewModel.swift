//
//  NicknameSettingViewModel.swift
//  YEGZAG
//
//  Created by YJ on 7/9/24.
//

import Foundation

enum NicknameErrorMessage: String {
    case empty = ""
    case wrongLength = "2글자 이상 10글자 미만으로 설정해주세요"
    case containsSpecialCharacter = "닉네임에 @, #, $, %는 포함할 수 없어요"
    case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
    case noError = "사용할 수 있는 닉네임이에요"
}

class NicknameSettingViewModel {
    var inputText: Observable<String?> = Observable("")
    var outputValidationText = Observable("")
    var nicknameErrorMessage: NicknameErrorMessage = .empty
    
    init() {
        inputText.bind { _ in
            self.validation()
        }
    }
    
    private func validation() {
        guard let inputText = inputText.value else { return }
        for char in inputText {
            if inputText.isEmpty {
                nicknameErrorMessage = .empty
            } else if inputText.count < 2 || inputText.count > 10 {
                nicknameErrorMessage = .wrongLength
            } else if inputText.contains("@") || inputText.contains("#") || inputText.contains("$") || inputText.contains("%") {
                nicknameErrorMessage = .containsSpecialCharacter
            } else if Int(String(char)) != nil {
                nicknameErrorMessage = .containsNumber
            } else {
                nicknameErrorMessage = .noError
            }
        }
        
        outputValidationText.value = nicknameErrorMessage.rawValue
    }
}
