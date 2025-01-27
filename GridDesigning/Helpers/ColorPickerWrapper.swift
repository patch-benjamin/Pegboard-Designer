//
//  ColorPickerWrapper.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI
import UIKit

/// This View will present a `UIColorPickerViewController` modally when tapped on. 
struct ColorPickerButton<Label: View>: View {
    @State var window: UIWindow?
    var didSelectColor: (Color) -> Void
    @ViewBuilder var label: () -> Label

    var body: some View {
        Button {
            ColorPickerView.present(from: window, didSelectColor: didSelectColor)
        } label: {
            label()
                .background(WindowAccessor(window: $window))
        }
    }
}


private enum ColorPickerView {
    
    static func present(from window: UIWindow?, didSelectColor: @escaping (Color) -> Void) {
        // Cannot present this ViewController from a .sheet view modifier or it gets buggy.
        // Have to do this roundabout way of getting it to work via the Window.
        guard var top = window?.rootViewController else {
            return
        }
        while let next = top.presentedViewController {
            top = next
        }
        
        let modal = UIColorPickerViewController()
        modal.supportsAlpha = false
        Coordinator.current = .init() { newColor in
            didSelectColor(newColor)
            modal.dismiss(animated: true)
        }
        
        modal.delegate = Coordinator.current
        top.present(modal, animated: true)
    }

    private class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        static var current: Coordinator?
        
        var didSelectColor: ((Color) -> Void)?
        
        init(didSelectColor: @escaping (Color) -> Void) {
            self.didSelectColor = didSelectColor
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            let uiColor = viewController.selectedColor
            let swiftUIColor = Color(uiColor)
            didSelectColor?(swiftUIColor)
            didSelectColor = nil
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // Do nothing.
            //            let uiColor = viewController.selectedColor
            //            let swiftUIColor = Color(uiColor)
            //            didSelectColor(swiftUIColor)
        }
    }
}

private struct WindowAccessor: UIViewRepresentable {
    var window: Binding<UIWindow?>
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            self.window.wrappedValue = view.window // Get the window once the view is added to the hierarchy
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed
    }
}
