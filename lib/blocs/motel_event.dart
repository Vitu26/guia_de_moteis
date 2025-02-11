import 'package:guia_de_moteis/models/motel_model.dart';

abstract class MotelEvent {}

class LoadMotels extends MotelEvent {}

class ApplyFilter extends MotelEvent {

  final List<String> filter;

  ApplyFilter({required this.filter});

}

class ToggleFavorite extends MotelEvent {
  final Motel motel;

  ToggleFavorite(this.motel);

  @override
  List<Object> get props => [motel];
}

