# Flutter Weather App

Приложение для просмотра погоды. В качестве провайдера используется сервис [WeatherApi.com](https://www.weatherapi.com).

## Инструкции для запуска
1. Склонируйте репозиторий
2. Получите зависимости командой
    ```shell
    flutter pub get
    ```
3. Сгенерируйте файлы
    ```shell
    dart run build_runner build
    ```
4. (Опционально) Введите свой [Api-ключ](https://www.weatherapi.com/login.aspx)
    + Введите его на экране логина
    + Либо перейдите в файл ```lib/utils/constants.dart``` и вставьте его сюда ```static const mockApiKey = '<ВАШ-КЛЮЧ>';```
5. Запустите!
