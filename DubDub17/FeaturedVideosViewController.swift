//
//  FeaturedVideosViewController.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

protocol FeaturedVideosViewControllerDelegate {
    func featuredControllerDidSelectVideo(_ controller: FeaturedVideosViewController, video: Video)
}

class FeaturedVideosViewController: UITableViewController, SectionDelegate {

    var viewModel: FeaturedViewModel!
    var delegate: FeaturedVideosViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = FeaturedViewModel()
        self.navigationItem.title = "Featured"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    private func identifier(section: Int) -> String {
        return (section == 0) ? "FavoritesCell" : "VideosCell"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier(section: indexPath.section), for: indexPath) as?ScrollingRowCell else { fatalError() }
        viewModel.configureCell(cell, at: indexPath, delegate: self)
        return cell
    }

    func didSelect(video: Video) {
        delegate?.featuredControllerDidSelectVideo(self, video: video)
    }

}

extension FeaturedVideosViewController {

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section: section)
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        view.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightHeavy)
        view.contentView.backgroundColor = .white
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 220
        } else {
            return 160.0
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }

}
