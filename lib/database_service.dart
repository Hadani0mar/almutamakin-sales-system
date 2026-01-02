import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

// ODBC Function Type Definitions
typedef SQLAllocHandleNative = Int16 Function(
    Int16 handleType, Pointer<Void> inputHandle, Pointer<Pointer<Void>> outputHandle);
typedef SQLAllocHandleDart = int Function(
    int handleType, Pointer<Void> inputHandle, Pointer<Pointer<Void>> outputHandle);

typedef SQLFreeHandleNative = Int16 Function(Int16 handleType, Pointer<Void> handle);
typedef SQLFreeHandleDart = int Function(int handleType, Pointer<Void> handle);

typedef SQLDriverConnectNative = Int16 Function(
    Pointer<Void> hdbc,
    Pointer<Void> hwnd,
    Pointer<Uint16> inConnStr,
    Int16 inConnStrLen,
    Pointer<Uint16> outConnStr,
    Int16 outConnStrBufLen,
    Pointer<Int16> outConnStrLen,
    Int16 driverCompletion);
typedef SQLDriverConnectDart = int Function(
    Pointer<Void> hdbc,
    Pointer<Void> hwnd,
    Pointer<Uint16> inConnStr,
    int inConnStrLen,
    Pointer<Uint16> outConnStr,
    int outConnStrBufLen,
    Pointer<Int16> outConnStrLen,
    int driverCompletion);

typedef SQLDisconnectNative = Int16 Function(Pointer<Void> hdbc);
typedef SQLDisconnectDart = int Function(Pointer<Void> hdbc);

typedef SQLExecDirectNative = Int16 Function(
    Pointer<Void> hstmt, Pointer<Uint16> sql, IntPtr sqlLen);
typedef SQLExecDirectDart = int Function(
    Pointer<Void> hstmt, Pointer<Uint16> sql, int sqlLen);

typedef SQLFetchNative = Int16 Function(Pointer<Void> hstmt);
typedef SQLFetchDart = int Function(Pointer<Void> hstmt);

typedef SQLGetDataNative = Int16 Function(
    Pointer<Void> hstmt,
    Int16 colNum,
    Int16 targetType,
    Pointer<Void> targetValue,
    IntPtr bufferLength,
    Pointer<IntPtr> strLenOrInd);
typedef SQLGetDataDart = int Function(
    Pointer<Void> hstmt,
    int colNum,
    int targetType,
    Pointer<Void> targetValue,
    int bufferLength,
    Pointer<IntPtr> strLenOrInd);

typedef SQLNumResultColsNative = Int16 Function(
    Pointer<Void> hstmt, Pointer<Int16> columnCount);
typedef SQLNumResultColsDart = int Function(
    Pointer<Void> hstmt, Pointer<Int16> columnCount);

typedef SQLDescribeColNative = Int16 Function(
    Pointer<Void> hstmt,
    Int16 colNum,
    Pointer<Uint16> colName,
    Int16 bufferLength,
    Pointer<Int16> nameLength,
    Pointer<Int16> dataType,
    Pointer<IntPtr> colSize,
    Pointer<Int16> decimalDigits,
    Pointer<Int16> nullable);
typedef SQLDescribeColDart = int Function(
    Pointer<Void> hstmt,
    int colNum,
    Pointer<Uint16> colName,
    int bufferLength,
    Pointer<Int16> nameLength,
    Pointer<Int16> dataType,
    Pointer<IntPtr> colSize,
    Pointer<Int16> decimalDigits,
    Pointer<Int16> nullable);

typedef SQLAllocStmtNative = Int16 Function(
    Pointer<Void> hdbc, Pointer<Pointer<Void>> hstmt);
typedef SQLAllocStmtDart = int Function(
    Pointer<Void> hdbc, Pointer<Pointer<Void>> hstmt);

typedef SQLFreeStmtNative = Int16 Function(Pointer<Void> hstmt, Int16 option);
typedef SQLFreeStmtDart = int Function(Pointer<Void> hstmt, int option);

typedef SQLGetDiagRecNative = Int16 Function(
    Int16 handleType,
    Pointer<Void> handle,
    Int16 recNumber,
    Pointer<Uint16> sqlState,
    Pointer<IntPtr> nativeError,
    Pointer<Uint16> messageText,
    Int16 bufferLength,
    Pointer<Int16> textLength);
typedef SQLGetDiagRecDart = int Function(
    int handleType,
    Pointer<Void> handle,
    int recNumber,
    Pointer<Uint16> sqlState,
    Pointer<IntPtr> nativeError,
    Pointer<Uint16> messageText,
    int bufferLength,
    Pointer<Int16> textLength);

typedef SQLSetEnvAttrNative = Int16 Function(
    Pointer<Void> environmentHandle,
    Int32 attribute,
    IntPtr valuePtr,
    Int32 stringLength);
typedef SQLSetEnvAttrDart = int Function(
    Pointer<Void> environmentHandle,
    int attribute,
    int valuePtr,
    int stringLength);

/// DatabaseService using ODBC for direct SQL Server connection on Windows
class DatabaseService {
  // معلومات الاتصال
  static const String server = 'localhost';
  static const String database = 'InfinityRetailDB';
  static const String username = 'sa';
  static const String password = '123';

  // ODBC connection handle
  Pointer<Void>? _henv; // Environment handle
  Pointer<Void>? _hdbc; // Connection handle
  bool _isConnected = false;
  
  // ODBC library
  DynamicLibrary? _odbcLib;

  // ODBC constants
  static const int SQL_HANDLE_ENV = 1;
  static const int SQL_HANDLE_DBC = 2;
  static const int SQL_HANDLE_STMT = 3;
  static const int SQL_SUCCESS = 0;
  static const int SQL_SUCCESS_WITH_INFO = 1;
  static const int SQL_DRIVER_NOPROMPT = 0;
  static const int SQL_NTS = -3;
  static const int SQL_C_CHAR = 1;
  static const int SQL_C_WCHAR = -8; // Unicode wide character
  static const int SQL_FETCH_NEXT = 1;
  static const int SQL_NO_DATA = 100;
  static const int SQL_ATTR_ODBC_VERSION = 200;
  static const int SQL_OV_ODBC3 = 3;

  /// Loads the ODBC library (odbc32.dll on Windows)
  void _loadOdbcLibrary() {
    if (!Platform.isWindows) {
      throw UnsupportedError('ODBC is only supported on Windows');
    }
    
    _odbcLib = DynamicLibrary.open('odbc32.dll');
  }

  /// Builds the ODBC connection string for SQL Server
  String _buildConnectionString() {
    return 'Driver={SQL Server};Server=$server;Database=$database;Uid=$username;Pwd=$password;';
  }

