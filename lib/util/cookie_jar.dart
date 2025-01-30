import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

Future<CookieJar> customCookieJar() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  return PersistCookieJar(storage: FileStorage("$appDocPath/.cookies/"));
}

Future<void> listCookies() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  Directory cookiesDir = Directory("$appDocPath/.cookies/");

  if (cookiesDir.existsSync()) {
    List<FileSystemEntity> files = cookiesDir.listSync();
    for (var entity in files) {
      if (entity is Directory) {
        // 서브디렉토리의 파일들을 탐색
        List<FileSystemEntity> subFiles = entity.listSync();
        for (var subEntity in subFiles) {
          if (subEntity is File) {
            // 파일 내용을 읽기
            String fileContent = await subEntity.readAsString();

            // JSON 형식으로 파싱
            var cookies = jsonDecode(fileContent);

            // 쿠키 내용을 출력
            print("Cookies in file ${subEntity.path}:");
            print(cookies);
          }
        }
      } else if (entity is File) {
        // 파일 내용을 읽기
        String fileContent = await entity.readAsString();

        // JSON 형식으로 파싱
        var cookies = jsonDecode(fileContent);

        // 쿠키 내용을 출력
        print("Cookies in file ${entity.path}:");
        print(cookies);
      } else {
        print("${entity.path}는 파일도 디렉토리도 아닙니다.");
      }
    }
  } else {
    print("쿠키 디렉토리가 존재하지 않습니다.");
  }
}