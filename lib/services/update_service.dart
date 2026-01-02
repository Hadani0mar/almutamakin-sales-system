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
      // التحقق من وجود الملف
      final zipFile = File(updateFilePath);
      if (!await zipFile.exists()) {
        print('خطأ: ملف التحديث غير موجود: $updateFilePath');
        return false;
      }
      
      final appPath = Platform.resolvedExecutable;
      final appDir = path.dirname(appPath);
      
      print('بدء تثبيت التحديث من: $updateFilePath');
      print('مسار التطبيق: $appPath');
      print('مجلد التطبيق: $appDir');
      
      // إذا كان الملف ZIP، استخراجه
      if (updateFilePath.endsWith('.zip')) {
        print('قراءة ملف ZIP...');
        final bytes = await zipFile.readAsBytes();
        print('حجم ملف ZIP: ${bytes.length} بايت');
        
        print('فك ضغط الأرشيف...');
        final archive = ZipDecoder().decodeBytes(bytes);
        
        print('تم فك ضغط الأرشيف، عدد الملفات: ${archive.length}');
        
        if (archive.isEmpty) {
          print('خطأ: الأرشيف فارغ');
          return false;
        }
        
        int extractedCount = 0;
        int skippedCount = 0;
        
        // استخراج الملفات الجديدة
        for (var file in archive) {
          try {
            final filename = file.name;
            
            // تخطي المجلدات
            if (!file.isFile) {
              continue;
            }
            
            // تجاهل الملفات في المجلد الجذر فقط (لا نستخرج المجلدات الفرعية)
            if (filename.contains('/') || filename.contains('\\')) {
              // استخراج الملفات من المجلدات الفرعية أيضاً
              final outputPath = path.join(appDir, filename.replaceAll('/', path.separator));
              final outputFile = File(outputPath);
              
              // إنشاء المجلدات إذا لزم الأمر
              final outputDir = Directory(path.dirname(outputPath));
              if (!await outputDir.exists()) {
                await outputDir.create(recursive: true);
                print('تم إنشاء المجلد: ${path.dirname(outputPath)}');
              }
              
              // حذف الملف القديم إذا كان موجوداً
              if (await outputFile.exists()) {
                try {
                  await outputFile.delete();
                  print('تم حذف الملف القديم: $filename');
                } catch (e) {
                  print('تحذير: لم يتم حذف الملف القديم $filename: $e');
                  // محاولة إعادة تسمية الملف القديم بدلاً من حذفه
                  try {
                    final oldFile = File('${outputFile.path}.old');
                    if (await oldFile.exists()) {
                      await oldFile.delete();
                    }
                    await outputFile.rename(oldFile.path);
                    print('تم إعادة تسمية الملف القديم: $filename');
                  } catch (e2) {
                    print('تحذير: لم يتم إعادة تسمية الملف القديم: $e2');
                  }
                }
              }
              
              // كتابة الملف الجديد
              final data = file.content as List<int>;
              await outputFile.writeAsBytes(data);
              extractedCount++;
              print('تم استخراج الملف: $filename (${data.length} بايت)');
            } else {
              // ملف في المجلد الجذر
              final outputPath = path.join(appDir, filename);
              final outputFile = File(outputPath);
              
              // حذف الملف القديم إذا كان موجوداً
              if (await outputFile.exists()) {
                try {
                  // إذا كان الملف قيد الاستخدام (مثل EXE)، نحاول إعادة تسميته
                  if (filename.endsWith('.exe') || filename.endsWith('.dll')) {
                    final oldFile = File('${outputFile.path}.old');
                    if (await oldFile.exists()) {
                      await oldFile.delete();
                    }
                    await outputFile.rename(oldFile.path);
                    print('تم إعادة تسمية الملف القديم: $filename');
                  } else {
                    await outputFile.delete();
                    print('تم حذف الملف القديم: $filename');
                  }
                } catch (e) {
                  print('تحذير: لم يتم حذف/إعادة تسمية الملف القديم $filename: $e');
                  // محاولة إعادة تسمية بدلاً من الحذف
                  try {
                    final oldFile = File('${outputFile.path}.old');
                    if (await oldFile.exists()) {
                      await oldFile.delete();
                    }
                    await outputFile.rename(oldFile.path);
                    print('تم إعادة تسمية الملف القديم: $filename');
                  } catch (e2) {
                    print('خطأ: فشل إعادة تسمية الملف: $e2');
                    skippedCount++;
                    continue;
                  }
                }
              }
              
              // كتابة الملف الجديد
              final data = file.content as List<int>;
              await outputFile.writeAsBytes(data);
              extractedCount++;
              print('تم استخراج الملف: $filename (${data.length} بايت)');
            }
          } catch (e) {
            print('خطأ في استخراج الملف ${file.name}: $e');
            skippedCount++;
          }
        }
        
        print('تم استخراج $extractedCount ملف، تم تخطي $skippedCount ملف');
        
        if (extractedCount == 0) {
          print('خطأ: لم يتم استخراج أي ملفات');
          return false;
        }
        
        // حذف ملف ZIP بعد الاستخراج الناجح
        try {
          await zipFile.delete();
          print('تم حذف ملف ZIP بعد الاستخراج');
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
      
      print('خطأ: نوع الملف غير مدعوم');
      return false;
    } catch (e, stackTrace) {
      print('خطأ في تثبيت التحديث: $e');
      print('Stack trace: $stackTrace');
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
      
      // 2. التحقق من وجود الملف قبل التثبيت
      final appPath = Platform.resolvedExecutable;
      final appDir = path.dirname(appPath);
      final updateDir = path.join(appDir, 'updates');
      final fileName = path.basename(downloadUrl);
      final updateFilePath = path.join(updateDir, fileName);
      
      // التحقق من وجود الملف
      final downloadedFile = File(updateFilePath);
      if (!await downloadedFile.exists()) {
        print('خطأ: ملف التحديث غير موجود بعد التنزيل: $updateFilePath');
        if (onProgress != null) {
          onProgress('خطأ: ملف التحديث غير موجود', 0.0);
        }
        return false;
      }
      
      final fileSize = await downloadedFile.length();
      print('تم تنزيل الملف بنجاح: $updateFilePath (${fileSize} بايت)');
      
      if (onProgress != null) {
        onProgress('جاري تثبيت التحديث...', 0.5);
      }
      
      print('بدء عملية التثبيت...');
      final installSuccess = await installUpdate(updateFilePath);
      
      if (!installSuccess) {
        print('فشل تثبيت التحديث');
        if (onProgress != null) {
          onProgress('فشل تثبيت التحديث', 0.0);
        }
        return false;
      }
      
      print('تم تثبيت التحديث بنجاح');
      
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

