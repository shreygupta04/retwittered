//
//  TextView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/24/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        uiView.becomeFirstResponder()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let originalText = textView.text as NSString
            let newText = originalText.replacingCharacters(in: range, with: text)
            return newText.count <= 280
        }
        
        
    }
}
