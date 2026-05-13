import UIKit

final class ObraCell: UICollectionViewCell {


    @IBOutlet private weak var imagemView: UIImageView!
    @IBOutlet private weak var overlay: UIView!
    @IBOutlet private weak var anoLabel: UILabel!
    @IBOutlet private weak var tituloLabel: UILabel!
    @IBOutlet private weak var artistaLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()

        configurarLayout()
    }

    // MARK: - Configuração da Interface

    private func configurarLayout() {

        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(named: "VerdeAraucaria")

        configurarSombra()
    }

    private func configurarSombra() {

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 14
        layer.shadowOpacity = 0.10
    }


    /// parameter obra: obra utilizada para configurar a interface
    func configurar(com obra: ObraDeArte) {

        anoLabel.text = "\(obra.ano)"
        tituloLabel.text = obra.titulo
        artistaLabel.text = obra.artista

        configurarImagem(nome: obra.imagemNome)
    }

    /// parameter nome: nome da imagem nos assets
    private func configurarImagem(nome: String) {

        if let imagem = UIImage(named: nome) {

            imagemView.image = imagem
            imagemView.contentMode = .scaleAspectFill

        } else {

            imagemView.image = UIImage(systemName: "photo.artframe")
            imagemView.contentMode = .center
            imagemView.tintColor = .white.withAlphaComponent(0.5)
        }
    }
}