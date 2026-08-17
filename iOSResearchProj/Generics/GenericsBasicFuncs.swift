//
//  Try.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-04.
//
import Foundation

func swatTwoValues <T> ( a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}


