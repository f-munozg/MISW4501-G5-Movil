import 'package:intl/intl.dart';
import 'package:ccp_mobile/core/constants/app_formats.dart';

String parseStatus(String status) {
  switch (status.toLowerCase()) {
    case AppFormats.estadoReservado:
      return 'Reservado';
    case AppFormats.estadoCreado:
      return 'Creado';
    case AppFormats.estadoCompletado:
      return 'Completado';
    case AppFormats.estadoCancelado:
      return 'Cancelado';
    default:
      return status;
  }
}

String formatDateTime(DateTime dateTime) {
  final adjustedDateTime = dateTime.subtract(Duration(hours: 5));
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
  return formatter.format(adjustedDateTime);
}