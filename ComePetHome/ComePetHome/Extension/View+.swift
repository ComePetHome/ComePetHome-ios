//
//  View+.swift
//  ComePetHome
//
//  Created by 주진형 on 1/5/24.
//

import Foundation
import UIKit
import SwiftUI
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
