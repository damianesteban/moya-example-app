// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

struct StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> ColorsViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? ColorsViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case colorsViewControllerScene = "ColorsViewController"
    static func instantiateColorsViewController() -> ColorsViewController {
      guard let vc = StoryboardScene.Main.colorsViewControllerScene.viewController() as? ColorsViewController
      else {
        fatalError("ViewController 'ColorsViewController' is not of the expected class ColorsViewController.")
      }
      return vc
    }

    case userSignupViewControllerScene = "UserSignupViewController"
    static func instantiateUserSignupViewController() -> UserSignupViewController {
      guard let vc = StoryboardScene.Main.userSignupViewControllerScene.viewController() as? UserSignupViewController
      else {
        fatalError("ViewController 'UserSignupViewController' is not of the expected class UserSignupViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
