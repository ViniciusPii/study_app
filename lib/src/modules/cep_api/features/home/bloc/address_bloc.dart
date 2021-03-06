import 'package:superapp_my_bloc/src/core/infra/bloc.dart';
import 'package:superapp_my_bloc/src/modules/cep_api/models/address_model.dart';
import 'package:superapp_my_bloc/src/modules/cep_api/repositories/address/address_repository.dart';

part 'address_state.dart';

class AddressBloc extends Bloc<AddressState> {
  AddressBloc({
    required AddressRepository addressRepository,
  })  : _addressRepository = addressRepository,
        super(AddressInitial());

  final AddressRepository _addressRepository;

  void getAddress(int cep) async {
    emit(AddressLoading());
    try {
      final address = await _addressRepository.getAddress(cep);

      if (address.cep.isEmpty) {
        return emit(AddressError(message: 'CEP não encontrado!'));
      }

      emit(AddressSuccess(address: address));
    } on Exception {
      emit(AddressError(message: 'Erro ao buscar CEP!'));
    }
  }
}
