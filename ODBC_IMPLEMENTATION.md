# ODBC Database Service Implementation Guide

## 1. Add Dependency

Run this command in your project root:

```bash
flutter pub add odbc
```

Or manually add to `pubspec.yaml`:

```yaml
dependencies:
  odbc: ^2.0.0
```

Then run:
```bash
flutter pub get
```

## 2. DatabaseService Implementation

The `DatabaseService` class has been created in `lib/database_service_odbc.dart`.

### Key Features:
- ✅ Direct ODBC connection to SQL Server
- ✅ Connection string format: `Driver={SQL Server};Server=...;Database=...;Uid=...;Pwd=...;`
- ✅ `connect()` method for establishing connection
- ✅ `query(String sql)` method that returns `List<Map<String, dynamic>>`
- ✅ Proper data type mapping (handles DateTime, numbers, strings, nulls)
- ✅ `close()` method to free resources
- ✅ `execute()` method for INSERT/UPDATE/DELETE operations
- ✅ `testConnection()` method for health checks

## 3. Usage Example

See `example_usage.dart` for a complete working example.

### Basic Usage:

```dart
import 'database_service_odbc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create service instance
  final dbService = DatabaseService();
  
  // Connect to database
  final connected = await dbService.connect();
  if (!connected) {
    print('Failed to connect');
    return;
  }
  
  // Execute query
  try {
    final results = await dbService.query('''
      SELECT TOP 10 
        ProductID_PK,
        ProductCode,
        ProductName,
        StockOnHand
      FROM Inventory.Data_Products
    ''');
    
    // Use results (List<Map<String, dynamic>>)
    for (var row in results) {
      print('Product: ${row['ProductName']}');
      print('Code: ${row['ProductCode']}');
      print('Stock: ${row['StockOnHand']}');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    // Always close connection
    await dbService.close();
  }
}
```

## 4. Important Notes

### Connection String Format
The connection string uses Windows ODBC format:
```
Driver={SQL Server};Server=localhost;Database=InfinityRetailDB;Uid=sa;Pwd=123;
```

### Data Type Mapping
The service automatically handles:
- `null` values → `null` in Dart
- `DateTime` → ISO8601 string
- `num` (int/double) → preserved as-is
- Other types → converted to string

### Error Handling
Always wrap database calls in try-catch blocks:
```dart
try {
  final results = await dbService.query('SELECT * FROM Table');
} catch (e) {
  // Handle error
  print('Database error: $e');
}
```

### Resource Management
Always call `close()` when done:
```dart
@override
void dispose() {
  dbService.close();
  super.dispose();
}
```

## 5. Alternative: If `odbc` Package Doesn't Exist

If the `odbc` package is not available on pub.dev, you have these options:

1. **Use `ffi` package directly** - More complex but gives full control
2. **Use `mssql_connection`** - If it works on Windows (may need FreeTDS)
3. **Keep using the API server approach** - Most reliable for production

## 6. Testing

Test your connection:
```dart
final dbService = DatabaseService();
final isConnected = await dbService.testConnection();
print('Connected: $isConnected');
```


