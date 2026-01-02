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
    while (v1Parts.length < v2Parts.length) {
      v1Parts.add(0);
    }
    while (v2Parts.length < v1Parts.length) {
      v2Parts.add(0);
    }
    
    for (int i = 0; i < v1Parts.length; i++) {
      if (v1Parts[i] > v2Parts[i]) return 1;
      if (v1Parts[i] < v2Parts[i]) return -1;
    }
    
    return 0;
  }

  /// تنزيل التحديث مع تتبع التقدم
  static Future<bool> downloadUpdate(String downloadUrl, Function(int, int)? onProgress) async {
    try {
      final request = http.Request('GET', Uri.parse(downloadUrl));
      final streamedResponse = await http.Client().send(request);
      
      if (streamedResponse.statusCode == 200) {
        // الحصول على مسار التطبيق الحالي
        final appPath = Platform.resolvedExecutable;
        final appDir = path.dirname(appPath);
        final updateDir = path.join(appDir, 'updates');
        
        // إنشاء مجلد التحديثات
        final updateDirFile = Directory(updateDir);
        if (!await updateDirFile.exists()) {
          await updateDirFile.create(recursive: true);
        }
        
        // حفظ الملف المؤقت مع تتبع التقدم
        final fileName = path.basename(downloadUrl);
        final tempFile = File(path.join(updateDir, fileName));
        final fileSink = tempFile.openWrite();
        
        int downloaded = 0;
        final total = streamedResponse.contentLength ?? 0;
        
        await for (var chunk in streamedResponse.stream) {
          fileSink.add(chunk);
          downloaded += chunk.length;
          if (onProgress != null && total > 0) {
            onProgress(downloaded, total);
          }
        }
        
        await fileSink.close();
        return true;
      }
      
      return false;
    } catch (e) {
      print('خطأ في تنزيل التحديث: $e');
      return false;
    }
  }

  /// تثبيت التحديث وحذف النسخة القديمة
  static Future<bool> installUpdate(String updateFilePath) async {
    try {
      final appPath = Platform.resolvedExecutable;
      final appDir = path.dirname(appPath);
      
      print('بدء تثبيت التحديث من: $updateFilePath');
      print('مسار التطبيق: $appPath');
      print('مجلد التطبيق: $appDir');
      
      // إذا كان الملف ZIP، استخراجه
      if (updateFilePath.endsWith('.zip')) {
        final bytes = await File(updateFilePath).readAsBytes();
        final archive = ZipDecoder().decodeBytes(bytes);
        
        print('تم فك ضغط الأرشيف، عدد الملفات: ${archive.length}');
        
        // إنشاء قائمة بالملفات القديمة قبل الاستبدال
        final oldFiles = <String>[];
        final appDirObj = Directory(appDir);
        if (await appDirObj.exists()) {
          await for (var entity in appDirObj.list(recursive: false)) {
            if (entity is File) {
              final fileName = path.basename(entity.path);
              // لا نحذف ملفات النظام المهمة
              if (!fileName.endsWith('.bat') && 
                  !fileName.endsWith('.log') &&
                  fileName != 'restart.bat') {
                oldFiles.add(entity.path);
              }
            }
          }
        }
        
        // استخراج الملفات الجديدة
        for (var file in archive) {
          final filename = file.name;
          if (file.isFile) {
            final data = file.content as List<int>;
            final outputPath = path.join(appDir, filename);
            final outputFile = File(outputPath);
            
            // إنشاء المجلدات إذا لزم الأمر
            final outputDir = Directory(path.dirname(outputPath));
            if (!await outputDir.exists()) {
              await outputDir.create(recursive: true);
            }
            
            // حذف الملف القديم إذا كان موجوداً
            if (await outputFile.exists()) {
              try {
                await outputFile.delete();
                print('تم حذف الملف القديم: $filename');
              } catch (e) {
                print('تحذير: لم يتم حذف الملف القديم $filename: $e');
              }
            }
            
            // كتابة الملف الجديد
            await outputFile.writeAsBytes(data);
            print('تم استبدال الملف: $filename');
          }
        }
        
        // حذف الملفات القديمة التي لم تعد موجودة في الأرشيف الجديد
        final newFiles = archive
            .where((f) => f.isFile)
            .map((f) => path.join(appDir, f.name))
            .toSet();
        
        for (var oldFile in oldFiles) {
          if (!newFiles.contains(oldFile)) {
            try {
              final file = File(oldFile);
              if (await file.exists()) {
                await file.delete();
                print('تم حذف الملف القديم غير المستخدم: ${path.basename(oldFile)}');
              }
            } catch (e) {
              print('تحذير: لم يتم حذف الملف القديم ${path.basename(oldFile)}: $e');
            }
          }
        }
        
        // حذف ملف ZIP بعد الاستخراج
        try {
          final zipFile = File(updateFilePath);
          if (await zipFile.exists()) {
            await zipFile.delete();
            print('تم حذف ملف ZIP بعد الاستخراج');
          }
        } catch (e) {
          print('تحذير: لم يتم حذف ملف ZIP: $e');
        }
        
        print('تم تثبيت التحديث بنجاح');
        return true;
      } else if (updateFilePath.endsWith('.exe')) {
        // إذا كان ملف EXE، تشغيله للتثبيت
        await Process.run(updateFilePath, [], runInShell: true);
        return true;
      }
      
      return false;
    } catch (e) {
      print('خطأ في تثبيت التحديث: $e');
      return false;
    }
  }

  /// إعادة تشغيل التطبيق تلقائياً
  static Future<void> restartApp() async {
    try {
      final appPath = Platform.resolvedExecutable;
      final appDir = path.dirname(appPath);
      
      print('إعادة تشغيل التطبيق: $appPath');
      
      // إنشاء سكريبت لإعادة التشغيل
      final restartScript = '''
@echo off
REM انتظار ثانيتين للتأكد من إغلاق التطبيق الحالي
timeout /t 2 /nobreak >nul
REM تشغيل التطبيق الجديد
start "" "${appPath.replaceAll('/', '\\')}"
REM حذف السكريبت بعد التشغيل
del "%~f0"
''';
      
      final scriptPath = path.join(appDir, 'restart_app.bat');
      await File(scriptPath).writeAsString(restartScript);
      
      print('تم إنشاء سكريبت إعادة التشغيل: $scriptPath');
      
      // تشغيل السكريبت في الخلفية
      await Process.start(
        'cmd',
        ['/c', scriptPath],
        mode: ProcessStartMode.detached,
        runInShell: true,
      );
      
      // انتظار قصير ثم إغلاق التطبيق الحالي
      await Future.delayed(const Duration(milliseconds: 500));
      exit(0);
    } catch (e) {
      print('خطأ في إعادة تشغيل التطبيق: $e');
      // محاولة بديلة: تشغيل مباشر
      try {
        final appPath = Platform.resolvedExecutable;
        await Process.start(appPath, [], mode: ProcessStartMode.detached);
        await Future.delayed(const Duration(milliseconds: 500));
        exit(0);
      } catch (e2) {
        print('فشلت المحاولة البديلة: $e2');
      }
    }
  }
  
  /// تنزيل وتثبيت التحديث تلقائياً بالكامل
  static Future<bool> downloadAndInstallAutomatically(
    String downloadUrl,
    Function(String status, double progress)? onProgress,
  ) async {
    try {
      // 1. التنزيل
      if (onProgress != null) {
        onProgress('جاري تنزيل التحديث...', 0.0);
      }
      
      final downloadSuccess = await downloadUpdate(
        downloadUrl,
        (downloaded, total) {
          if (onProgress != null && total > 0) {
            final progress = downloaded / total;
            onProgress('جاري تنزيل التحديث...', progress * 0.5); // التنزيل 50%
          }
        },
      );
      
      if (!downloadSuccess) {
        if (onProgress != null) {
          onProgress('فشل تنزيل التحديث', 0.0);
        }
        return false;
      }
      
      // 2. التثبيت
      final appPath = Platform.resolvedExecutable;
      final appDir = path.dirname(appPath);
      final updateDir = path.join(appDir, 'updates');
      final fileName = path.basename(downloadUrl);
      final updateFilePath = path.join(updateDir, fileName);
      
      if (onProgress != null) {
        onProgress('جاري تثبيت التحديث...', 0.5);
      }
      
      final installSuccess = await installUpdate(updateFilePath);
      
      if (!installSuccess) {
        if (onProgress != null) {
          onProgress('فشل تثبيت التحديث', 0.0);
        }
        return false;
      }
      
      if (onProgress != null) {
        onProgress('تم التثبيت بنجاح! جاري إعادة التشغيل...', 1.0);
      }
      
      // 3. إعادة التشغيل التلقائية
      await Future.delayed(const Duration(seconds: 1));
      await restartApp();
      
      return true;
    } catch (e) {
      print('خطأ في التحديث التلقائي: $e');
      if (onProgress != null) {
        onProgress('خطأ: $e', 0.0);
      }
      return false;
    }
  }
}

