import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'all_user_bloc_event.dart';
part 'all_user_bloc_state.dart';

class AllUserBlocBloc extends Bloc<AllUserBlocEvent, AllUserBlocState> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? ijjo;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AllUserBlocBloc() : super(AllUserBlocInitialState()) {
    on<UserInitialEvent>((event, emit) async {
      emit(AllUserBlocLoadingState());
      await fetchUsers();
      emit(AllUserBlocLoadedState(professionsDocs: ijjo));
    });
  }
  //List<Map<String, dynamic>> documentData = snapshot.data?.docs.map((e) => e.data() as Map<String, dynamic>?).toList();

  Future<void> fetchUsers() async {
    final users = firebaseFirestore.collection('users').snapshots();
    final ijjo = users;
  }
}
