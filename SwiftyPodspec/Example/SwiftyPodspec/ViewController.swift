//
//  ViewController.swift
//  SwiftyPodspec
//
//  Created by Khoa Pham on 01/16/2016.
//  Copyright (c) 2016 Khoa Pham. All rights reserved.
//

import UIKit
import SwiftyPodspec

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let spec = Spec().configure {
            $0.name = "SwiftyPodspec"
            $0.version = Version(major: 0, minor: 1, patch: 0)
            $0.summary = "If podspec is written in Swift"
            $0.homepage = NSURL(string: "https://github.com/onmyway133/SwiftyPodspec")
            $0.license = .MIT
            $0.author = [Author(name: "Khoa Pham", email: "onmyway133@gmail.com")]
            $0.source = .Git(Source.SourceGit(url: NSURL(string: "https://github.com/onmyway133/SwiftyPodspec.git")!, tag: $0.version))
            $0.socialMediaURL = NSURL(string: "https://twitter.com/onmyway133")
            $0.platform = [Platform(type: .iOS, version: Version(major: 8, minor: 0))]
            $0.sourceFiles = ["Pod/Classes/**/*"]
            $0.frameworks = ["Foundation"]
            $0.dependencies = [Dependency(name: "Configurable", version: Version(major: 0, minor: 1, patch: 0))]
        }

        rocket(spec)
    }

    func rocket(spec: Spec) {
        print(spec)
    }

}

