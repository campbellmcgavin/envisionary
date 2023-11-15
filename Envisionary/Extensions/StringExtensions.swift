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
    
    static func toPosition(positionAbove: String?, positionBelow: String?) -> String{
        
        if let positionAbove{
            
            if positionAbove.count == 0 {
                return "a"
            }
              
            if positionAbove.count > 0 {
                if positionBelow == nil{
                    if let lastLetter = positionAbove.last{
                        return positionAbove.dropLast(1) + lastLetter.getNext()
                    }
                }
                else if !(positionBelow!.isEmpty) && positionAbove < positionBelow!{
                    if let positionBelow{
                        var sharedPosition = ""
                        
                        for i in 0...positionAbove.count-1 {
                            if positionBelow.count > i && positionAbove[i] <= positionBelow[i] {
                                sharedPosition.append(positionAbove[i])
                            }
                            else{
                                break
                            }
                        }
                        
                        if positionBelow.count < sharedPosition.count {
                            return positionAbove.dropLast(1) + positionAbove.last!.getNext()
                        }
                        else if positionBelow.count == sharedPosition.count{
                            if sharedPosition.count < positionAbove.count || sharedPosition == positionAbove {
                                return positionAbove.dropLast(1) + positionAbove.last!.getNext()
                            }
                            else{
                                return sharedPosition + "a"
                            }
                        }
                        else if positionBelow.count > sharedPosition.count{
                            
                            if positionAbove.dropLast(1) + (positionAbove.last ?? "a").getNext() < positionBelow {
                                return positionAbove.dropLast(1) + (positionAbove.last ?? "a").getNext()
                            }
                            else if positionAbove + "a" < positionBelow{
                                return positionAbove + "a"
                            }
                            else if positionAbove + "a" == positionBelow {
                                return positionAbove + "ab"
                            }
                            else{
                                return positionAbove + "a"
                            }
                        }
                    }
                }
            }
        }
        
        return "a"
    }

}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
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
    
    func getNext() -> String{
        switch self {
        case "a": return "b"
        case "b": return "c"
        case "c": return "d"
        case "d": return "e"
        case "e": return "f"
        case "f": return "g"
        case "g": return "h"
        case "h": return "i"
        case "i": return "j"
        case "j": return "k"
        case "k": return "l"
        case "l": return "m"
        case "m": return "n"
        case "n": return "o"
        case "o": return "p"
        case "p": return "q"
        case "q": return "r"
        case "r": return "s"
        case "s": return "t"
        case "t": return "u"
        case "u": return "v"
        case "v": return "w"
        case "w": return "x"
        case "x": return "y"
        case "y": return "z"
        case "z": return "za"
        default:  return "aa"
        }
    }
    
}
