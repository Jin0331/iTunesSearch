//
//  Protocol.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/7/24.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input : Input) -> Output
}
