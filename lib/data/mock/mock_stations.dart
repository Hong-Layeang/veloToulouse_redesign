
import '../../models/station.dart';
import '../../models/bike.dart';

final List<Station> mockStations = [
  Station(
    id: '1',
    name: 'Jean Jaurès',

    totalDocks: 20,
    bikes: const [
      Bike(id: 'b1', name: 'Bike 50123', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 80),
      Bike(id: 'b2', name: 'Bike 40979', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 75),
      Bike(id: 'b3', name: 'Bike 20375', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 40),
      Bike(id: 'b4', name: 'Bike 20502', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 15),
      Bike(id: 'b5', name: 'Bike 21141', type: BikeType.mechanical, condition: BikeCondition.good),
    ],
  ),
  Station(
    id: '2',
    name: 'Capitole',

    totalDocks: 30,
    bikes: const [
      Bike(id: 'b6', name: 'Bike 12028', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 75),
      Bike(id: 'b7', name: 'Bike 38239', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 40),
      Bike(id: 'b8', name: 'Bike 23304', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 15),
      Bike(id: 'b9', name: 'Bike 30112', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 90),
      Bike(id: 'b10', name: 'Bike 14556', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b11', name: 'Bike 18723', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 60),
      Bike(id: 'b12', name: 'Bike 27891', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 55),
      Bike(id: 'b13', name: 'Bike 33210', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b14', name: 'Bike 41002', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 85),
      Bike(id: 'b15', name: 'Bike 19384', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 10),
      Bike(id: 'b16', name: 'Bike 25567', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b17', name: 'Bike 48201', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 70),
    ],
  ),
  Station(
    id: '3',
    name: 'Saint-Cyprien',

    totalDocks: 15,
    bikes: const [
      Bike(id: 'b18', name: 'Bike 11234', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 95),
      Bike(id: 'b19', name: 'Bike 22345', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 50),
      Bike(id: 'b20', name: 'Bike 33456', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b21', name: 'Bike 44567', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 20),
      Bike(id: 'b22', name: 'Bike 55678', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 65),
    ],
  ),
  Station(
    id: '4',
    name: 'Compans-Caffarelli',

    totalDocks: 25,
    bikes: const [
      Bike(id: 'b23', name: 'Bike 61234', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 88),
      Bike(id: 'b24', name: 'Bike 62345', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 72),
      Bike(id: 'b25', name: 'Bike 63456', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b26', name: 'Bike 64567', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 5),
      Bike(id: 'b27', name: 'Bike 65678', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 45),
      Bike(id: 'b28', name: 'Bike 66789', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b29', name: 'Bike 67890', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 30),
      Bike(id: 'b30', name: 'Bike 68901', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 92),
      Bike(id: 'b31', name: 'Bike 69012', type: BikeType.mechanical, condition: BikeCondition.maintenance),
    ],
  ),
  Station(
    id: '5',
    name: 'Carmes',

    totalDocks: 18,
    bikes: const [
      Bike(id: 'b32', name: 'Bike 71111', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 60),
      Bike(id: 'b33', name: 'Bike 72222', type: BikeType.mechanical, condition: BikeCondition.good),
    ],
  ),
  Station(
    id: '6',
    name: 'François Verdier',

    totalDocks: 22,
    bikes: const [
      Bike(id: 'b34', name: 'Bike 81234', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 100),
      Bike(id: 'b35', name: 'Bike 82345', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 55),
      Bike(id: 'b36', name: 'Bike 83456', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 78),
      Bike(id: 'b37', name: 'Bike 84567', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b38', name: 'Bike 85678', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 12),
      Bike(id: 'b39', name: 'Bike 86789', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 67),
      Bike(id: 'b40', name: 'Bike 87890', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b41', name: 'Bike 88901', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 43),
      Bike(id: 'b42', name: 'Bike 89012', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 81),
      Bike(id: 'b43', name: 'Bike 90123', type: BikeType.mechanical, condition: BikeCondition.maintenance),
    ],
  ),
  Station(
    id: '7',
    name: 'Esquirol',

    totalDocks: 20,
    bikes: const [],
  ),
  Station(
    id: '8',
    name: 'Jeanne d\'Arc',

    totalDocks: 16,
    bikes: const [
      Bike(id: 'b44', name: 'Bike 91234', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 35),
      Bike(id: 'b45', name: 'Bike 92345', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 68),
      Bike(id: 'b46', name: 'Bike 93456', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b47', name: 'Bike 94567', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 8),
      Bike(id: 'b48', name: 'Bike 95678', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 52),
      Bike(id: 'b49', name: 'Bike 96789', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 91),
      Bike(id: 'b50', name: 'Bike 97890', type: BikeType.mechanical, condition: BikeCondition.good),
    ],
  ),
  Station(
    id: '9',
    name: 'Matabiau',

    totalDocks: 28,
    bikes: const [
      Bike(id: 'b51', name: 'Bike 10001', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 99),
      Bike(id: 'b52', name: 'Bike 10002', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 74),
      Bike(id: 'b53', name: 'Bike 10003', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 48),
      Bike(id: 'b54', name: 'Bike 10004', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b55', name: 'Bike 10005', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 63),
      Bike(id: 'b56', name: 'Bike 10006', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 18),
      Bike(id: 'b57', name: 'Bike 10007', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b58', name: 'Bike 10008', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 56),
      Bike(id: 'b59', name: 'Bike 10009', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 82),
      Bike(id: 'b60', name: 'Bike 10010', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b61', name: 'Bike 10011', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 39),
      Bike(id: 'b62', name: 'Bike 10012', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 71),
      Bike(id: 'b63', name: 'Bike 10013', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 7),
      Bike(id: 'b64', name: 'Bike 10014', type: BikeType.mechanical, condition: BikeCondition.maintenance),
      Bike(id: 'b65', name: 'Bike 10015', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 88),
      Bike(id: 'b66', name: 'Bike 10016', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 64),
      Bike(id: 'b67', name: 'Bike 10017', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b68', name: 'Bike 10018', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 51),
      Bike(id: 'b69', name: 'Bike 10019', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 77),
      Bike(id: 'b70', name: 'Bike 10020', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 93),
    ],
  ),
  Station(
    id: '10',
    name: 'Palais de Justice',

    totalDocks: 12,
    bikes: const [
      Bike(id: 'b71', name: 'Bike 20001', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 44),
      Bike(id: 'b72', name: 'Bike 20002', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b73', name: 'Bike 20003', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 29),
      Bike(id: 'b74', name: 'Bike 20004', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 83),
      Bike(id: 'b75', name: 'Bike 20005', type: BikeType.electric, condition: BikeCondition.charging, batteryPercent: 11),
      Bike(id: 'b76', name: 'Bike 20006', type: BikeType.mechanical, condition: BikeCondition.good),
      Bike(id: 'b77', name: 'Bike 20007', type: BikeType.electric, condition: BikeCondition.good, batteryPercent: 58),
    ],
  ),
];
