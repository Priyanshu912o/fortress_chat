enum ConnectionStatus {
  pending,
  accepted,
  rejected,
  blocked;

  static ConnectionStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ACCEPTED':
        return ConnectionStatus.accepted;
      case 'REJECTED':
        return ConnectionStatus.rejected;
      case 'BLOCKED':
        return ConnectionStatus.blocked;
      case 'PENDING':
      default:
        return ConnectionStatus.pending;
    }
  }

  String toDbString() {
    switch (this) {
      case ConnectionStatus.accepted:
        return 'ACCEPTED';
      case ConnectionStatus.rejected:
        return 'REJECTED';
      case ConnectionStatus.blocked:
        return 'BLOCKED';
      case ConnectionStatus.pending:
        return 'PENDING';
    }
  }
}
