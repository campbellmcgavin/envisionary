

import SwiftUI

enum EmotionType: CaseIterable, Codable, Hashable{
    
    //Anger
    case anger
    case envy
    case jealousy
    case exasperation
    case frustration
    case annoyance
    case irritation
    case bitterness
    case hate
    case hostility
    case outrage
    case rage
    case resentment
    case torment
    
    //Disgust
    case disgust
    case dislike
    case revulsion
    case nauseated
    case aversion
    case offended
    case horrified
    
    //Fear
    case fear
    case alarm
    case fright
    case horror
    case hysteria
    case mortification
    case panic
    case shock
    case terror
    case anxiety
    case apprehension
    case distress
    case dread
    case nervousness
    case tenseness
    case uneasiness
    case worry
    
    //Joy
    case joy
    case amusement
    case bliss
    case cheerfulness
    case elation
    case happiness
    case satisfaction
    case contentment
    case pleasure
    case eagerness
    case hope
    case optimism
    case pride
    case triumph
    case relief
    case enthusiasm
    case excitement
    case zest
    
    //Love
    case love
    case adoration
    case affection
    case attraction
    case caring
    case compassion
    case fondness
    case liking
    case sentimentality
    case tenderness
    case longing
    case arousal
    case desire
    case infatuation
    case lust
    case passion
    
    //Sadness
    case sadness
    case disappointment
    case alienation
    case defeat
    case dejection
    case embarrassment
    case homesickness
    case humiliation
    case insecurity
    case insult
    case loneliness
    case rejection
    case depression
    case despair
    case grief
    case hopelessness
    case melancholy
    case misery
    case sorrow
    case unhappiness
    case guilt
    case regret
    case remorse
    case shame
    case agony
    case hurt
    case pity
    case sympathy
    
    //Surprise
    case surprise
    case amazement
    case astonishment
    
    func toString() -> String{
        switch self{
            
        //anger
        case .anger: return "Anger"
        case .envy: return "Envy"
        case .jealousy: return "Jealousy"
        case .exasperation: return "Exasperation"
        case .frustration: return "Frustration"
        case .annoyance: return "Annoyance"
        case .irritation: return "Irritation"
        case .bitterness: return "Bitterness"
        case .hate: return "Hate"
        case .hostility: return "Hostility"
        case .outrage: return "Outrage"
        case .rage: return "Rage"
        case .resentment: return "Resentment"
        case .torment: return "Torment"
            
            
        //Disgust
        case .disgust: return "Disgust"
        case .dislike: return "Dislike"
        case .revulsion: return "Revulsion"
        case .nauseated: return "Nauseated"
        case .aversion: return "Aversion"
        case .offended: return "Offended"
        case .horrified: return "Horrified"
        
        //fear
        case .fear: return "Fear"
        case .alarm: return "Alarm"
        case .fright: return "Fright"
        case .horror: return "Horror"
        case .hysteria: return "Hysteria"
        case .mortification: return "Mortification"
        case .panic: return "Panic"
        case .shock: return "Shock"
        case .terror: return "Terror"
        case .anxiety: return "Anxiety"
        case .apprehension: return "Apprehension"
        case .distress: return "Distress"
        case .dread: return "Dread"
        case .nervousness: return "Nervousness"
        case .tenseness: return "Tenseness"
        case .uneasiness: return "Uneasiness"
        case .worry: return "Worry"
        case .joy: return "Joy"
        case .amusement: return "Amusement"
        case .bliss: return "Bliss"
        case .cheerfulness: return "Cheerfulness"
            
        // happiness
        case .elation: return "Elation"
        case .happiness: return "Happiness"
        case .satisfaction: return "Satisfaction"
        case .contentment: return "Contentment"
        case .pleasure: return "Pleasure"
        case .eagerness: return "Eagerness"
        case .hope: return "Hope"
        case .optimism: return "Optimism"
        case .pride: return "Pride"
        case .triumph: return "Triumph"
        case .relief: return "Relief"
        case .enthusiasm: return "Enthusiasm"
        case .excitement: return "Excitement"
        case .zest: return "Zest"
        
        //love
        case .love: return "Love"
        case .adoration: return "Adoration"
        case .affection: return "Affection"
        case .attraction: return "Attraction"
        case .caring: return "Caring"
        case .compassion: return "Compassion"
        case .fondness: return "Fondness"
        case .liking: return "Liking"
        case .sentimentality: return "Sentimental"
        case .tenderness: return "Tenderness"
        case .longing: return "Longing"
        case .arousal: return "Arousal"
        case .desire: return "Desire"
        case .infatuation: return "Infatuation"
        case .lust: return "Lust"
        case .passion: return "Passion"
        
        //sadness
        case .sadness: return "Sadness"
        case .disappointment: return "Disappointment"
        case .alienation: return "Alienation"
        case .defeat: return "Defeat"
        case .dejection: return "Dejection"
        case .embarrassment: return "Embarrassment"
        case .homesickness: return "Homesickness"
        case .humiliation: return "Humiliation"
        case .insecurity: return "Insecurity"
        case .insult: return "Insult"
        case .loneliness: return "Loneliness"
        case .rejection: return "Rejection"
        case .depression: return "Depression"
        case .despair: return "Despair"
        case .grief: return "Grief"
        case .hopelessness: return "Hopelessness"
        case .melancholy: return "Melancholy"
        case .misery: return "Misery"
        case .sorrow: return "Sorrow"
        case .unhappiness: return "Unhappiness"
        case .guilt: return "Guilt"
        case .regret: return "Regret"
        case .remorse: return "Remorse"
        case .shame: return "Shame"
        case .agony: return "Agony"
        case .hurt: return "Hurt"
        case .pity: return "Pity"
        case .sympathy: return "Sympathy"
        
        //surprise
        case .surprise: return "Surprise"
        case .amazement: return "Amazement"
        case .astonishment: return "Astonishment"
        }
    }
    
