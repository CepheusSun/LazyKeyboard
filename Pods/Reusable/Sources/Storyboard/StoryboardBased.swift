/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit

// MARK: Protocol Definition

/// Make your UIViewController subclasses conform to this protocol when:
///  * they *are* Storyboard-based, and
///  * this HomeController is the initialViewController of your Storyboard
///
/// to be able to instantiate them from the Storyboard in a type-safe manner
public protocol StoryboardBased: class {
  /// The UIStoryboard to use when we want to instantiate this ViewController
  static var sceneStoryboard: UIStoryboard { get }
}

// MARK: Default Implementation

public extension StoryboardBased {
  /// By default, use the storybaord with the same name as the class
  static var sceneStoryboard: UIStoryboard {
    return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
  }
}

// MARK: Support for instantiation from Storyboard

public extension StoryboardBased where Self: UIViewController {
  /**
   Create an instance of the HomeController from its associated Storyboard's initialViewController

   - returns: instance of the conforming HomeController
   */
  static func instantiate() -> Self {
    guard let vc = sceneStoryboard.instantiateInitialViewController() as? Self else {
      fatalError("The initialViewController of '\(sceneStoryboard)' is not of class '\(self)'")
    }
    return vc
  }
}
