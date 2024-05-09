//
//  IdItem.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/28/24.
//

import SwiftUI

struct IdItem: Identifiable, Codable, Transferable {
    var id: UUID
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: IdItem.self, contentType: .text)
    }
}
