class DoctorList {
  List<Doctor> doctors;

  DoctorList(List<dynamic> doctors) {
    this.doctors = [];
    for (Map map in doctors) {
      this.doctors.add(new Doctor(map['name'] as String, map['specialties'],
          map['location'] as String));
    }
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
