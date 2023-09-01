import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';
import 'package:dio/dio.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialAppState());
  final dio = Dio();
  CairoTemp cairo = CairoTemp("", 0);

  bool isLoading = false;
  
  getWeather() async {
     isLoading = true;
     emit(GetDataLoadingState());
    Response response = await dio.get('http://api.weatherapi.com/v1/current.json?key=e3a6705d6d6d42f2907225815233008&q=Egypt&aqi=no');
    String region = (response.data["location"]["region"]);
    double temp = (response.data["current"]["temp_c"]);
    cairo = CairoTemp(region, temp);
     isLoading = false;
    emit(GetDataSuccessState());
  }
}


class CairoTemp{
  String name;
  double temp;

    CairoTemp(this.name, this.temp);
}