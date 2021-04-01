class DoctorsOffice {
  List<Doctor> doctors;
  List<dynamic> specialties;
  String location;

  DoctorsOffice(
      List<dynamic> doctors, List<dynamic> specialties, String location) {
    this.doctors = [];
    for (Map map in doctors) {
      this.doctors.add(new Doctor(map['name'] as String,
          map['specialties'] as List<String>, map['location'] as String));
    }
    this.specialties = specialties;
    this.location = location;
  }
}

class Doctor {
  String name;
  List<dynamic> specialties;
  String location;
  Doctor(String name, List<dynamic> specialties, String location) {
    this.name = name;
    this.specialties = specialties;
    this.location = location;
  }
}
