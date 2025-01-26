//
//  ColorExtension.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

/// This code was created by ChatGPT.
extension Color {
    func toHex() -> String? {
        // Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Get RGBA components
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        // Convert components to hex string
        let hex = String(format: "#%02X%02X%02X",
                         Int(red * 255),
                         Int(green * 255),
                         Int(blue * 255))
        return hex
    }
    
    init(hex: String) {
        // Remove any leading '#' or '0x'
        let sanitizedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        // Default to black if the hex string is invalid
        var int: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&int)
        
        let red, green, blue, alpha: Double
        
        switch sanitizedHex.count {
        case 6: // RGB (e.g., #RRGGBB)
            red = Double((int >> 16) & 0xFF) / 255
            green = Double((int >> 8) & 0xFF) / 255
            blue = Double(int & 0xFF) / 255
            alpha = 1.0
        case 8: // ARGB (e.g., #AARRGGBB)
            alpha = Double((int >> 24) & 0xFF) / 255
            red = Double((int >> 16) & 0xFF) / 255
            green = Double((int >> 8) & 0xFF) / 255
            blue = Double(int & 0xFF) / 255
        default:
            // Invalid hex string, default to black
            red = 0
            green = 0
            blue = 0
            alpha = 1.0
        }
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

#Preview {
    @Previewable @State var color: Color = .black
    VStack {
        if let hext = color.toHex() {
            Text(hext)
            Color(hex: hext)
                .border(Color.white, width: 5)
        }
        color
        ColorPicker("Select Colro", selection: $color)
    }
}
