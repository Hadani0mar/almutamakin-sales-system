import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:archive/archive.dart';

class UpdateService {
  static const String githubOwner = 'Hadani0mar';
  static const String githubRepo = 'almutamakin-sales-system';
  static const String githubApiUrl = 'https://api.github.com/repos/$githubOwner/$githubRepo/releases/latest';

  /// التحقق من وجود تحديث جديد
  static Future<Map<String, dynamic>?> checkForUpdates() async {
    try {
      final response = await http.get(Uri.parse(githubApiUrl));
      
      if (response.statusCode == 200) {
        final releaseData = json.decode(response.body);
        final latestVersion = releaseData['tag_name']?.toString().replaceAll('v', '') ?? '';
        final releaseNotes = releaseData['body']?.toString() ?? '';
        final assets = releaseData['assets'] as List<dynamic>? ?? [];
        
        // الحصول على النسخة الحالية
        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;
        
        // مقارنة الإصدارات
        if (_compareVersions(latestVersion, currentVersion) > 0) {
          // البحث عن ملف ZIP للتحميل
          String? downloadUrl;
          for (var asset in assets) {
            final name = asset['name']?.toString() ?? '';
            if (name.endsWith('.zip') || name.endsWith('.exe')) {
              downloadUrl = asset['browser_download_url']?.toString();
              break;
            }
          }
          
          if (downloadUrl != null) {
            return {
              'hasUpdate': true,
              'latestVersion': latestVersion,
              'currentVersion': currentVersion,
              'downloadUrl': downloadUrl,
              'releaseNotes': releaseNotes,
              'releaseUrl': releaseData['html_url']?.toString(),
            };
          }
        }
      }
      
      return {'hasUpdate': false};
    } catch (e) {
      print('خطأ في التحقق من التحديثات: $e');
      return null;
    }
  }

  /// مقارنة إصدارين
  static int _compareVersions(String version1, String version2) {
    final v1Parts = version1.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final v2Parts = version2.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    
    // جعل القوائم بنفس الطول
    while (v1Parts.length < v2Parts.length) v1Parts.add(0);
    while (v2Parts.length < v1Parts.length) v2Parts.add(0);
    
    for (int i = 0; i < v1Parts.length; i++) {
      if (v1Parts[i] > v2Parts[i]) return 1;
      if (v1Parts[i] < v2Parts[i]) return -1;
    }
    
    return 0;
  }

  /// تنزيل التحديث
  static Future<bool> downloadUpdate(String downloadUrl, Function(int, int)? onProgress) async {
    try {
      final response = await http.get(Uri.parse(downloadUrl));
      
      if (response.statusCode == 200) {
        // الحصول على مسار التطبيق الحالي
        final appPath = Platform.resolvedExecutable;
        final appDir = path.dirname(appPath);
        final updateDir = path.join(appDir, 'updates');
        
        // إنشاء مجلد التحديثات
        final updateDirFile = Directory(updateDir);
        if (!await updateDirFile.exists()) {
          await updateDirFile.create(recursive: true);
        }
        
        // حفظ الملف المؤقت
        final fileName = path.basename(downloadUrl);
        final tempFile = File(path.join(updateDir, fileName));
        await tempFile.writeAsBytes(response.bodyBytes);
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('خطأ في تنزيل التحديث: $e');
      return false;
    }
  }

  /// تثبيت التحديث
  static Future<bool> installUpdate(String updateFilePath) async {
    try {
      final appPath = Platform.resolvedExecutable;
      final appDir = path.dirname(appPath);
      final appName = path.basenameWithoutExtension(appPath);
      
      // إذا كان الملف ZIP، استخراجه
      if (updateFilePath.endsWith('.zip')) {
        final bytes = await File(updateFilePath).readAsBytes();
        final archive = ZipDecoder().decodeBytes(bytes);
        
        // استخراج الملفات
        for (var file in archive) {
          final filename = file.name;
          if (file.isFile) {
            final data = file.content as List<int>;
            final outputFile = File(path.join(appDir, filename));
            await outputFile.create(recursive: true);
            await outputFile.writeAsBytes(data);
          }
        }
      } else if (updateFilePath.endsWith('.exe')) {
        // إذا كان ملف EXE، تشغيله للتثبيت
        await Process.run(updateFilePath, [], runInShell: true);
      }
      
      return true;
    } catch (e) {
      print('خطأ في تثبيت التحديث: $e');
      return false;
    }
  }

  /// إعادة تشغيل التطبيق
  static Future<void> restartApp() async {
    try {
      final appPath = Platform.resolvedExecutable;
      // إنشاء سكريبت لإعادة التشغيل
      final restartScript = '''
@echo off
timeout /t 2 /nobreak >nul
start "" "$appPath"
''';
      
      final scriptPath = path.join(path.dirname(appPath), 'restart.bat');
      await File(scriptPath).writeAsString(restartScript);
      
      // تشغيل السكريبت
      await Process.start('cmd', ['/c', scriptPath], mode: ProcessStartMode.detached);
      
      // إغلاق التطبيق الحالي
      exit(0);
    } catch (e) {
      print('خطأ في إعادة تشغيل التطبيق: $e');
    }
  }
}

