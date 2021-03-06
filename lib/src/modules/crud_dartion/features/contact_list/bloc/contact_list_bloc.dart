import 'package:superapp_my_bloc/src/core/infra/bloc.dart';
import 'package:superapp_my_bloc/src/modules/crud_dartion/models/contact_model.dart';
import 'package:superapp_my_bloc/src/modules/crud_dartion/repositories/contact/contact_repository.dart';

part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListState> {
  ContactListBloc({
    required ContactRepository contactRepository,
  })  : _contactRepository = contactRepository,
        super(ContactListInitial());

  final ContactRepository _contactRepository;

  Future<void> getContacts() async {
    emit(ContactListLoading());
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final contacts = await _contactRepository.getContacts();
      _orderByList(contacts);
      emit(ContactListSuccess(contacts: contacts));
    } on Exception {
      emit(ContactListError(message: 'Erro ao carregar a lista'));
    }
  }

  Future<void> removeContact(ContactModel contact) async {
    try {
      await _contactRepository.removeContact(contact);
      getContacts();
    } on Exception {
      emit(
        ContactListRemoveError(
          message: 'Erro ao deletar contato!',
          contacts: state.contacts,
        ),
      );
    }
  }

  void _orderByList(List<ContactModel> contacts) {
    return contacts.sort(
      (contactFirst, contactLast) => contactLast.timestamp.compareTo(
        contactFirst.timestamp,
      ),
    );
  }
}
