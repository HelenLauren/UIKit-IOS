import Foundation

/// Utiliza cache em memória para evitar múltiplas leituras desnecessárias do arquivo JSON
final class ObraRepository {

    static let shared = ObraRepository()

    /// Cache das obras já carregadas
    private var cache: [ObraDeArte]?

    private init() {}

    func carregarObras() -> [ObraDeArte] {

        // Retorna o cache caso os dados já tenham sido carregados
        if let cache {
            return cache
        }

        guard let url = Bundle.main.url(
            forResource: "obras",
            withExtension: "json"
        ) else {
            print("Erro: arquivo obras.json não encontrado.")
            return []
        }

        guard let data = try? Data(contentsOf: url) else {
            print("Erro: não foi possível ler o arquivo JSON.")
            return []
        }

        // Converte o JSON em objetos Swift
        guard let obras = try? JSONDecoder().decode(
            [ObraDeArte].self,
            from: data
        ) else {
            print("Erro: falha ao decodificar o JSON.")
            return []
        }

        // Salva os dados no cache
        cache = obras

        return obras
    }
}