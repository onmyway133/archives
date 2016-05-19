//
//  ViewController.swift
//  StretchyHeader
//
//  Created by Khoa Pham on 11/1/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import UIKit
import SnapKit

let headerHeight = 220

class ViewController: UIViewController {
    var scrollView: UIScrollView!
    var scrollViewContentView: UIView!
    var header: UIImageView!
    var titleLabel: UILabel!
    var contentLabel: UILabel!

    // These are SnapKit Constraint
    var headerLessThanTopConstraint: Constraint?
    var headerTopConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupScrollViewContentView()
        setupHeader()
        setupTitleLabel()
        setupContentLabel()
    }
}

extension ViewController {
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self

        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    func setupScrollViewContentView() {
        scrollViewContentView = UIView()

        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.snp_makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view.snp_width)
        }
    }

    func setupHeader() {
        header = UIImageView()
        header.image = UIImage(named: "onepiece")!

        scrollViewContentView.addSubview(header)
        header.snp_makeConstraints { make in
            // Pin header to scrollView 's parent, which is now ViewController 's view
            // When header is moved up, headerTopConstraint is not enough, so make its priority 999, and add another less than or equal constraint
            make.leading.trailing.equalTo(scrollViewContentView)
            self.headerTopConstraint =  make.top.equalTo(view.snp_top).priority(999).constraint
            self.headerLessThanTopConstraint = make.top.lessThanOrEqualTo(view.snp_top).constraint
        }
    }

    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        titleLabel.text = "One Piece"

        scrollViewContentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { make in
            make.leading.equalTo(scrollViewContentView).offset(20)
            make.trailing.equalTo(scrollViewContentView).offset(-20)
            // Pin to the header to make it stretchy
            make.top.equalTo(header.snp_bottom).offset(20)
            // Pin to the content view to help determine scrollView contentSize
            make.top.equalTo(scrollViewContentView.snp_top).offset(headerHeight)
        }
    }

    func setupContentLabel() {
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.text = "One Piece (Japanese: ワンピース Hepburn: Wan Pīsu?) is a Japanese manga series written and illustrated by Eiichiro Oda. It has been serialized in Shueisha's Weekly Shōnen Jump magazine since July 19, 1997, with the chapters collected into seventy-eight tankōbon volumes to date. One Piece follows the adventures of Monkey D. Luffy, a funny young man whose body gained the properties of rubber after unintentionally eating a Devil Fruit. With his diverse crew of pirates, named the Straw Hat Pirates, Luffy explores the ocean in search of the world's ultimate treasure known as \"One Piece\" in order to become the next Pirate King."

        scrollViewContentView.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { make in
            make.leading.equalTo(scrollViewContentView).offset(20)
            make.trailing.equalTo(scrollViewContentView).offset(-20)
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
            make.bottom.equalTo(scrollViewContentView.snp_bottom).offset(-500)
        }
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let headerTopConstraint = headerTopConstraint,
            headerLessThanTopConstraint = headerLessThanTopConstraint
            else {
                return
        }

        let y = scrollView.contentOffset.y
        let offset = y > 0 ? -y : 0

        headerLessThanTopConstraint.updateOffset(offset)
        headerTopConstraint.updateOffset(offset)
    }
}

