//
//  PostTableViewCell.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/5/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// Post Table View Vell. Handle post details as cell.
final class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            self.contentLabel.text = self.post?.content
            self.titleLabel.text = self.post?.title
        }
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializes UI elements
    private func setup() {
        addSubview(titleLabel)
        addSubview(contentLabel)
    }
    
    private var isViewConstrained = false
    
    lazy private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = #colorLiteral(red: 0.003920887597, green: 0.003921952564, blue: 0.003920524381, alpha: 1)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    lazy private var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.numberOfLines = 5
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentLabel.textColor = #colorLiteral(red: 0.4234947264, green: 0.423548907, blue: 0.423476398, alpha: 1)
        contentLabel.textAlignment = .justified
        return contentLabel
    }()
    
    // MARK: - Constraints setup.
    override public class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    private func setupConstraints() {
        if !isViewConstrained {
            let contraints = [
                // Username Label
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                titleLabel.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(2)),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(10)),
                // Latest Post Label
                contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                contentLabel.heightAnchor.constraint(equalToConstant: CGFloat(60)),
                contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-10)),
                contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
            ]
            NSLayoutConstraint.activate(contraints)
            isViewConstrained = true
        }
    }
    
}
