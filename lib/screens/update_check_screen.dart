import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/update_service.dart';

class UpdateCheckScreen extends StatefulWidget {
  final bool autoInstall;
  final Map<String, dynamic>? updateInfo;
  
  const UpdateCheckScreen({
    super.key,
    this.autoInstall = false,
    this.updateInfo,
  });

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
      _errorMessage = '';
    });

    try {
      final downloadUrl = _updateInfo!['downloadUrl'] as String;
      
      // تنزيل وتثبيت التحديث تلقائياً بالكامل
      final success = await UpdateService.downloadAndInstallAutomatically(
        downloadUrl,
        (status, progress) {
          if (mounted) {
            setState(() {
              _downloadProgress = progress;
              if (status.isNotEmpty) {
                // يمكن عرض حالة التحديث
                print('حالة التحديث: $status - ${(progress * 100).toStringAsFixed(1)}%');
              }
            });
          }
        },
      );

      if (!success) {
        if (mounted) {
          setState(() {
            _errorMessage = 'فشل التحديث التلقائي';
            _isDownloading = false;
          });
        }
      }
      // إذا نجح، سيتم إعادة تشغيل التطبيق تلقائياً
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'خطأ: $e';
          _isDownloading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.updateInfo != null) {
      setState(() {
        _updateInfo = widget.updateInfo;
      });
      if (widget.autoInstall) {
        // بدء التنزيل والتثبيت تلقائياً بعد ثانية واحدة
        Future.delayed(const Duration(seconds: 1), () {
          _downloadAndInstall();
        });
      }
    } else {
      _checkForUpdates();
    }
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
                  CircularProgressIndicator(value: _downloadProgress > 0 ? _downloadProgress : null),
                  const SizedBox(height: 20),
                  Text(
                    _downloadProgress < 0.5
                        ? 'جاري تنزيل التحديث: ${(_downloadProgress * 100).toStringAsFixed(1)}%'
                        : _downloadProgress < 1.0
                            ? 'جاري تثبيت التحديث: ${(_downloadProgress * 100).toStringAsFixed(1)}%'
                            : 'تم التثبيت! جاري إعادة التشغيل...',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
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

