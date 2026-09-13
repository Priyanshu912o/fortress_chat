import 'package:equatable/equatable.dart';
import '../../domain/entities/connection_entity.dart';

sealed class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object?> get props => [];
}

class LoadPeople extends PeopleEvent {
  const LoadPeople();
}

class RefreshPeople extends PeopleEvent {
  const RefreshPeople();
}

class SearchUserEvent extends PeopleEvent {
  final String email;
  const SearchUserEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class ClearSearchEvent extends PeopleEvent {
  const ClearSearchEvent();
}

class SendRequestEvent extends PeopleEvent {
  final String toUid;
  const SendRequestEvent(this.toUid);

  @override
  List<Object?> get props => [toUid];
}

class AcceptRequestEvent extends PeopleEvent {
  final String id;
  const AcceptRequestEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class RejectRequestEvent extends PeopleEvent {
  final String id;
  const RejectRequestEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AcceptedConnectionsUpdated extends PeopleEvent {
  final List<ConnectionEntity> list;
  const AcceptedConnectionsUpdated(this.list);

  @override
  List<Object?> get props => [list];
}

class PendingRequestsUpdated extends PeopleEvent {
  final List<ConnectionEntity> list;
  const PendingRequestsUpdated(this.list);

  @override
  List<Object?> get props => [list];
}

class SentRequestsUpdated extends PeopleEvent {
  final List<ConnectionEntity> list;
  const SentRequestsUpdated(this.list);

  @override
  List<Object?> get props => [list];
}
