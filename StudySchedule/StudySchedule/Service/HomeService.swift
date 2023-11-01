import Foundation

struct Performance: Decodable {
    let date: String
    let performance: Double
}
struct Exercises: Decodable {
    let date: String
    let exerciseStudied: Int
}

struct Times: Decodable {
    let date: String
    let duration: Int
}

struct StudieData: Decodable {
    let date: String
    let studies: [Study]
}

struct Study: Decodable {
    let subject: String
    let timeSpend: Int
    let totalExercises: Int
}

class HomeService {
    struct RequestError: Error {
        let message: String
    }

    typealias PerformanceResult = Result<Performance, RequestError>
    typealias PerformanceCompletion = (PerformanceResult) -> Void

    typealias ExercisesResult = Result<Exercises, RequestError>
    typealias ExerciseCompletion = (ExercisesResult) -> Void

    typealias TimesResult = Result<Times, RequestError>
    typealias TimesCompletion = (TimesResult) -> Void

    typealias StudyResult = Result<StudieData, RequestError>
    typealias StudyCompletion = (StudyResult) -> Void

    func loadPerformance(completion: @escaping PerformanceCompletion) {
        let url = "http://localhost:3000/performance"

        // passando a urlRequest antes para que possa configurar-la
        var urlRequest = URLRequest(url: URL(string: url)!)

        // Mudando verbo da requisao para post para que eu possa enviar o body
        urlRequest.httpMethod = "POST"

        // configurando o body da api (corpo)
        urlRequest.httpBody = try? JSONSerialization.data(
            withJSONObject: ["date": "2023-10-29T22:51:18.720Z"],
            options: .prettyPrinted
        )

        // passando que a minha api e do tipo json
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // aqui estamos chamando a nossa api
        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in

            // verifica se possui dados caso nao tenha ele retorna
            // dizendo que anao possui dados
            guard let data else {
                return completion(.failure(
                    RequestError(message: "Erro nao possui dados"))
                )
            }

            // verifica se possui uma resposta caso nao tennha 
            // devolve que um erro dizendo que nao possui resposta
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(
                    RequestError(message: "Erro na resposta da solicitação"))
                )
            }

            // verifica se se status da api é sucesso caso nao seja retorna
            // dizendo que nao foi um sucesso
            guard response.statusCode == 200 else {
                completion(.failure(RequestError(message: "Código de status inválido: \(response.statusCode)")))
                return
            }

            let decoder = JSONDecoder()

            // verifica se consegue deodificar a respostas do objeto do backend
            // caso nao decodifique ele retorna dizendo que nao foi possivel decoficicar
            guard let decodifier = try? decoder.decode(Performance.self, from: data) else {
                return completion(.failure(RequestError(message: "Erro na codifição do codigo ")))
            }

            // caso a decodificacao de certo ele devolve sucesso
            completion(.success(decodifier))
        }
        // realiza a chamada da api
        .resume()
    }

    func loadExercises(completion: @escaping ExerciseCompletion) {

        // url local do backend
        let url = "http://localhost:3000/exercises"

        // adicionando a urlRequest para poder configurar
        var urlRequest = URLRequest(url: URL(string: url)!)

        // passando como verbo post
        urlRequest.httpMethod = "POST"

        // passando o body da api (corpo)
        urlRequest.httpBody = try? JSONSerialization.data(
            withJSONObject: ["date": "2023-10-30T00:10:18.755Z" ],
            options: .prettyPrinted
        )

        // dizendo que o objeto e do tipo json
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // configura a chamada da api
        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in

            // verifica se a data caso nao tenha devolve um erro dizendo que nao tem
            guard let data else { return completion(.failure(RequestError(message: "Erro nao possui dados")))}

            // verifica se a reposta caso nao tenha devolve um erro dizendo que nao tem
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(RequestError(message: "Erro na resposta da solicitação")))
            }

            // verifica se o status da resposta e sucesso caso nao
            // seja devolve dizendo que nao tem
            guard response.statusCode == 200 else {
                return completion(.failure(RequestError(message: "Código de status inválido: \(response.statusCode)")))
            }

            let decoder = JSONDecoder()

            // converte o nome da chave do objeto da api que contem anderline(SnakeCase)
            // para letras maiusculas (camelCase)
            // ex. exercise_studied -> exerciseStudied
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            // decodifica o objeto da api do backend caso nao consiga devolve um
            // erro dizendo que nao foi possivel decodificar
            guard let decode = try? decoder.decode(Exercises.self, from: data) else {
                return completion(.failure(RequestError(message: "Erro na decodificação")))
            }

            // passando por todas as verificacoes ele resulta em um sucesso
            completion(.success(decode))

        }
        // realiza a chamada da api
        .resume()
    }

    func loadTime(completion: @escaping TimesCompletion) {
        let url = "http://localhost:3000/timeSpend"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(
            withJSONObject: ["date": "2023-10-30T19:43:04.915Z"],
            options: .prettyPrinted
        )
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in

            guard let data else { return completion(.failure(RequestError(message: "Erro nao possui dados")))}

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(RequestError(message: "")))
            }

            guard response.statusCode == 200 else {
                return completion(.failure(RequestError(message: "Código de status inválido: \(response.statusCode)")))
            }

            let decoder = JSONDecoder()

            guard let decodifier = try? decoder.decode(Times.self, from: data) else {
                return completion(.failure(RequestError(message: "Erro na decodificação do objeto")))
            }

            completion(.success(decodifier))
        }

        .resume()
    }

    func loadStudies(completion: @escaping StudyCompletion) {

        let url = "http://localhost:3000/studies"

        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(
            withJSONObject: ["date": "2023-10-31T19:27:17.561Z"],
            options: .prettyPrinted
        )
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in

            guard let data else { return completion(.failure(RequestError(message: "Erro nao possui dados")))}

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(RequestError(message: "Erro na resposta da solicitação")))
            }

            guard response.statusCode == 200 else {
                return completion(.failure(RequestError(message: "Código de status inválido: \(response.statusCode)")))
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let decodifier = try? decoder.decode(StudieData.self, from: data) else {
                return completion(.failure(RequestError(message: "Erro na decodificação do objeto")))
            }

            completion(.success(decodifier))
        }

        .resume()
    }
}
