import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import '../services/update_service.dart';

class UpdateCheckScreen extends StatefulWidget {
  const UpdateCheckScreen({super.key});

  @override
  State<UpdateCheckScreen> createState() => _UpdateCheckScreenState();
}

class _UpdateCheckScreenState extends State<UpdateCheckScreen> {
  bool _isChecking = false;
  bool _isDownloading = false;
  Map<String, dynamic>? _updateInfo;
  String _errorMessage = '';
  double _downloadProgress = 0.0;

  Future<void> _checkForUpdates() async {
    setState(() {
      _isChecking = true;
      _errorMessage = '';
      _updateInfo = null;
    });

    try {
      final updateInfo = await UpdateService.checkForUpdates();
      
      if (updateInfo != null && updateInfo['hasUpdate'] == true) {
        setState(() {
          _updateInfo = updateInfo;
        });
      } else {
        setState(() {
          _errorMessage = 'التطبيق محدث إلى آخر إصدار';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في التحقق من التحديثات: $e';
      });
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  Future<void> _downloadAndInstall() async {
    if (_updateInfo == null || _updateInfo!['downloadUrl'] == null) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      final downloadUrl = _updateInfo!['downloadUrl'] as String;
      
      // تنزيل التحديث
      final success = await UpdateService.downloadUpdate(
        downloadUrl,
        (downloaded, total) {
          setState(() {
            _downloadProgress = total > 0 ? downloaded / total : 0.0;
          });
        },
      );

      if (success) {
        // تثبيت التحديث
        final appPath = Platform.resolvedExecutable;
        final appDir = path.dirname(appPath);
        final updateDir = path.join(appDir, 'updates');
        final fileName = path.basename(downloadUrl);
        final updateFilePath = path.join(updateDir, fileName);
        
        final installSuccess = await UpdateService.installUpdate(updateFilePath);
        
        if (installSuccess) {
          // إعادة تشغيل التطبيق
          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text('تم التثبيت بنجاح'),
                content: const Text('سيتم إعادة تشغيل التطبيق الآن...'),
                actions: [
                  TextButton(
                    onPressed: () {
                      UpdateService.restartApp();
                    },
                    child: const Text('موافق'),
                  ),
                ],
              ),
            );
          }
        } else {
          setState(() {
            _errorMessage = 'فشل تثبيت التحديث';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'فشل تنزيل التحديث';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ: $e';
      });
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق من التحديثات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isChecking)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('جاري التحقق من التحديثات...'),
                ],
              )
            else if (_isDownloading)
              Column(
                children: [
                  CircularProgressIndicator(value: _downloadProgress),
                  const SizedBox(height: 20),
                  Text('جاري التنزيل: ${(_downloadProgress * 100).toStringAsFixed(1)}%'),
                ],
              )
            else if (_updateInfo != null && _updateInfo!['hasUpdate'] == true)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.circleExclamation, color: Colors.orange),
                          const SizedBox(width: 10),
                          const Text(
                            'تحديث متاح',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('الإصدار الحالي: ${_updateInfo!['currentVersion']}'),
                      Text('الإصدار الجديد: ${_updateInfo!['latestVersion']}'),
                      if (_updateInfo!['releaseNotes'] != null && _updateInfo!['releaseNotes'].toString().isNotEmpty)
                        ...[
                          const SizedBox(height: 10),
                          const Text(
                            'ملاحظات الإصدار:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_updateInfo!['releaseNotes'].toString()),
                        ],
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _downloadAndInstall,
                              icon: const Icon(FontAwesomeIcons.download),
                              label: const Text('تنزيل وتثبيت'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (_updateInfo!['releaseUrl'] != null)
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.externalLink),
                              onPressed: () {
                                // يمكن فتح الرابط في المتصفح
                              },
                              tooltip: 'عرض التفاصيل',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else if (_errorMessage.isNotEmpty)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(FontAwesomeIcons.circleXmark, color: Colors.red, size: 48),
                      const SizedBox(height: 10),
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(FontAwesomeIcons.circleCheck, color: Colors.green, size: 48),
                      const SizedBox(height: 10),
                      const Text(
                        'التطبيق محدث إلى آخر إصدار',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isChecking || _isDownloading ? null : _checkForUpdates,
              icon: const Icon(FontAwesomeIcons.arrowsRotate),
              label: const Text('التحقق مرة أخرى'),
            ),
          ],
        ),
      ),
    );
  }
}

