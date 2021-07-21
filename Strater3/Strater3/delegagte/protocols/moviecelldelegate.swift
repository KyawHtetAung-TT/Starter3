//
//  moviecelldelegate.swift
//  Strater3
//
//  Created by Ryan Willson on 7/20/21.
//

import Foundation

protocol movieCellDelegate {
    func userDidTap(id: Int, moiveType : MovieType)
}
