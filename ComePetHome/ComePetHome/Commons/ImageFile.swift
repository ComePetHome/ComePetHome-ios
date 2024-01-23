//
//  ImageFile.swift
//  ComePetHome
//
//  Created by 주진형 on 1/19/24.
//

import SwiftUI
import UIKit
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        let configuration = PHPickerConfiguration()
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let itemProvider = results.first?.itemProvider,
                itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard
                    let image = image as? UIImage,
                    error == nil else { return }
                self?.parent.selectedImage = image
            }
        }
    }
}
