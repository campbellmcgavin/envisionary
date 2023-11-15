import SwiftUI

struct BrandButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.specify(style: .h6))
    }
}

struct BrandMenu: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .font(.specify(style: .h6))
    }
}
