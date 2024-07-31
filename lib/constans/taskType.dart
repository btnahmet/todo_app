enum TaskType { note, calender, contest }

// extension TaskTypeExtension on TaskType {
//   String get name {
//     switch (this) {
//       case TaskType.note:
//         return "Note";
//       case TaskType.calender:
//         return "Calender";
//       case TaskType.contest:
//         return "Contest";
//       default:
//         return "";
//     }
//   }

//   static TaskType fromString(String value) {
//     switch (value) {
//       case 'Note':
//         return TaskType.note;
//       case 'Calender':
//         return TaskType.calender;
//       case 'Contest':
//         return TaskType.contest;
//       default:
//         throw ArgumentError('Invalid TaskType string: $value');
//     }
//   }
// }