  /// Connects to the SQL Server database using ODBC
  Future<bool> connect() async {
    try {
      if (_isConnected && _hdbc != null) {
        return true;
      }

      _loadOdbcLibrary();
      
      // Ensure library is loaded
      if (_odbcLib == null) {
        print('فشل تحميل مكتبة ODBC');
        return false;
      }
      
      // Allocate environment handle
      final henvPtr = calloc<Pointer<Void>>();
      final ret1 = _sqlAllocHandle(
        SQL_HANDLE_ENV,
        nullptr,
        henvPtr,
      );
      
      if (ret1 != SQL_SUCCESS && ret1 != SQL_SUCCESS_WITH_INFO) {
        calloc.free(henvPtr);
        print('فشل تخصيص Environment Handle');
        return false;
      }
      
      _henv = henvPtr.value;
      
      // Set ODBC version attribute (required before allocating connection handle)
      // SQL_ATTR_ODBC_VERSION requires the value itself (not a pointer) for integer attributes
      final retSetAttr = _sqlSetEnvAttr(
        _henv!,
        SQL_ATTR_ODBC_VERSION,
        SQL_OV_ODBC3, // Pass the value directly
        0, // StringLength is 0 for integer attributes
      );
      
      if (retSetAttr != SQL_SUCCESS && retSetAttr != SQL_SUCCESS_WITH_INFO) {
        _printError(SQL_HANDLE_ENV, _henv!);
        _sqlFreeHandle(SQL_HANDLE_ENV, _henv!);
        calloc.free(henvPtr);
        print('فشل تعيين ODBC Version. كود الخطأ: $retSetAttr');
        return false;
      }
      
      // Allocate connection handle
      final hdbcPtr = calloc<Pointer<Void>>();
      final ret2 = _sqlAllocHandle(
        SQL_HANDLE_DBC,
        _henv!,
        hdbcPtr,
      );
      
      if (ret2 != SQL_SUCCESS && ret2 != SQL_SUCCESS_WITH_INFO) {
        _sqlFreeHandle(SQL_HANDLE_ENV, _henv!);
        calloc.free(henvPtr);
        calloc.free(hdbcPtr);
        print('فشل تخصيص Connection Handle');
        return false;
      }
      
      _hdbc = hdbcPtr.value;
      
      // Build connection string
      final connStr = _buildConnectionString();
      final connStrPtr = connStr.toNativeUtf16();
      final connStrLen = connStr.length * 2; // UTF-16 is 2 bytes per character
      final outConnStrPtr = calloc<Uint16>(1024);
      final outConnStrLenPtr = calloc<Int16>();
      
      // Connect
      int ret3;
      try {
        ret3 = _sqlDriverConnect(
          _hdbc!,
          nullptr,
          connStrPtr.cast<Uint16>(),
          connStrLen,
          outConnStrPtr,
          1024,
          outConnStrLenPtr,
          SQL_DRIVER_NOPROMPT,
        );
      } catch (e) {
        print('خطأ في استدعاء SQLDriverConnect: $e');
        malloc.free(connStrPtr);
        calloc.free(outConnStrPtr);
        calloc.free(outConnStrLenPtr);
        calloc.free(henvPtr);
        calloc.free(hdbcPtr);
        _cleanup();
        return false;
      }
      
      malloc.free(connStrPtr);
      calloc.free(outConnStrPtr);
      calloc.free(outConnStrLenPtr);
      calloc.free(henvPtr);
      calloc.free(hdbcPtr);
      
      if (ret3 == SQL_SUCCESS || ret3 == SQL_SUCCESS_WITH_INFO) {
        _isConnected = true;
        print('تم الاتصال بقاعدة البيانات بنجاح');
        return true;
      } else {
        print('فشل الاتصال. كود الخطأ: $ret3');
        _printError(SQL_HANDLE_DBC, _hdbc!);
        _cleanup();
        return false;
      }
    } catch (e) {
      print('خطأ في الاتصال بقاعدة البيانات: $e');
      _cleanup();
      return false;
    }
  }

  /// Executes a SQL query and returns results as List<Map<String, dynamic>>
  Future<List<Map<String, dynamic>>> query(String sql) async {
    if (!_isConnected || _hdbc == null) {
      throw Exception('غير متصل بقاعدة البيانات. يرجى استدعاء connect() أولاً');
    }

    try {
      // Allocate statement handle
      final hstmtPtr = calloc<Pointer<Void>>();
      final ret1 = _sqlAllocHandle(
        SQL_HANDLE_STMT,
        _hdbc!,
        hstmtPtr,
      );
      
      if (ret1 != SQL_SUCCESS && ret1 != SQL_SUCCESS_WITH_INFO) {
        calloc.free(hstmtPtr);
        throw Exception('فشل تخصيص Statement Handle');
      }
      
      final hstmt = hstmtPtr.value;
      
      // Execute query
      final sqlPtr = sql.toNativeUtf16();
      final ret2 = _sqlExecDirect(
        hstmt,
        sqlPtr.cast<Uint16>(),
        SQL_NTS,
      );
      
      malloc.free(sqlPtr);
      
      if (ret2 != SQL_SUCCESS && ret2 != SQL_SUCCESS_WITH_INFO && ret2 != SQL_NO_DATA) {
        _printError(SQL_HANDLE_STMT, hstmt);
        _sqlFreeHandle(SQL_HANDLE_STMT, hstmt);
        calloc.free(hstmtPtr);
        throw Exception('فشل تنفيذ الاستعلام');
      }
      
      // Get number of columns
      final numColsPtr = calloc<Int16>();
      _sqlNumResultCols(hstmt, numColsPtr);
      final numCols = numColsPtr.value;
      calloc.free(numColsPtr);
      
      if (numCols == 0) {
        _sqlFreeHandle(SQL_HANDLE_STMT, hstmt);
        calloc.free(hstmtPtr);
        return [];
      }
      
      // Get column names and types
      final columnNames = <String>[];
      for (int i = 1; i <= numCols; i++) {
        final colNamePtr = calloc<Uint16>(256);
        final nameLenPtr = calloc<Int16>();
        final dataTypePtr = calloc<Int16>();
        final colSizePtr = calloc<IntPtr>();
        final decimalPtr = calloc<Int16>();
        final nullablePtr = calloc<Int16>();
        
        _sqlDescribeCol(
          hstmt,
          i,
          colNamePtr,
          256,
          nameLenPtr,
          dataTypePtr,
          colSizePtr,
          decimalPtr,
          nullablePtr,
        );
        
        final colName = colNamePtr.cast<Utf16>().toDartString(length: nameLenPtr.value);
        columnNames.add(colName);
        
        calloc.free(colNamePtr);
        calloc.free(nameLenPtr);
        calloc.free(dataTypePtr);
        calloc.free(colSizePtr);
        calloc.free(decimalPtr);
        calloc.free(nullablePtr);
      }
      
      // Fetch rows
      final rows = <Map<String, dynamic>>[];
      final bufferSize = 1024;
      
      while (true) {
        final ret = _sqlFetch(hstmt);
        if (ret == SQL_NO_DATA) {
          break;
        }
        if (ret != SQL_SUCCESS && ret != SQL_SUCCESS_WITH_INFO) {
          break;
        }
        
        final row = <String, dynamic>{};
        for (int i = 1; i <= numCols; i++) {
          final colName = columnNames[i - 1];
          final dataPtr = calloc<Uint16>(bufferSize);
          final lenPtr = calloc<IntPtr>();
          
          final retData = _sqlGetData(
            hstmt,
            i,
            SQL_C_WCHAR, // Use Unicode wide character for Arabic text
            dataPtr.cast<Void>(),
            bufferSize * 2, // Buffer size in bytes (UTF-16 is 2 bytes per character)
            lenPtr,
          );
          
          if (retData == SQL_SUCCESS || retData == SQL_SUCCESS_WITH_INFO) {
            if (lenPtr.value > 0 && lenPtr.value != -1) {
              // lenPtr.value is in bytes, divide by 2 to get character count for UTF-16
              final charCount = lenPtr.value ~/ 2;
              final value = dataPtr.cast<Utf16>().toDartString(length: charCount);
              row[colName] = value;
            } else {
              row[colName] = null;
            }
          } else {
            row[colName] = null;
          }
          
          calloc.free(dataPtr);
          calloc.free(lenPtr);
        }
        
        rows.add(row);
      }
      
      // Clean up
      _sqlFreeHandle(SQL_HANDLE_STMT, hstmt);
      calloc.free(hstmtPtr);
      
      return rows;
    } catch (e) {
      print('خطأ في تنفيذ الاستعلام: $e');
      rethrow;
    }
  }

  /// Closes the database connection and frees resources
  Future<void> close() async {
    _cleanup();
  }

  void _cleanup() {
    try {
      if (_hdbc != null) {
        _sqlDisconnect(_hdbc!);
        _sqlFreeHandle(SQL_HANDLE_DBC, _hdbc!);
        _hdbc = null;
      }
      if (_henv != null) {
        _sqlFreeHandle(SQL_HANDLE_ENV, _henv!);
        _henv = null;
      }
      _isConnected = false;
      print('تم إغلاق الاتصال بقاعدة البيانات');
    } catch (e) {
      print('خطأ في إغلاق الاتصال: $e');
    }
  }

  void _printError(int handleType, Pointer<Void> handle) {
    try {
      final sqlStatePtr = calloc<Uint16>(6);
      final msgPtr = calloc<Uint16>(1024);
      final msgLenPtr = calloc<Int16>();
      final nativeErrorPtr = calloc<IntPtr>();
      
      final ret = _sqlGetDiagRec(
        handleType,
        handle,
        1,
        sqlStatePtr,
        nativeErrorPtr,
        msgPtr,
        1024,
        msgLenPtr,
      );
      
      if (ret == SQL_SUCCESS || ret == SQL_SUCCESS_WITH_INFO) {
        final sqlState = sqlStatePtr.cast<Utf16>().toDartString(length: 5);
        final msg = msgPtr.cast<Utf16>().toDartString(length: msgLenPtr.value);
        final nativeError = nativeErrorPtr.value;
        print('ODBC Error: [$sqlState] $nativeError - $msg');
      }
      
      calloc.free(sqlStatePtr);
      calloc.free(msgPtr);
      calloc.free(msgLenPtr);
      calloc.free(nativeErrorPtr);
    } catch (e) {
      print('خطأ في طباعة الخطأ: $e');
    }
  }

