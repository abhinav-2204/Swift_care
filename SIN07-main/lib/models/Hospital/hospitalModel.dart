class Hospital {
  final int hospitalId;
  final String name;
  final Location location;
  final String type;
  final List<String> services;
  final Contact contact;
  final int beds;
  final List<String> facilities;
  final String accreditation;
  final List<String> symptoms; // Added attribute

  Hospital({
    required this.hospitalId,
    required this.name,
    required this.location,
    required this.type,
    required this.services,
    required this.contact,
    required this.beds,
    required this.facilities,
    required this.accreditation,
    required this.symptoms, // Updated constructor
  });
}

class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class Contact {
  final String phone;
  final String email;
  final String website;

  Contact({
    required this.phone,
    required this.email,
    required this.website,
  });
}
List<Hospital> sortHospitalsBySymptom(List<Hospital> hospitals, String symptom) {
  // Calculate a score for each hospital based on whether they cover the symptom
  hospitals.sort((a, b) {
    int scoreA = a.symptoms.contains(symptom) ? 1 : 0;
    int scoreB = b.symptoms.contains(symptom) ? 1 : 0;
    return scoreB.compareTo(scoreA); // Sort in descending order (hospitals with the symptom come first)
  });
  return hospitals;
}
