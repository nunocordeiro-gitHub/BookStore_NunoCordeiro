//
//  Globals.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation


private let verboseLog = false

//NC - consider renaming to print and override original print
func DLog(_ items: Any) {
    #if DEBUG
    if verboseLog {
        print(items)
    }
    #endif
}

// Same as previous with variadic signature
func DLog(_ items: Any...) {
    #if DEBUG
    if verboseLog {
        print(items)
    }
    #endif
}