  /// Checks if currently connected to the database
  bool get isConnected => _isConnected && _hdbc != null;

  /// Test the connection by executing a simple query
  Future<bool> testConnection() async {
    try {
      if (!_isConnected || _hdbc == null) {
        final connected = await connect();
        if (!connected) {
          print('فشل الاتصال في testConnection');
          return false;
        }
      }
      
      if (!_isConnected || _hdbc == null) {
        print('الاتصال غير نشط بعد connect()');
        return false;
      }
      
      await query('SELECT 1 AS test');
      return true;
    } catch (e) {
      print('فشل اختبار الاتصال: $e');
      _isConnected = false;
      return false;
    }
  }

  // ODBC Function Wrappers (as getters)
  SQLAllocHandleDart get _sqlAllocHandle {
    return _odbcLib!.lookupFunction<SQLAllocHandleNative, SQLAllocHandleDart>('SQLAllocHandle');
  }
  SQLFreeHandleDart get _sqlFreeHandle {
    return _odbcLib!.lookupFunction<SQLFreeHandleNative, SQLFreeHandleDart>('SQLFreeHandle');
  }
  
  SQLDriverConnectDart get _sqlDriverConnect {
    return _odbcLib!.lookupFunction<SQLDriverConnectNative, SQLDriverConnectDart>('SQLDriverConnectW');
  }
  
  SQLDisconnectDart get _sqlDisconnect {
    return _odbcLib!.lookupFunction<SQLDisconnectNative, SQLDisconnectDart>('SQLDisconnect');
  }
  
  SQLExecDirectDart get _sqlExecDirect {
    return _odbcLib!.lookupFunction<SQLExecDirectNative, SQLExecDirectDart>('SQLExecDirectW');
  }
  
  SQLFetchDart get _sqlFetch {
    return _odbcLib!.lookupFunction<SQLFetchNative, SQLFetchDart>('SQLFetch');
  }
  
  SQLGetDataDart get _sqlGetData {
    return _odbcLib!.lookupFunction<SQLGetDataNative, SQLGetDataDart>('SQLGetData');
  }
  
  SQLNumResultColsDart get _sqlNumResultCols {
    return _odbcLib!.lookupFunction<SQLNumResultColsNative, SQLNumResultColsDart>('SQLNumResultCols');
  }
  
  SQLDescribeColDart get _sqlDescribeCol {
    return _odbcLib!.lookupFunction<SQLDescribeColNative, SQLDescribeColDart>('SQLDescribeColW');
  }
  
  SQLAllocStmtDart get _sqlAllocStmt {
    return _odbcLib!.lookupFunction<SQLAllocStmtNative, SQLAllocStmtDart>('SQLAllocHandle');
  }
  
  SQLFreeStmtDart get _sqlFreeStmt {
    return _odbcLib!.lookupFunction<SQLFreeStmtNative, SQLFreeStmtDart>('SQLFreeStmt');
  }
  
  SQLGetDiagRecDart get _sqlGetDiagRec {
    return _odbcLib!.lookupFunction<SQLGetDiagRecNative, SQLGetDiagRecDart>('SQLGetDiagRecW');
  }
  
  SQLSetEnvAttrDart get _sqlSetEnvAttr {
    return _odbcLib!.lookupFunction<SQLSetEnvAttrNative, SQLSetEnvAttrDart>('SQLSetEnvAttr');
  }

  // Static methods for backward compatibility
  static Future<bool> testConnectionStatic() async {
    final service = DatabaseService();
    return await service.testConnection();
  }

  static Future<Map<String, List<String>>> getTablesBySchema() async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT TABLE_SCHEMA, TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
        ORDER BY TABLE_SCHEMA, TABLE_NAME
      ''';
      
      final results = await service.query(query);
      final tablesBySchema = <String, List<String>>{};
      
      for (var row in results) {
        final schema = row['TABLE_SCHEMA']?.toString() ?? '';
        final table = row['TABLE_NAME']?.toString() ?? '';
        if (!tablesBySchema.containsKey(schema)) {
          tablesBySchema[schema] = [];
        }
        tablesBySchema[schema]!.add(table);
      }
      
      return tablesBySchema;
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  static Future<List<String>> getTableColumns(String schema, String tableName) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = '$schema' AND TABLE_NAME = '$tableName'
        ORDER BY ORDINAL_POSITION
      ''';
      
      final results = await service.query(query);
      return results.map((row) => row['COLUMN_NAME']?.toString() ?? '').toList();
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  static Future<List<Map<String, dynamic>>> getTableData(
    String schema,
    String tableName, {
    int limit = 100,
    int offset = 0,
  }) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT TOP $limit *
        FROM [$schema].[$tableName]
        ORDER BY (SELECT NULL)
        OFFSET $offset ROWS
      ''';
      
      return await service.query(query);
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  static Future<int> getTableRowCount(String schema, String tableName) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT COUNT(*) as count
        FROM [$schema].[$tableName]
      ''';
      
      final results = await service.query(query);
      if (results.isNotEmpty) {
        return int.tryParse(results.first['count']?.toString() ?? '0') ?? 0;
      }
      return 0;
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get product groups/categories
  static Future<List<Map<String, dynamic>>> getProductGroups() async {
    final service = DatabaseService();
    await service.connect();
    try {
      final query = '''
        SELECT 
          ProductGroupID_PK,
          ProductGroupDescription
        FROM Inventory.RefProductGroups
        ORDER BY ProductGroupDescription
      ''';
      
      final results = await service.query(query);
      return results;
    } finally {
      await service.close();
    }
  }

  // Add new product group/category
  static Future<int> addProductGroup(String groupDescription) async {
    final service = DatabaseService();
    await service.connect();
    try {
      final escapedDescription = groupDescription.replaceAll("'", "''");
      final query = '''
        INSERT INTO Inventory.RefProductGroups (ProductGroupDescription)
        OUTPUT INSERTED.ProductGroupID_PK
        VALUES (N'$escapedDescription')
      ''';
      
      final results = await service.query(query);
      if (results.isEmpty) {
        throw Exception('فشل إضافة الفئة: لم يتم إرجاع معرف الفئة');
      }
      
      final groupIdValue = results.first['ProductGroupID_PK'];
      final groupId = groupIdValue is int 
          ? groupIdValue 
          : int.tryParse(groupIdValue?.toString() ?? '0') ?? 0;
      
      if (groupId == 0) {
        throw Exception('فشل إضافة الفئة: معرف الفئة غير صحيح');
      }
      
      print('تم إضافة الفئة بنجاح: $groupDescription (ID: $groupId)');
      return groupId;
    } catch (e) {
      print('خطأ في إضافة الفئة: $e');
      rethrow;
    } finally {
      await service.close();
    }
  }

