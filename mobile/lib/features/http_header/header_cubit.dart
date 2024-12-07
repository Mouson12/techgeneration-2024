import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderCubit extends Cubit<Map<String, String>> {
  HeaderCubit() : super({});

  void addHeader(Map<String, String> headers) {
    emit(headers);
  }
}
