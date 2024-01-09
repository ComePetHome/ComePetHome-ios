//
//  CustomTextField.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    @State var isEditing: Bool
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = "Enter text"
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(_ customTextField: CustomTextField) {
            self.parent = customTextField
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isEditing = true
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isEditing = false
        }
    }
}
