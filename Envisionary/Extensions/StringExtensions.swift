//
//  StringExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/8/23.
//

import SwiftUI

extension String {
    
    func ToImage(imageSize: CGFloat) -> some View {
        
        if(isSingleEmoji){
            let nsString = (self as NSString)
            let font = UIFont.systemFont(ofSize: imageSize) // you can change your font size here
            let stringAttributes = [NSAttributedString.Key.font: font]
            let sizeOfImage = nsString.size(withAttributes: stringAttributes)

            UIGraphicsBeginImageContextWithOptions(sizeOfImage, false, 0) //  begin image context
            UIColor.clear.set() // clear background
            UIRectFill(CGRect(origin: CGPoint(), size: sizeOfImage)) // set rect size
            nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
            let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
            UIGraphicsEndImageContext() //  end image context

            return Image(uiImage: image!)
                    .interpolation(.none)   
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize, alignment: .center)
        }
        else{
            return Image(self)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize, alignment: .center)
        }
    }
    
    func ToImageNative(imageSize: CGFloat) -> Image{
        if(isSingleEmoji){
            let nsString = (self as NSString)
            let font = UIFont.systemFont(ofSize: imageSize) // you can change your font size here
            let stringAttributes = [NSAttributedString.Key.font: font]
            let sizeOfImage = nsString.size(withAttributes: stringAttributes)

            UIGraphicsBeginImageContextWithOptions(sizeOfImage, false, 0) //  begin image context
            UIColor.clear.set() // clear background
            UIRectFill(CGRect(origin: CGPoint(), size: sizeOfImage)) // set rect size
            nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
            let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
            UIGraphicsEndImageContext() //  end image context

            return Image(uiImage: image!)
        }
        else{
            return Image(self)
        }
    }
    
    
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
    
    func toPropertyType() -> PropertyType{
        
        switch self{
        case PropertyType.timeframe.rawValue:
            return .timeframe
        case PropertyType.startDate.rawValue:
            return .startDate
        case PropertyType.endDate.rawValue:
            return .endDate
        case PropertyType.aspect.rawValue:
            return .aspect
        case PropertyType.priority.rawValue:
            return .priority
        case PropertyType.progress.rawValue:
            return .progress
        case PropertyType.edited.rawValue:
            return .edited
        case PropertyType.leftAsIs.rawValue:
            return .leftAsIs
        case PropertyType.pushedOff.rawValue:
            return .pushedOff
        case PropertyType.deleted.rawValue:
            return .deleted
        default:
            return .timeframe
        }
    }
    
    func toIdArray() -> [UUID]{
        let stringArray = self.components(separatedBy: ",").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
        
        return stringArray.map({UUID(uuidString: $0) ?? UUID()})
    }
    
    func toStringArray() -> [String]{
        return self.components(separatedBy: ",").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
    }
}

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
