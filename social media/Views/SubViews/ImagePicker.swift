//
//  ImagePicker.swift
//  social media
//
//  Created by Devang Papinwar on 29/10/21.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable
{
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageSelected : UIImage
    @Binding var sourceType : UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController
    {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = true
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>)
    {
        
    }
    
    func makeCoordinator() -> ImagePickerCoordinator
    {
        return ImagePickerCoordinator(parent: self)
    }
    
    class ImagePickerCoordinator : NSObject , UINavigationControllerDelegate , UIImagePickerControllerDelegate
    {
        let parent : ImagePicker
        
        init(parent : ImagePicker)
        {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
            {
                parent.imageSelected = image
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


