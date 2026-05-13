import UIKit

///Exibe a galeria de obras
final class GaleriaViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Propriedades

    /// lista completa de obras carregadas
    private var obras: [ObraDeArte] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configurarCollectionView()
        carregarObras()
    }

    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.collectionViewLayout.invalidateLayout()
    }

    // MARK: - Configuração

    ///configura delegates e aparência da collection view
    private func configurarCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }

    /// carrega as obras do repositório
    private func carregarObras() {
        obras = ObraRepository.shared.carregarObras()
        collectionView.reloadData()
    }

    // MARK: - Navegação

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "mostrarDetalhe",
              let destino = segue.destination as? DetalheObraViewController,
              let obraSelecionada = sender as? ObraDeArte else {
            return
        }

        destino.obra = obraSelecionada
    }
}

// MARK: - UICollectionViewDataSource

extension GaleriaViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        obras.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ObraCell",
            for: indexPath
        ) as? ObraCell else {
            fatalError("Não foi possível converter para ObraCell.")
        }

        let obra = obras[indexPath.item]

        cell.configurar(com: obra)

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GaleriaViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let obraSelecionada = obras[indexPath.item]

        performSegue(
            withIdentifier: "mostrarDetalhe",
            sender: obraSelecionada
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {

        cell.alpha = 0

        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GaleriaViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let quantidadeColunas: CGFloat =
        traitCollection.horizontalSizeClass == .regular ? 3 : 2

        let espacamentoTotal = 40 + (14 * (quantidadeColunas - 1))

        let larguraDisponivel =
        collectionView.bounds.width - espacamentoTotal

        let larguraCelula =
        floor(larguraDisponivel / quantidadeColunas)

        return CGSize(
            width: larguraCelula,
            height: larguraCelula * 1.25
        )
    }
}