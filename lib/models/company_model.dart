class CompanyModel {
  String? logo;
  String name;

  CompanyModel({this.logo, required this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        name: json['name'],
        logo: json['logo_path'] == null
            ? 'https://www.pikpng.com/pngl/b/66-660381_business-icon-company-name-icon-clipart.png'
            : 'https://image.tmdb.org/t/p/w500${json['logo_path']}');
  }
}
