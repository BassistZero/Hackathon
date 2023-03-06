import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private weak var favoritesTableView: UITableView!
    @IBOutlet private weak var favoritesButton: UIButton!

    // MARK: - Public Properties

    var barCode: String?

    // MARK: - Private Events

    var favoritesButtonTapped: (() -> Void)?

    // MARK: - Private Properties

    var isSaved: Bool {
        guard let barCodes = LocalStorage.favoriteBarCodes, let barCode else { return false }
        return barCodes.contains(barCode)
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - Configuration

private extension DetailViewController {

    func setupInitialState() {
        setupTableView()
        updateTitle()
    }

    func setupTableView() {
        favoritesTableView.dataSource = self

        favoritesTableView.register(UINib(nibName: "\(FavoriteTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(FavoriteTableViewCell.self)")
    }

}

// MARK: - Private Actions

private extension DetailViewController {

    @IBAction func favoritesTapped() {
        guard let barCode else { return }
        isSaved ? LocalStorage.removeBarCode(barCode) : LocalStorage.appendBarCode(barCode)
        updateTitle()
        favoritesButtonTapped?()
    }

}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteTableViewCell.self)", for: indexPath)

        guard let cell = cell as? FavoriteTableViewCell else { return .init() }

        cell.title = setTitle(for: indexPath)

        return cell
    }

}

// MARK: - Private Methods

private extension DetailViewController {

    func setTitle(for indexPath: IndexPath) -> String? {
        let row = indexPath.row

        switch row {
        case 0:
            return barCode
        default:
            return ""
        }
    }

    func updateTitle() {
        let title: String = isSaved ? .localized(key: .localized(key: "Detail.saveButton.saved")) : .localized(key: "Detail.saveButton.notSaved")
        favoritesButton.setTitle(title, for: .normal)
    }

}
