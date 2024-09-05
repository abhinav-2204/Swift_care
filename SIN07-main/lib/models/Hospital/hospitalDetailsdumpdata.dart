import 'package:roaddoc/models/Hospital/hospitalModel.dart';

List<Hospital> hospitals = [
  Hospital(
    hospitalId: 1,
    name: 'City Hospital',
    location: Location(name: 'Downtown', latitude: 12.34, longitude: 56.78),
    type: 'General',
    services: ['Emergency', 'Cardiology'],
    contact: Contact(phone: '123-456-7890', email: 'contact@cityhospital.com', website: 'www.cityhospital.com'),
    beds: 200,
    facilities: ['X-Ray', 'MRI'],
    accreditation: 'AAA',
    symptoms: ['fever', 'cough', 'headache']
  ),
  Hospital(
    hospitalId: 2,
    name: 'HealthCare Center',
    location: Location(name: 'Northside', latitude: 23.45, longitude: 67.89),
    type: 'Specialty',
    services: ['Pediatrics', 'Orthopedics'],
    contact: Contact(phone: '987-654-3210', email: 'info@healthcarecenter.com', website: 'www.healthcarecenter.com'),
    beds: 150,
    facilities: ['Ultrasound', 'CT Scan'],
    accreditation: 'BBB',
    symptoms: ['stomach pain', 'nausea', 'vomiting']
  ),
  Hospital(
    hospitalId: 3,
    name: 'Green Valley Medical',
    location: Location(name: 'Green Valley', latitude: 34.56, longitude: 78.90),
    type: 'Specialty',
    services: ['Neurology', 'Oncology'],
    contact: Contact(phone: '345-678-9012', email: 'info@greenvalleymedical.com', website: 'www.greenvalleymedical.com'),
    beds: 100,
    facilities: ['MRI', 'PET Scan'],
    accreditation: 'AA',
    symptoms: ['headache', 'dizziness', 'nausea']
  ),
  Hospital(
    hospitalId: 4,
    name: 'Sunset Health',
    location: Location(name: 'Westside', latitude: 45.67, longitude: 89.01),
    type: 'General',
    services: ['General Medicine', 'Surgery'],
    contact: Contact(phone: '456-789-0123', email: 'contact@sunsethealth.com', website: 'www.sunsethealth.com'),
    beds: 250,
    facilities: ['X-Ray', 'Ultrasound'],
    accreditation: 'A',
    symptoms: ['back pain', 'fever', 'muscle pain']
  ),
  Hospital(
    hospitalId: 5,
    name: 'Metro Health Clinic',
    location: Location(name: 'Central City', latitude: 56.78, longitude: 90.12),
    type: 'Clinic',
    services: ['Family Medicine', 'Gynecology'],
    contact: Contact(phone: '567-890-1234', email: 'info@metrohealthclinic.com', website: 'www.metrohealthclinic.com'),
    beds: 50,
    facilities: ['X-Ray'],
    accreditation: 'BBB',
    symptoms: ['acidity', 'vomiting', 'stomach pain']
  ),
  Hospital(
    hospitalId: 6,
    name: 'Elite Care Hospital',
    location: Location(name: 'Uptown', latitude: 67.89, longitude: 12.34),
    type: 'Specialty',
    services: ['Cardiology', 'Endocrinology'],
    contact: Contact(phone: '678-901-2345', email: 'contact@elitecarehospital.com', website: 'www.elitecarehospital.com'),
    beds: 300,
    facilities: ['CT Scan', 'MRI'],
    accreditation: 'AAA',
    symptoms: ['chest pain', 'shortness of breath', 'fatigue']
  ),
  Hospital(
    hospitalId: 7,
    name: 'Happy Valley Hospital',
    location: Location(name: 'Happy Valley', latitude: 78.90, longitude: 23.45),
    type: 'General',
    services: ['Orthopedics', 'Emergency'],
    contact: Contact(phone: '789-012-3456', email: 'info@happyvalleyhospital.com', website: 'www.happyvalleyhospital.com'),
    beds: 180,
    facilities: ['X-Ray', 'Ultrasound'],
    accreditation: 'AA',
    symptoms: ['joint pain', 'muscle weakness', 'back pain']
  ),
  // Add more hospitals as needed
];
