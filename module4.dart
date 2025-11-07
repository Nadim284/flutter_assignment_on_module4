import 'dart:io';

String calculateGrade(double score) {
  if (score >= 90 && score <= 100) {
    return 'A+';
  } else if (score >= 85 && score < 90) {
    return 'A';
  } else if (score >= 80) {
    return 'A-';
  } else if (score >= 75) {
    return 'B+';
  } else if (score >= 70) {
    return 'B';
  } else if (score >= 65) {
    return 'B-';
  } else if (score >= 60) {
    return 'C+';
  } else if (score >= 55) {
    return 'C';
  } else if (score >= 50) {
    return 'C-';
  } else if (score >= 45) {
    return 'D';
  } else {
    return 'F';
  }
}

void addStudent(
  Set<String> ids, Map<String, Map<String, dynamic>> studentInfo) {
  print("Enter the Student id : ");
  String? id = stdin.readLineSync();

  if (id != null && id.trim().isNotEmpty) {
    if (ids.contains(id)) {
      print("ID already exists!");
    } else {
      ids.add(id);
      print("Enter the Student name : ");
      String? name = stdin.readLineSync();
      print("Enter the Student score (0-100): ");
      String? scoreInput = stdin.readLineSync();

      double? score = double.tryParse(scoreInput ?? '');

      if (name != null &&
          name.trim().isNotEmpty &&
          score != null &&
          score >= 0 &&
          score <= 100) {
        String grade = calculateGrade(score);
        studentInfo[id] = {'name': name, 'score': score, 'grade': grade};
        print("Student added successfully! Grade: $grade");
      } else {
        print("Invalid name or score!");
        ids.remove(id); 
      }
    }
  } else {
    print("Invalid ID!");
  }
}

void viewStudents(Map<String, Map<String, dynamic>> studentInfo) {
  if (studentInfo.isEmpty) {
    print("No students found!");
  } else {
   
    List<MapEntry<String, Map<String, dynamic>>> sortedStudents = 
    studentInfo.entries.toList();
    
    sortedStudents.sort((a, b) => 
        b.value['score'].compareTo(a.value['score']));
    
    print("\n--- Student Information (Sorted by Score - Descending) ---");
    print("Rank | ID      | Name                | Score  | Grade");
    print("-----+--------+---------------------+--------+-------");
    
    int rank = 1;
    for (var entry in sortedStudents) {
      String id = entry.key.padRight(7);
      String name = entry.value['name'].toString().padRight(20);
      String score = entry.value['score'].toString().padRight(7);
      String grade = entry.value['grade'].toString().padRight(6);
      
      print("${rank.toString().padLeft(4)} | $id| $name| $score| $grade");
      rank++;
    }
    print("-----------------------------------------------------------\n");
  }
}

void main() {
  Set<String> ids = {};
  Map<String, Map<String, dynamic>> studentInfo = {};

  while (true) {
    print("\n=== Student Management System ===");
    print("1. Add Student");
    print("2. View Students");
    print("3. Exit");
    print("Choose an option: ");
    String? optionInput = stdin.readLineSync();

    int? option = int.tryParse(optionInput ?? '');
    
    if (option == 1) {
      addStudent(ids, studentInfo);
    } else if (option == 2) {
      viewStudents(studentInfo);
    } else if (option == 3) {
      print("Exiting... Goodbye!");
      break;
    } else {
      print("Invalid option! Please choose 1, 2, or 3.");
    }
  }
}
