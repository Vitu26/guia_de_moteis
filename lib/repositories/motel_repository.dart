
import 'package:guia_de_moteis/models/motel_model.dart';
import 'package:guia_de_moteis/services/api_service.dart';


//atua como uma camada intermediária entre a API e a lógica de negócio da aplicação.
class MotelRepository {
  final ApiService apiService;

  MotelRepository(this.apiService);

  Future<List<Motel>> fetchMotels() async {
    return apiService.fetchMotels();
  }
}
