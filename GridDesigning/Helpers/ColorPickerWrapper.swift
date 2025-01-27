//
//  ColorPickerWrapper.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI
import UIKit

struct ColorPickerWrapper: View {
    @Environment(\.dismiss) var dismiss
    var didSelectColor: (Color) -> Void
    @State var stopDuplicates = false

    var body: some View {
        ColorPickerView { newColor in
            guard !stopDuplicates else { return }
            stopDuplicates = true
            didSelectColor(newColor)
            dismiss()
        }
        .background(Color.white)
    }
}
private struct ColorPickerView: UIViewControllerRepresentable {
    var didSelectColor: (Color) -> Void
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = context.coordinator
        return colorPicker
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        // No need to update the view controller in this case
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(didSelectColor: didSelectColor)
    }
    
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var didSelectColor: (Color) -> Void
        
        init(didSelectColor: @escaping (Color) -> Void) {
            self.didSelectColor = didSelectColor
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            let uiColor = viewController.selectedColor
            let swiftUIColor = Color(uiColor)
            didSelectColor(swiftUIColor)
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // Do nothing.
//            let uiColor = viewController.selectedColor
//            let swiftUIColor = Color(uiColor)
//            didSelectColor(swiftUIColor)
        }
    }
}
