import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:event_management/model/user_model.dart';

part 'all_user_bloc_event.dart';
part 'all_user_bloc_state.dart';

class AllUserBlocBloc extends Bloc<AllUserBlocEvent, AllUserBlocState> {
  final List<UserModel> ijjo = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AllUserBlocBloc() : super(AllUserBlocInitialState()) {
    on<UserInitialEvent>((event, emit) async {
      emit(AllUserBlocLoadingState());
      await fetchUsers();
      emit(AllUserBlocLoadedState(ijjo));
    });
  }
  //List<Map<String, dynamic>> documentData = snapshot.data?.docs.map((e) => e.data() as Map<String, dynamic>?).toList();

  Future<void> fetchUsers() async {
    final users = await firebaseFirestore.collection('users').get();
    final hi = users.docs.map((e) => e.data() as Map<String, dynamic>).toList();
    hi.forEach((element) {
      ijjo.add(UserModel.formMap(element));
    });
  }
}
