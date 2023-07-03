import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';

part 'all_user_bloc_event.dart';
part 'all_user_bloc_state.dart';

class AllUserBlocBloc extends Bloc<AllUserBlocEvent, AllUserBlocState> {
  List<UserModel> allUserList = [];
  List<UserModel> allProfessions = [];
  // List<UserModel>
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AllUserBlocBloc() : super(AllUserBlocInitialState()) {
    on<UserInitialEvent>((event, emit) async {
      emit(AllUserBlocLoadingState());
      await fetchUsers();
      emit(AllUserBlocLoadedState(allUser: allUserList));
    });
    on<UserProfessionsEvent>((event, emit) async {
      emit(AllUserBlocLoadingState());
      await fetchUsers();
      allUserList = allUserList
          .where((element) => element.userType == UserType.profession)
          .toList();
      emit(AllProfessionsLoadedState(allProfessions: allUserList));
    });
    on<UserSearchEvent>((event, emit) async {
      emit(AllUserBlocLoadingState());
      await fetchUsers();
      // allProfessions.clear();
      allProfessions = allUserList
          .where((element) => element.userType == UserType.profession)
          .toList();
      allProfessions = allProfessions
          .where((element) => element.companyName!
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      emit(AllProfessionsSearchState(searchedProfessions: allProfessions));
    });
  }

  Future<void> fetchUsers() async {
    allUserList.clear();
    try {
      final usersSnapshot = await firebaseFirestore.collection('users').get();
      final usersDocuments = usersSnapshot.docs;

      for (var doc in usersDocuments) {
        // Extract the data from each document
        Map<String, dynamic> data = doc.data();

        // Create a UserModel object using the extracted data
        UserModel user = UserModel.formMap(data);

        // Add the UserModel object to the global list
        allUserList.add(user);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
