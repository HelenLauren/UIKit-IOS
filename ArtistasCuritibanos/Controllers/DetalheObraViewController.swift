import UIKit

final class DetalheObraViewController: UIViewController {

    // MARK: - Propriedades

    ///obra recebida da tela anterior
    var obra: ObraDeArte!

    // MARK: - IBOutlets

    @IBOutlet private weak var imagemView: UIImageView!
    @IBOutlet private weak var tituloLabel: UILabel!
    @IBOutlet private weak var artistaLabel: UILabel!
    @IBOutlet private weak var estiloContainer: UIView!
    @IBOutlet private weak var estiloLabel: UILabel!
    @IBOutlet private weak var anoLabel: UILabel!
    @IBOutlet private weak var descricaoLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configurarLayout()
        configurarConteudo()
    }

    // MARK: - Configuração da Interface

    /// estilos visuais da tela
    private func configurarLayout() {
        imagemView.layer.cornerRadius = 16
        imagemView.clipsToBounds = true
    }

    /// preenche os componentes com os dados da obra
    private func configurarConteudo() {
        configurarImagem()

        tituloLabel.text = obra.titulo
        artistaLabel.text = obra.artista
        anoLabel.text = "\(obra.ano)"
        estiloLabel.text = obra.estilo
        descricaoLabel.text = obra.descricao
    }

    /// define a imagem da obra ou uma imagem padrão caso não exista
    private func configurarImagem() {
        if let imagem = UIImage(named: obra.imagemNome) {
            imagemView.image = imagem
            imagemView.contentMode = .scaleAspectFill
        } else {
            imagemView.image = UIImage(systemName: "photo.artframe")
            imagemView.contentMode = .scaleAspectFit
            imagemView.tintColor = .systemGray3
        }
    }

    // MARK: - Actions

    /// retorna para a tela anterior
    @IBAction private func voltarTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    /// compartilhamento das informações da obra
    @IBAction private func compartilharTapped(_ sender: UIButton) {

        let textoCompartilhamento =
        """

        "\(obra.titulo)" — \(obra.artista). Conheça mais artistas curitibanos no app!

        """

        let activityViewController = UIActivityViewController(
            activityItems: [textoCompartilhamento],
            applicationActivities: nil
        )

        activityViewController.popoverPresentationController?.sourceView = sender

        present(activityViewController, animated: true)
    }
}