  static Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int pageSize = 50,
    String? search,
    int? productGroupId,
    String? sortBy,
    String? sortOrder,
  }) async {
    final service = DatabaseService();
    await service.connect();
    try {
      final offset = (page - 1) * pageSize;
      var whereConditions = <String>[];
      
      if (search != null && search.isNotEmpty) {
        final escapedSearch = search.replaceAll("'", "''");
        whereConditions.add("(p.ProductName LIKE N'%$escapedSearch%' OR p.ProductCode LIKE N'%$escapedSearch%')");
      }
      
      if (productGroupId != null) {
        whereConditions.add("p.ProductGroupID_FK = $productGroupId");
      }
      
      // Only show active products
      whereConditions.add("p.IsInActive = 0");
      
      final whereClause = whereConditions.isNotEmpty 
          ? 'WHERE ${whereConditions.join(' AND ')}'
          : '';
      
      final orderBy = sortBy != null 
          ? 'ORDER BY $sortBy ${sortOrder ?? 'DESC'}'
          : 'ORDER BY p.ProductName ASC';
      
      // Count query
      final countQuery = '''
        SELECT COUNT(*) as count
        FROM Inventory.Data_Products p
        $whereClause
      ''';
      
      final countResults = await service.query(countQuery);
      final totalCount = countResults.isNotEmpty 
          ? (int.tryParse(countResults.first['count']?.toString() ?? '0') ?? 0)
          : 0;
      
      // Data query - Join with ProductUOMs to get prices
      final dataQuery = '''
        SELECT 
          p.ProductID_PK,
          p.ProductCode,
          p.ProductName,
          p.ProductShortName,
          p.StockOnHand,
          p.StockOnHold,
          p.MinStockLevel,
          p.MaxStockLevel,
          p.IsInActive,
          p.TotalSoldQYT,
          p.LastSalesTransactionDate,
          p.SalesDecription,
          p.DefaultSellUomID_FK,
          p.ProductGroupID_FK,
          uom.UomPrice1 as UnitPrice,
          uom.UomCost as UnitCost,
          uom.UomID_FK,
          ref.UOMName
        FROM Inventory.Data_Products p
        LEFT JOIN Inventory.Data_ProductUOMs uom ON p.ProductID_PK = uom.ProductID_FK AND uom.UomID_FK = p.DefaultSellUomID_FK
        LEFT JOIN Inventory.RefUOMs ref ON uom.UomID_FK = ref.UOMID_PK
        $whereClause
        $orderBy
        OFFSET $offset ROWS FETCH NEXT $pageSize ROWS ONLY
      ''';
      
      final data = await service.query(dataQuery);
      
      return {
        'data': data,
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': (totalCount / pageSize).ceil(),
      };
    } finally {
      await service.close();
    }
  }

  // Update product stock after sale
  static Future<void> updateProductStock(int productId, double quantitySold) async {
    final service = DatabaseService();
    await service.connect();
    try {
      final query = '''
        UPDATE Inventory.Data_Products
        SET 
          StockOnHand = StockOnHand - $quantitySold,
          TotalSoldQYT = TotalSoldQYT + $quantitySold,
          LastSalesTransactionDate = GETDATE()
        WHERE ProductID_PK = $productId
      ''';
      
      await service.query(query);
      print('تم تحديث مخزون المنتج: ProductID=$productId, QuantitySold=$quantitySold');
    } catch (e) {
      print('خطأ في تحديث مخزون المنتج: $e');
      rethrow;
    } finally {
      await service.close();
    }
  }

  static Future<Map<String, dynamic>> getSales({
    int page = 1,
    int pageSize = 50,
    String? search,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final service = DatabaseService();
    await service.connect();
    try {
      // حساب الإزاحة للصفحات (Pagination)
      final offset = (page - 1) * pageSize;
      
      // تجهيز متغيرات التاريخ مع التوقيت
      // استخدام تنسيق yyyy-MM-dd مع إضافة التوقيت لضمان الدقة والأداء الأفضل
      String? fromDateStr;
      String? toDateStr;
      
      print('=== getSales تم استدعاؤها ===');
      print('fromDate parameter: $fromDate');
      print('toDate parameter: $toDate');
      
      if (fromDate != null) {
        // تنسيق التاريخ: yyyy-MM-dd فقط (بدون التوقيت) للاستخدام مع CAST
        fromDateStr = '${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}';
        print('من تاريخ (مُنسق): $fromDateStr');
      } else {
        print('من تاريخ: null (لن يتم تطبيق فلترة من تاريخ)');
      }
      
      if (toDate != null) {
        // تنسيق التاريخ: yyyy-MM-dd فقط (بدون التوقيت) للاستخدام مع CAST
        toDateStr = '${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}';
        print('إلى تاريخ (مُنسق): $toDateStr');
      } else {
        print('إلى تاريخ: null (لن يتم تطبيق فلترة إلى تاريخ)');
      }
      
      // بناء قائمة الشروط باستخدام Alias موحد (inv) لتجنب تكرار الكود
      final List<String> whereConditions = ['1=1'];
      
      if (search != null && search.isNotEmpty) {
        final escapedSearch = search.replaceAll("'", "''");
        whereConditions.add("(inv.InvoiceNumber LIKE N'%$escapedSearch%' OR inv.CashCustomerName LIKE N'%$escapedSearch%' OR inv.TransactionBarcode LIKE N'%$escapedSearch%')");
        print('بحث: $escapedSearch');
      }
      
      if (fromDateStr != null) {
        // استخدام CAST لتحويل التاريخ إلى DATE ثم مقارنته
        // نفس التنسيق المستخدم في Terminal الذي نجح: CAST('2024-08-20' AS DATE)
        whereConditions.add("CAST(inv.SalesInvoiceDate AS DATE) >= CAST('$fromDateStr' AS DATE)");
        print('تم إضافة شرط من تاريخ: CAST(inv.SalesInvoiceDate AS DATE) >= CAST(\'$fromDateStr\' AS DATE)');
      }
      
      if (toDateStr != null) {
        // استخدام CAST لتحويل التاريخ إلى DATE ثم مقارنته
        // نفس التنسيق المستخدم في Terminal الذي نجح: CAST('2026-01-01' AS DATE)
        whereConditions.add("CAST(inv.SalesInvoiceDate AS DATE) <= CAST('$toDateStr' AS DATE)");
        print('تم إضافة شرط إلى تاريخ: CAST(inv.SalesInvoiceDate AS DATE) <= CAST(\'$toDateStr\' AS DATE)');
      }
      
      final whereClause = 'WHERE ${whereConditions.join(' AND ')}';
      
      // استعلام العدد الكلي (مع Alias موحد)
      final countQuery = '''
        SELECT COUNT(*) as count
        FROM SALES.Data_SalesInvoices inv
        $whereClause
      ''';
      
      print('=== استعلام العد ===');
      print('$countQuery');
      print('===================');
      
      final countResults = await service.query(countQuery);
      print('نتيجة استعلام العد: $countResults');
      
      final totalCount = countResults.isNotEmpty 
          ? (int.tryParse(countResults.first['count']?.toString() ?? '0') ?? 0)
          : 0;
      
      print('عدد النتائج الإجمالي: $totalCount');
      
      // استعلام البيانات (مع Pagination)
      final dataQuery = '''
        SELECT 
          inv.SalesInvoiceID_PK,
          inv.SalesInvoiceDate,
          inv.InvoiceNumber,
          inv.InvoiceSubTotal,
          inv.InvoiceDiscountTotal,
          inv.InvoiceNetTotal,
          inv.CustomerID_FK,
          inv.CashCustomerName,
          inv.SalePersonID_FK,
          inv.LocationID_FK,
          inv.CreatedByUserName,
          inv.Createddate,
          inv.PaymentCaption,
          inv.PaymentCount,
          inv.Cash,
          inv.[Change] as ChangeAmount,
          inv.TransactionBarcode,
          inv.Notes,
          inv.SalesInvoiceStateID_FK,
          inv.DocumentTypeID_FK
        FROM SALES.Data_SalesInvoices inv
        $whereClause
        ORDER BY inv.SalesInvoiceDate DESC
        OFFSET $offset ROWS FETCH NEXT $pageSize ROWS ONLY
      ''';
      
      print('=== استعلام البيانات ===');
      print('$dataQuery');
      print('======================');
      
      final data = await service.query(dataQuery);
      
      print('عدد الفواتير المسترجعة: ${data.length}');
      if (data.isNotEmpty) {
        print('أول فاتورة: ${data.first}');
        if (data.length > 1) {
          print('آخر فاتورة: ${data.last}');
        }
      }
      
      return {
        'data': data,
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': (totalCount / pageSize).ceil(),
      };
    } catch (e, stackTrace) {
      print('خطأ في getSales: $e');
      print('Stack trace: $stackTrace');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get sales statistics for a date range
  static Future<Map<String, dynamic>> getSalesStatistics({
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final service = DatabaseService();
    await service.connect();
    try {
      String? fromDateStr;
      String? toDateStr;
      
      if (fromDate != null) {
        fromDateStr = '${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}';
      }
      
      if (toDate != null) {
        toDateStr = '${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}';
      }
      
      final List<String> whereConditions = ['1=1'];
      
      if (fromDateStr != null) {
        whereConditions.add("CAST(inv.SalesInvoiceDate AS DATE) >= CAST('$fromDateStr' AS DATE)");
      }
      
      if (toDateStr != null) {
        whereConditions.add("CAST(inv.SalesInvoiceDate AS DATE) <= CAST('$toDateStr' AS DATE)");
      }
      
      final whereClause = 'WHERE ${whereConditions.join(' AND ')}';
      
      final statsQuery = '''
        SELECT 
          COUNT(*) as TotalInvoices,
          SUM(inv.InvoiceNetTotal) as TotalSales,
          SUM(inv.InvoiceDiscountTotal) as TotalDiscounts,
          AVG(inv.InvoiceNetTotal) as AverageInvoice,
          MIN(inv.InvoiceNetTotal) as MinInvoice,
          MAX(inv.InvoiceNetTotal) as MaxInvoice,
          SUM(inv.Cash) as TotalCash,
          SUM(inv.[Change]) as TotalChange
        FROM SALES.Data_SalesInvoices inv
        $whereClause
      ''';
      
      final statsResults = await service.query(statsQuery);
      
      if (statsResults.isEmpty) {
        return {
          'totalInvoices': 0,
          'totalSales': 0.0,
          'totalDiscounts': 0.0,
          'averageInvoice': 0.0,
          'minInvoice': 0.0,
          'maxInvoice': 0.0,
          'totalCash': 0.0,
          'totalChange': 0.0,
        };
      }
      
      final stats = statsResults.first;
      
      return {
        'totalInvoices': int.tryParse(stats['TotalInvoices']?.toString() ?? '0') ?? 0,
        'totalSales': double.tryParse(stats['TotalSales']?.toString() ?? '0') ?? 0.0,
        'totalDiscounts': double.tryParse(stats['TotalDiscounts']?.toString() ?? '0') ?? 0.0,
        'averageInvoice': double.tryParse(stats['AverageInvoice']?.toString() ?? '0') ?? 0.0,
        'minInvoice': double.tryParse(stats['MinInvoice']?.toString() ?? '0') ?? 0.0,
        'maxInvoice': double.tryParse(stats['MaxInvoice']?.toString() ?? '0') ?? 0.0,
        'totalCash': double.tryParse(stats['TotalCash']?.toString() ?? '0') ?? 0.0,
        'totalChange': double.tryParse(stats['TotalChange']?.toString() ?? '0') ?? 0.0,
      };
    } catch (e) {
      print('خطأ في getSalesStatistics: $e');
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get full product details by ID
  static Future<Map<String, dynamic>?> getProductDetails(int productId) async {
    final service = DatabaseService();
    await service.connect();
    try {
      final query = '''
        SELECT 
          p.*,
          pg.ProductGroupDescription as ProductGroupName,
          pt.ProductTypeDescrption as ProductTypeName,
          uom_sell.UOMName as SellUOMName,
          uom_order.UOMName as OrderUOMName,
          uom_inv.UOMName as InventoryUOMName,
          sup.SupplierName,
          (SELECT COUNT(*) FROM Inventory.Data_ProductUOMs WHERE ProductID_FK = p.ProductID_PK) as UOMCount,
          (SELECT SUM(StockOnHand) FROM Inventory.Data_ProductInventories WHERE ProductID_FK = p.ProductID_PK) as TotalInventoryStock
        FROM Inventory.Data_Products p
        LEFT JOIN Inventory.RefProductGroups pg ON p.ProductGroupID_FK = pg.ProductGroupID_PK
        LEFT JOIN Inventory.RefProductTypes pt ON p.ProductTypeID_FK = pt.ProductTypeID_PK
        LEFT JOIN Inventory.RefUOMs uom_sell ON p.DefaultSellUomID_FK = uom_sell.UOMID_PK
        LEFT JOIN Inventory.RefUOMs uom_order ON p.DefaultOrderUomID_FK = uom_order.UOMID_PK
        LEFT JOIN Inventory.RefUOMs uom_inv ON p.DefaultInventoryUomID_FK = uom_inv.UOMID_PK
        LEFT JOIN Purchase.Data_Suppliers sup ON p.MainSupplierID_FK = sup.SupplierID_PK
        WHERE p.ProductID_PK = $productId
      ''';
      
      final results = await service.query(query);
      
      if (results.isEmpty) {
        return null;
      }
      
      return results.first;
    } catch (e) {
      print('خطأ في getProductDetails: $e');
      rethrow;
    } finally {
      await service.close();
    }
  }


  static Future<List<Map<String, dynamic>>> executeQuery(String query) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      return await service.query(query);
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // User Management Functions
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT 
          UserID_PK,
          FullName,
          username,
          Password,
          Email,
          Phone,
          IsAproved,
          UserAddress,
          IsHasLimitedDataAccess,
          AdminPermissionCode,
          BranchID_FK
        FROM SysPermissions.Data_Users
        WHERE username IS NOT NULL AND Password IS NOT NULL
        ORDER BY FullName, UserID_PK
      ''';
      
      final results = await service.query(query);
      print('تم جلب ${results.length} مستخدم من قاعدة البيانات');
      return results;
    } catch (e) {
      print('خطأ في getAllUsers: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  static Future<Map<String, dynamic>?> authenticateUser(String username, String password) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      return null;
    }
    
    try {
      // Escape single quotes in username and password to prevent SQL injection
      final escapedUsername = username.replaceAll("'", "''");
      final escapedPassword = password.replaceAll("'", "''");
      
      final query = '''
        SELECT 
          UserID_PK,
          FullName,
          username,
          Password,
          Email,
          Phone,
          IsAproved,
          UserAddress,
          IsHasLimitedDataAccess,
          AdminPermissionCode,
          BranchID_FK
        FROM SysPermissions.Data_Users
        WHERE username = N'$escapedUsername' AND Password = N'$escapedPassword' AND (IsAproved = 1 OR IsAproved IS NULL)
      ''';
      
      final results = await service.query(query);
      if (results.isNotEmpty) {
        return results.first;
      }
      return null;
    } catch (e) {
      print('خطأ في authenticateUser: $e');
      await service.close();
      return null;
    } finally {
      await service.close();
    }
  }

  // Get default SalePersonID
  static Future<int> getDefaultSalePersonId() async {
    final service = DatabaseService();
    try {
      await service.connect();
      final query = '''
        SELECT TOP 1 SalePersonID_PK 
        FROM SALES.Config_SalePersons 
        WHERE Is_SalesPerson = 1
        ORDER BY SalePersonID_PK
      ''';
      final result = await service.query(query);
      if (result.isNotEmpty) {
        final id = result.first['SalePersonID_PK'];
        return id is int ? id : int.tryParse(id?.toString() ?? '1') ?? 1;
      }
      return 1; // Default fallback
    } catch (e) {
      print('خطأ في getDefaultSalePersonId: $e');
      return 1; // Default fallback
    } finally {
      await service.close();
    }
  }

  // Sales Invoice Functions
  static Future<int> createSalesInvoice({
    required dynamic branchId,
    required dynamic wsId,
    required dynamic customerId,
    required String cashCustomerName,
    required dynamic salePersonId,
    required dynamic documentTypeId,
    required dynamic salesInvoiceStateId,
    required String invoiceNumber,
    required dynamic invoiceSubTotal,
    required dynamic invoiceDiscountTotal,
    required dynamic invoiceNetTotal,
    required String notes,
    required dynamic paymentCount,
    required String paymentCaption,
    required dynamic cash,
    required dynamic change,
    required String transactionBarcode,
    required dynamic createdByUserId,
    required String createdByUserName,
    required dynamic customerPriceTypeId,
    required dynamic customerDiscountDefaultValue,
    required bool customerDiscountUsedAsPercentage,
    required dynamic locationId,
    required List<Map<String, dynamic>> items,
  }) async {
    // Convert all IDs to int
    final branchIdInt = branchId is int ? branchId : int.tryParse(branchId?.toString() ?? '1') ?? 1;
    final wsIdInt = wsId is int ? wsId : int.tryParse(wsId?.toString() ?? '1') ?? 1;
    // For cash customers, use -1 (as seen in existing invoices)
    // For regular customers, use the provided ID
    int customerIdInt;
    if (customerId == null || customerId == 0) {
      // Cash customer - verify if -1 is acceptable or get a valid default customer
      customerIdInt = -1;
    } else {
      customerIdInt = customerId is int ? customerId : int.tryParse(customerId?.toString() ?? '-1') ?? -1;
      // Verify the customer exists
      final serviceCheck = DatabaseService();
      try {
        await serviceCheck.connect();
        final verifyQuery = 'SELECT COUNT(*) as cnt FROM SALES.Data_Customers WHERE CustomerID_PK = $customerIdInt';
        final verifyResult = await serviceCheck.query(verifyQuery);
        final count = verifyResult.isNotEmpty ? (verifyResult.first['cnt'] is int ? verifyResult.first['cnt'] : int.tryParse(verifyResult.first['cnt']?.toString() ?? '0') ?? 0) : 0;
        if (count == 0) {
          // Customer doesn't exist, use -1 for cash customer
          customerIdInt = -1;
        }
        await serviceCheck.close();
      } catch (e) {
        print('خطأ في التحقق من CustomerID: $e');
        customerIdInt = -1; // Default to cash customer
      }
    }
    // Get valid SalePersonID - try to get from Config_SalePersons if provided ID is invalid
    int salePersonIdInt;
    if (salePersonId != null) {
      salePersonIdInt = salePersonId is int ? salePersonId : int.tryParse(salePersonId?.toString() ?? '0') ?? 0;
      // Verify the ID exists in Config_SalePersons
      final service = DatabaseService();
      try {
        await service.connect();
        final verifyQuery = 'SELECT COUNT(*) as cnt FROM SALES.Config_SalePersons WHERE SalePersonID_PK = $salePersonIdInt';
        final verifyResult = await service.query(verifyQuery);
        final count = verifyResult.isNotEmpty ? (verifyResult.first['cnt'] is int ? verifyResult.first['cnt'] : int.tryParse(verifyResult.first['cnt']?.toString() ?? '0') ?? 0) : 0;
        if (count == 0) {
          // ID doesn't exist, get default
          salePersonIdInt = await getDefaultSalePersonId();
        }
        await service.close();
      } catch (e) {
        print('خطأ في التحقق من SalePersonID: $e');
        salePersonIdInt = await getDefaultSalePersonId();
      }
    } else {
      salePersonIdInt = await getDefaultSalePersonId();
    }
    final documentTypeIdInt = documentTypeId is int ? documentTypeId : int.tryParse(documentTypeId?.toString() ?? '1') ?? 1;
    final salesInvoiceStateIdInt = salesInvoiceStateId is int ? salesInvoiceStateId : int.tryParse(salesInvoiceStateId?.toString() ?? '1') ?? 1;
    final paymentCountInt = paymentCount is int ? paymentCount : int.tryParse(paymentCount?.toString() ?? '1') ?? 1;
    final createdByUserIdInt = createdByUserId is int ? createdByUserId : int.tryParse(createdByUserId?.toString() ?? '1') ?? 1;
    final customerPriceTypeIdInt = customerPriceTypeId is int ? customerPriceTypeId : int.tryParse(customerPriceTypeId?.toString() ?? '1') ?? 1;
    final locationIdInt = locationId is int ? locationId : int.tryParse(locationId?.toString() ?? '1') ?? 1;
    
    // Convert amounts to double
    final invoiceSubTotalDouble = invoiceSubTotal is double ? invoiceSubTotal : double.tryParse(invoiceSubTotal?.toString() ?? '0') ?? 0.0;
    final invoiceDiscountTotalDouble = invoiceDiscountTotal is double ? invoiceDiscountTotal : double.tryParse(invoiceDiscountTotal?.toString() ?? '0') ?? 0.0;
    final invoiceNetTotalDouble = invoiceNetTotal is double ? invoiceNetTotal : double.tryParse(invoiceNetTotal?.toString() ?? '0') ?? 0.0;
    final cashDouble = cash is double ? cash : double.tryParse(cash?.toString() ?? '0') ?? 0.0;
    final changeDouble = change is double ? change : double.tryParse(change?.toString() ?? '0') ?? 0.0;
    final customerDiscountDefaultValueDouble = customerDiscountDefaultValue is double ? customerDiscountDefaultValue : double.tryParse(customerDiscountDefaultValue?.toString() ?? '0') ?? 0.0;
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      // Truncate strings to match database column sizes
      // Based on schema: CashCustomerName nvarchar(75), InvoiceNumber nvarchar(20), 
      // Notes nvarchar(500), PaymentCaption nvarchar(150), TransactionBarcode nvarchar(15),
      // CreatedByUserName nvarchar(50)
      final truncatedCashCustomerName = cashCustomerName.length > 75 
          ? cashCustomerName.substring(0, 75) 
          : cashCustomerName;
      final truncatedInvoiceNumber = invoiceNumber.length > 20 
          ? invoiceNumber.substring(0, 20) 
          : invoiceNumber;
      final truncatedNotes = notes.length > 500 
          ? notes.substring(0, 500) 
          : notes;
      final truncatedPaymentCaption = paymentCaption.length > 150 
          ? paymentCaption.substring(0, 150) 
          : paymentCaption;
      final truncatedTransactionBarcode = transactionBarcode.length > 15 
          ? transactionBarcode.substring(0, 15) 
          : transactionBarcode;
      final truncatedCreatedByUserName = createdByUserName.length > 50 
          ? createdByUserName.substring(0, 50) 
          : createdByUserName;
      
      // Insert invoice - using BRD schema
      // Based on actual database structure (DeliveryNotePrintCount doesn't exist in actual DB)
      // Use OUTPUT clause instead of SCOPE_IDENTITY() for better compatibility
      final invoiceQuery = '''
        INSERT INTO SALES.Data_SalesInvoices (
          BranchID_FK, WsID_FK, SalesInvoiceDate, CustomerID_FK, CashCustomerName,
          SalePersonID_FK, DocumentTypeID_FK, SalesInvoiceStateID_FK, InvoiceNumber,
          InvoiceSubTotal, InvoiceDiscountTotal, InvoiceNetTotal, Notes,
          PaymentCount, PaymentCaption, Cash, [Change], TransactionBarcode,
          CreatedByUserID, CreatedByUserName, Createddate, OrderNumber,
          CustomerPriceTypeID_FK, CustomerDiscountDefaultValue, CustomerDiscountUsedAsPersentage,
          LocationID_FK, IsSynced
        ) 
        OUTPUT INSERTED.SalesInvoiceID_PK AS InvoiceID
        VALUES (
          $branchIdInt, $wsIdInt, GETDATE(), $customerIdInt, N'${truncatedCashCustomerName.replaceAll("'", "''")}',
          $salePersonIdInt, $documentTypeIdInt, $salesInvoiceStateIdInt, N'${truncatedInvoiceNumber.replaceAll("'", "''")}',
          $invoiceSubTotalDouble, $invoiceDiscountTotalDouble, $invoiceNetTotalDouble, N'${truncatedNotes.replaceAll("'", "''")}',
          $paymentCountInt, N'${truncatedPaymentCaption.replaceAll("'", "''")}', $cashDouble, $changeDouble, N'${truncatedTransactionBarcode.replaceAll("'", "''")}',
          $createdByUserIdInt, N'${truncatedCreatedByUserName.replaceAll("'", "''")}', GETDATE(), 0,
          $customerPriceTypeIdInt, $customerDiscountDefaultValueDouble, ${customerDiscountUsedAsPercentage ? 1 : 0},
          $locationIdInt, 0
        )
      ''';
      
      print('تنفيذ استعلام إنشاء الفاتورة...');
      List<Map<String, dynamic>> invoiceResult;
      try {
        invoiceResult = await service.query(invoiceQuery);
        print('نتيجة الاستعلام: $invoiceResult');
      } catch (e) {
        print('خطأ في تنفيذ استعلام الفاتورة: $e');
        // Try with SCOPE_IDENTITY as fallback
        final fallbackQuery = '''
          INSERT INTO SALES.Data_SalesInvoices (
            BranchID_FK, WsID_FK, SalesInvoiceDate, CustomerID_FK, CashCustomerName,
            SalePersonID_FK, DocumentTypeID_FK, SalesInvoiceStateID_FK, InvoiceNumber,
            InvoiceSubTotal, InvoiceDiscountTotal, InvoiceNetTotal, Notes,
            PaymentCount, PaymentCaption, Cash, [Change], TransactionBarcode,
            CreatedByUserID, CreatedByUserName, Createddate, OrderNumber,
            CustomerPriceTypeID_FK, CustomerDiscountDefaultValue, CustomerDiscountUsedAsPersentage,
            LocationID_FK, IsSynced
        ) VALUES (
          $branchIdInt, $wsIdInt, GETDATE(), $customerIdInt, N'${truncatedCashCustomerName.replaceAll("'", "''")}',
          $salePersonIdInt, $documentTypeIdInt, $salesInvoiceStateIdInt, N'${truncatedInvoiceNumber.replaceAll("'", "''")}',
          $invoiceSubTotalDouble, $invoiceDiscountTotalDouble, $invoiceNetTotalDouble, N'${truncatedNotes.replaceAll("'", "''")}',
          $paymentCountInt, N'${truncatedPaymentCaption.replaceAll("'", "''")}', $cashDouble, $changeDouble, N'${truncatedTransactionBarcode.replaceAll("'", "''")}',
          $createdByUserIdInt, N'${truncatedCreatedByUserName.replaceAll("'", "''")}', GETDATE(), 0,
          $customerPriceTypeIdInt, $customerDiscountDefaultValueDouble, ${customerDiscountUsedAsPercentage ? 1 : 0},
          $locationIdInt, 0
        );
        SELECT SCOPE_IDENTITY() AS InvoiceID;
        ''';
        invoiceResult = await service.query(fallbackQuery);
        print('نتيجة الاستعلام (fallback): $invoiceResult');
      }
      
      if (invoiceResult.isEmpty) {
        print('خطأ: الاستعلام لم يرجع نتائج');
        throw Exception('فشل إنشاء الفاتورة: لم يتم إرجاع معرف الفاتورة');
      }
      
      final invoiceIdValue = invoiceResult.first['InvoiceID'] ?? 
                             invoiceResult.first['SalesInvoiceID_PK'] ??
                             invoiceResult.first.values.first;
      final invoiceId = invoiceIdValue is int 
          ? invoiceIdValue 
          : int.tryParse(invoiceIdValue?.toString() ?? '0') ?? 0;
      
      if (invoiceId == 0) {
        print('نتيجة الاستعلام الكاملة: $invoiceResult');
        throw Exception('فشل إنشاء الفاتورة: معرف الفاتورة غير صحيح');
      }
      
      print('تم إنشاء الفاتورة بنجاح برقم: $invoiceId');
      
      // Insert invoice items
      for (var item in items) {
        // Convert all values to proper types
        final productId = item['ProductID_PK'] is int 
            ? item['ProductID_PK'] 
            : int.tryParse(item['ProductID_PK']?.toString() ?? '0') ?? 0;
        final qty = item['quantity'] is double 
            ? item['quantity'] 
            : double.tryParse(item['quantity']?.toString() ?? '0') ?? 0.0;
        final unitCost = item['unitCost'] is double 
            ? item['unitCost'] 
            : double.tryParse(item['unitCost']?.toString() ?? '0') ?? 0.0;
        final unitPrice = item['unitPrice'] is double 
            ? item['unitPrice'] 
            : double.tryParse(item['unitPrice']?.toString() ?? '0') ?? 0.0;
        final subTotal = item['subTotal'] is double 
            ? item['subTotal'] 
            : double.tryParse(item['subTotal']?.toString() ?? '0') ?? 0.0;
        final discountPercentage = item['discountPercentage'] is double 
            ? item['discountPercentage'] 
            : double.tryParse(item['discountPercentage']?.toString() ?? '0') ?? 0.0;
        final discountAmount = item['discountAmount'] is double 
            ? item['discountAmount'] 
            : double.tryParse(item['discountAmount']?.toString() ?? '0') ?? 0.0;
        
        if (productId == 0) {
          print('تحذير: ProductID = 0 للعنصر: ${item}');
          continue; // Skip items with invalid product ID
        }
        
        // Get user ID and name for CreatedByUserID and CreatedByUserName
        final createdByUserIdInt = createdByUserId is int 
            ? createdByUserId 
            : int.tryParse(createdByUserId?.toString() ?? '0') ?? 0;
        final createdByUserNameStr = createdByUserName ?? '';
        final truncatedCreatedByUserNameForItem = createdByUserNameStr.length > 50 
            ? createdByUserNameStr.substring(0, 50) 
            : createdByUserNameStr;
        
        final itemQuery = '''
          INSERT INTO SALES.Data_SalesInvoiceItems (
            SalesInvoiceID_FK, ProductID_FK, QYT, UnitID_FK, UnitBaseQYT,
            UnitCost, UnitPrice, SubTotal, DiscountPersentage, DiscountAmount,
            IsQYTDelivered, TotalSalesPoints, CreatedByUserID, CreatedByUserName, Createddate
          ) VALUES (
            $invoiceId, $productId, $qty, 1, 1,
            $unitCost, $unitPrice, $subTotal,
            $discountPercentage, $discountAmount,
            1, 0, $createdByUserIdInt, N'${truncatedCreatedByUserNameForItem.replaceAll("'", "''")}', GETDATE()
          )
        ''';
        
        try {
          await service.query(itemQuery);
          print('تم إضافة عنصر الفاتورة: ProductID=$productId, QTY=$qty');
          
          // Update product stock
          try {
            await updateProductStock(productId, qty);
          } catch (stockError) {
            print('تحذير: فشل تحديث مخزون المنتج: $stockError');
            // Don't fail the whole transaction if stock update fails
          }
        } catch (e) {
          print('خطأ في إضافة عنصر الفاتورة: $e');
          rethrow;
        }
      }
      
      return invoiceId;
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Activity Log Functions
  static Future<void> logActivity({
    required dynamic userId,
    required String userName,
    required String action,
    required String details,
  }) async {
    // Convert userId to int if it's a string
    final userIdInt = userId is int 
        ? userId 
        : (userId is String 
            ? int.tryParse(userId) ?? 0 
            : 0);
    
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      return;
    }
    
    try {
      // Create activity log table if not exists
      final createTableQuery = '''
        IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
        CREATE TABLE [dbo].[ActivityLog] (
          LogID_PK bigint IDENTITY(1,1) PRIMARY KEY,
          UserID_FK int NOT NULL,
          UserName nvarchar(50) NOT NULL,
          Action nvarchar(100) NOT NULL,
          Details nvarchar(500) NULL,
          LogDate datetime DEFAULT GETDATE()
        )
      ''';
      await service.query(createTableQuery);
      
      // Insert log
      final logQuery = '''
        INSERT INTO dbo.ActivityLog (UserID_FK, UserName, Action, Details)
        VALUES ($userIdInt, N'$userName', N'$action', N'$details')
      ''';
      await service.query(logQuery);
    } catch (e) {
      // Ignore log errors
    } finally {
      await service.close();
    }
  }

  static Future<List<Map<String, dynamic>>> getActivityLogs({int limit = 100}) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT TOP $limit
          LogID_PK,
          UserID_FK,
          UserName,
          Action,
          Details,
          LogDate
        FROM dbo.ActivityLog
        ORDER BY LogDate DESC
      ''';
      
      return await service.query(query);
    } catch (e) {
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get invoice details with items and payments
  static Future<Map<String, dynamic>> getInvoiceDetails(dynamic invoiceId) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      // Convert invoiceId to int if it's a String
      final invoiceIdInt = invoiceId is int 
          ? invoiceId 
          : int.tryParse(invoiceId?.toString() ?? '0') ?? 0;
      
      if (invoiceIdInt == 0) {
        throw Exception('معرف الفاتورة غير صحيح');
      }
      
      // Get invoice
      final invoiceQuery = '''
        SELECT 
          inv.*,
          (SELECT COUNT(*) FROM SALES.Data_SalesInvoiceItems WHERE SalesInvoiceID_FK = inv.SalesInvoiceID_PK) as ItemsCount
        FROM SALES.Data_SalesInvoices inv
        WHERE inv.SalesInvoiceID_PK = $invoiceIdInt
      ''';
      
      final invoiceResults = await service.query(invoiceQuery);
      if (invoiceResults.isEmpty) {
        throw Exception('الفاتورة غير موجودة');
      }
      
      final invoice = invoiceResults.first;
      
      // Get invoice items
      final itemsQuery = '''
        SELECT 
          item.*,
          p.ProductName,
          p.ProductCode,
          uom.UOMName
        FROM SALES.Data_SalesInvoiceItems item
        INNER JOIN Inventory.Data_Products p ON item.ProductID_FK = p.ProductID_PK
        LEFT JOIN Inventory.RefUOMs uom ON item.UnitID_FK = uom.UOMID_PK
        WHERE item.SalesInvoiceID_FK = $invoiceIdInt
        ORDER BY item.SalesInvoiceItemID_PK
      ''';
      
      final items = await service.query(itemsQuery);
      
      // Get invoice payments
      final paymentsQuery = '''
        SELECT 
          pay.*,
          pm.PaymentMethodCaption
        FROM SALES.Data_SalesInvoicePayments pay
        LEFT JOIN MyCompany.RefPaymentMethods pm ON pay.PaymentMethodID_FK = pm.PaymentMethodID_PK
        WHERE pay.SalesInvoiceID_FK = $invoiceIdInt
        ORDER BY pay.SalesInvoicePaymentID_PK
      ''';
      
      final payments = await service.query(paymentsQuery);
      
      return {
        'invoice': invoice,
        'items': items,
        'payments': payments,
      };
    } catch (e) {
      print('خطأ في جلب تفاصيل الفاتورة: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get payment methods
  static Future<List<Map<String, dynamic>>> getPaymentMethods({bool forSales = true}) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final query = '''
        SELECT 
          pm.PaymentMethodID_PK,
          pm.PaymentMethodCaption,
          pm.PaymentMethodTypeID_FK,
          pm.CurrencyID_FK,
          pm.IsEnabledOnSalesDocuments,
          pm.IsActive,
          pmt.PaymentMethodTypeCaption,
          c.CurrencyName,
          c.CurrencySymbol,
          c.CurrencyRate,
          c.CurrencyScale
        FROM MyCompany.RefPaymentMethods pm
        INNER JOIN MyCompany.RefPaymentMethodTypes pmt ON pm.PaymentMethodTypeID_FK = pmt.PaymentMethodTypeID_PK
        INNER JOIN MyCompany.RefCurrencies c ON pm.CurrencyID_FK = c.CurrencyID_PK
        WHERE pm.IsActive = 1
          ${forSales ? "AND pm.IsEnabledOnSalesDocuments = 1" : ""}
        ORDER BY pm.PaymentMethodCaption
      ''';
      
      print('استعلام طرق الدفع: $query');
      final results = await service.query(query);
      print('تم جلب ${results.length} طريقة دفع');
      if (results.isNotEmpty) {
        print('أول طريقة دفع: ${results.first}');
      }
      return results;
    } catch (e) {
      print('خطأ في جلب طرق الدفع: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get customers
  static Future<List<Map<String, dynamic>>> getCustomers({String? search, int limit = 100}) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      var whereClause = "WHERE c.IsActiveAccount = 1";
      if (search != null && search.isNotEmpty) {
        final escapedSearch = search.replaceAll("'", "''");
        whereClause += " AND (c.CustomerName LIKE N'%$escapedSearch%' OR c.CustomerPhone LIKE N'%$escapedSearch%' OR c.MemberShipCode LIKE N'%$escapedSearch%')";
      }
      
      final query = '''
        SELECT TOP $limit
          c.CustomerID_PK,
          c.CustomerName,
          c.CustomerPhone,
          c.CustomerMobilePhone,
          c.CustomerAddressLine1,
          c.CustomerAddressLine2,
          c.CustomerAddressLine3,
          c.MemberShipCode,
          c.CustomerPriceTypeID_FK,
          c.CustomerPricePercentage,
          c.CustomerCreditLimitValue,
          c.CustomerOutstanding,
          c.CustomerPoints,
          cpt.CustomerPriceTypeCaption
        FROM SALES.Data_Customers c
        LEFT JOIN SALES.RefCustomerPriceTypes cpt ON c.CustomerPriceTypeID_FK = cpt.CustomerPriceTypeID_PK
        $whereClause
        ORDER BY c.CustomerName
      ''';
      
      return await service.query(query);
    } catch (e) {
      print('خطأ في جلب العملاء: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Add payment to invoice
  static Future<void> addInvoicePayment({
    required int invoiceId,
    required int paymentMethodId,
    required double paymentAmount,
    required double currencyRate,
    required double locCurrencyAmount,
    String? paymentNote,
    int? createdByUserId,
    String? createdByUserName,
  }) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      final note = paymentNote != null && paymentNote.isNotEmpty
          ? "N'${paymentNote.replaceAll("'", "''")}'"
          : 'NULL';
      
      // Include CreatedByUserID if provided (some database versions require it)
      final createdByUserIdInt = createdByUserId ?? 1;
      final createdByUserNameStr = createdByUserName ?? 'System';
      final truncatedCreatedByUserName = createdByUserNameStr.length > 50 
          ? createdByUserNameStr.substring(0, 50) 
          : createdByUserNameStr;
      
      // Try with CreatedByUserID first
      String query = '''
        INSERT INTO SALES.Data_SalesInvoicePayments (
          SalesInvoiceID_FK,
          PaymentMethodID_FK,
          CurrencyXchangeRate,
          PaymentAmount,
          LocCurrencyPaymentAmount,
          PaymentNote,
          CreatedByUserID,
          CreatedByUserName,
          Createddate
        ) VALUES (
          $invoiceId,
          $paymentMethodId,
          $currencyRate,
          $paymentAmount,
          $locCurrencyAmount,
          $note,
          $createdByUserIdInt,
          N'${truncatedCreatedByUserName.replaceAll("'", "''")}',
          GETDATE()
        )
      ''';
      
      try {
        await service.query(query);
      } catch (e) {
        // If CreatedByUserID columns don't exist, try without them
        print('محاولة بدون CreatedByUserID: $e');
        query = '''
          INSERT INTO SALES.Data_SalesInvoicePayments (
            SalesInvoiceID_FK,
            PaymentMethodID_FK,
            CurrencyXchangeRate,
            PaymentAmount,
            LocCurrencyPaymentAmount,
            PaymentNote
          ) VALUES (
            $invoiceId,
            $paymentMethodId,
            $currencyRate,
            $paymentAmount,
            $locCurrencyAmount,
            $note
          )
        ''';
        await service.query(query);
      }
      print('تم إضافة المدفوعات للفاتورة: InvoiceID=$invoiceId, PaymentMethodID=$paymentMethodId, Amount=$locCurrencyAmount');
    } catch (e) {
      print('خطأ في إضافة المدفوعات: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get stock transfer details with products
  static Future<Map<String, dynamic>> getStockTransferDetails(int transferId) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      // Get transfer
      final transferQuery = '''
        SELECT *
        FROM BRD.Data_StockTransfers
        WHERE StockTransferID_PK = $transferId
      ''';
      
      final transferResults = await service.query(transferQuery);
      if (transferResults.isEmpty) {
        throw Exception('النقلة غير موجودة');
      }
      
      final transfer = transferResults.first;
      
      // Get transfer products
      final productsQuery = '''
        SELECT 
          tp.*,
          p.ProductName,
          p.ProductCode,
          uom.UOMName
        FROM BRD.Data_StockTransferProducts tp
        INNER JOIN Inventory.Data_Products p ON tp.ProductID_FK = p.ProductID_PK
        LEFT JOIN Inventory.RefUOMs uom ON tp.UnitID_FK = uom.UOMID_PK
        WHERE tp.StockTransferID_FK = $transferId
        ORDER BY tp.StockTransferProductID_PK
      ''';
      
      final products = await service.query(productsQuery);
      
      return {
        'transfer': transfer,
        'products': products,
      };
    } catch (e) {
      print('خطأ في جلب تفاصيل النقلة: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }

  // Get User Session Actions from SysPermissions.Data_UserSessionActions
  static Future<List<Map<String, dynamic>>> getUserSessionActions({
    DateTime? date,
    int? userId,
    int limit = 100,
  }) async {
    final service = DatabaseService();
    final connected = await service.connect();
    if (!connected) {
      await service.close();
      throw Exception('فشل الاتصال بقاعدة البيانات');
    }
    
    try {
      var whereConditions = <String>[];
      
      if (date != null) {
        final dateStr = date.toIso8601String().split('T')[0];
        whereConditions.add("CAST(usa.UserSessionActionDate AS DATE) = '$dateStr'");
      }
      
      if (userId != null) {
        whereConditions.add("us.UserID_FK = $userId");
      }
      
      final whereClause = whereConditions.isNotEmpty 
          ? 'WHERE ${whereConditions.join(' AND ')}'
          : '';
      
      final query = '''
        SELECT TOP $limit
          usa.UserSessionActionID_PK,
          usa.UserSessionActionDate,
          usa.SessionID_FK,
          usa.SubActionID_FK,
          usa.SubActionType,
          usa.ActionDescription,
          usa.ActionProductID_FK,
          usa.ActionProductName,
          usa.ActionOldValue,
          usa.ActionNewValue,
          usa.ActionValueType,
          us.UserID_FK,
          us.LoginPC,
          us.LoginModule,
          us.SessionLoginTime,
          us.SessionLogOutTime,
          u.username as UserName,
          u.FullName as UserFullName
        FROM SysPermissions.Data_UserSessionActions usa
        INNER JOIN SysPermissions.Data_UserSessions us ON usa.SessionID_FK = us.SessionID_PK
        LEFT JOIN SysPermissions.Data_Users u ON us.UserID_FK = u.UserID_PK
        $whereClause
        ORDER BY usa.UserSessionActionDate DESC
      ''';
      
      return await service.query(query);
    } catch (e) {
      print('خطأ في جلب سجل العمليات: $e');
      await service.close();
      rethrow;
    } finally {
      await service.close();
    }
  }
}
