import UIKit

final class SavedViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - Configuration

private extension SavedViewController {

    func setupInitialState() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(.init(nibName: "\(FavoriteTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(FavoriteTableViewCell.self)")
    }

}

// MARK: - UITableViewDataSource

extension SavedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = LocalStorage.favoriteBarCodes?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteTableViewCell.self)", for: indexPath)
        guard let cell = cell as? FavoriteTableViewCell, let favoriteBarCodes = LocalStorage.favoriteBarCodes else { return .init() }

        cell.title = favoriteBarCodes[indexPath.row]

        return cell
    }

}

// MARK: - UITableViewDelegate

extension SavedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoriteBarCodes = LocalStorage.favoriteBarCodes else { return }

        tableView.deselectRow(at: indexPath, animated: true)

        let controller = DetailViewController()
        controller.barCode = favoriteBarCodes[indexPath.row]
        controller.favoritesButtonTapped = { tableView.reloadData() }
        present(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let favoriteBarCodes = LocalStorage.favoriteBarCodes else { return }

        switch editingStyle {
        case .delete:
            LocalStorage.removeBarCode(favoriteBarCodes[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }

}
