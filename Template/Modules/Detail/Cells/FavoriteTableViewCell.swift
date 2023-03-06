import UIKit

final class FavoriteTableViewCell: UITableViewCell {

    // MARK: - Private Outlets

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Public Properties

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
}
