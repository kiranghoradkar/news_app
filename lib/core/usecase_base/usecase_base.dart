abstract class UseCase<Type, Params> {
  Future<dynamic> call(Params params);
}

abstract class Params {}

class NoParams implements Params {}

class GetNewsParams extends Params {
  String? country;
  String? q;
  String category;

  GetNewsParams({this.country, this.q, required this.category});
}