    func toParentEmotion() -> Self{
        switch self{
            
        //Anger
        case .anger:
            return .anger
        case .envy:
            return .anger
        case .jealousy:
            return .anger
        case .exasperation:
            return .anger
        case .frustration:
            return .anger
        case .annoyance:
            return .anger
        case .irritation:
            return .anger
        case .bitterness:
            return .anger
        case .hate:
            return .anger
        case .hostility:
            return .anger
        case .outrage:
            return .anger
        case .rage:
            return .anger
        case .resentment:
            return .anger
        case .torment:
            return .anger
            
        //Disgust
        case .disgust:
            return .disgust
        case .dislike:
            return .disgust
        case .revulsion:
            return .disgust
        case .nauseated:
            return .disgust
        case .aversion:
            return .disgust
        case .offended:
            return .disgust
        case .horrified:
            return .disgust
            
            
        //Fear
        case .fear:
            return .fear
        case .alarm:
            return .fear
        case .fright:
            return .fear
        case .horror:
            return .fear
        case .hysteria:
            return .fear
        case .mortification:
            return .fear
        case .panic:
            return .fear
        case .shock:
            return .fear
        case .terror:
            return .fear
        case .anxiety:
            return .fear
        case .apprehension:
            return .fear
        case .distress:
            return .fear
        case .dread:
            return .fear
        case .nervousness:
            return .fear
        case .tenseness:
            return .fear
        case .uneasiness:
            return .fear
        case .worry:
            return .fear
            
        //Joy
        case .joy:
            return .joy
        case .amusement:
            return .joy
        case .bliss:
            return .joy
        case .cheerfulness:
            return .joy
        case .elation:
            return .joy
        case .happiness:
            return .joy
        case .satisfaction:
            return .joy
        case .contentment:
            return .joy
        case .pleasure:
            return .joy
        case .eagerness:
            return .joy
        case .hope:
            return .joy
        case .optimism:
            return .joy
        case .pride:
            return .joy
        case .triumph:
            return .joy
        case .relief:
            return .joy
        case .enthusiasm:
            return .joy
        case .excitement:
            return .joy
        case .zest:
            return .joy
            
        //Love
        case .love:
            return .love
        case .adoration:
            return .love
        case .affection:
            return .love
        case .attraction:
            return .love
        case .caring:
            return .love
        case .compassion:
            return .love
        case .fondness:
            return .love
        case .liking:
            return .love
        case .sentimentality:
            return .love
        case .tenderness:
            return .love
        case .longing:
            return .love
        case .arousal:
            return .love
        case .desire:
            return .love
        case .infatuation:
            return .love
        case .lust:
            return .love
        case .passion:
            return .love
            
        //Sadness
        case .sadness:
            return .sadness
        case .disappointment:
            return .sadness
        case .alienation:
            return .sadness
        case .defeat:
            return .sadness
        case .dejection:
            return .sadness
        case .embarrassment:
            return .sadness
        case .homesickness:
            return .sadness
        case .humiliation:
            return .sadness
        case .insecurity:
            return .sadness
        case .insult:
            return .sadness
        case .loneliness:
            return .sadness
        case .rejection:
            return .sadness
        case .depression:
            return .sadness
        case .despair:
            return .sadness
        case .grief:
            return .sadness
        case .hopelessness:
            return .sadness
        case .melancholy:
            return .sadness
        case .misery:
            return .sadness
        case .sorrow:
            return .sadness
        case .unhappiness:
            return .sadness
        case .guilt:
            return .sadness
        case .regret:
            return .sadness
        case .remorse:
            return .sadness
        case .shame:
            return .sadness
        case .agony:
            return .sadness
        case .hurt:
            return .sadness
        case .pity:
            return .sadness
        case .sympathy:
            return .sadness
            
        //Surprise
        case .surprise:
            return .surprise
        case .amazement:
            return .surprise
        case .astonishment:
            return .surprise
        }
    }
    
    func isParentEmotion() -> Bool{
        switch self{
        case .anger:
            return true
        case .fear:
            return true
        case .joy:
            return true
        case .love:
            return true
        case .sadness:
            return true
        case .surprise:
            return true
        case .disgust:
            return true
        default:
            return false
        }
    }
    
    static func fromString(from string: String) -> Self{
        return Self.allCases.first(where: {$0.toString() == string}) ?? .joy
    }
}
