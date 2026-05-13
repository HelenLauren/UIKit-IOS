import Foundation


struct ObraDeArte: Codable, Hashable {
    
    // MARK: - Propriedades

    let titulo: String
    let artista: String
    let ano: Int
    let estilo: String
    let imagemNome: String /// nome da imagem armazenada nos assets do projeto
    let descricao: String
    
}
