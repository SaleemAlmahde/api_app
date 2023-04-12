class Employee {
  Employee(
    this.objectId,
    this.name,
    this.address,
    this.isActive,
  );

  String objectId;
  String name;
  String address;
  bool isActive;

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "Name": name,
        "Address": address,
        "IsActive": isActive,
      };

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        json["objectId"] as String,
        json["Name"] as String,
        json["Address"] as String,
        json["IsActive"] as bool,
      );
}
