using System.Data.SqlClient;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// إضافة CORS
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

app.UseCors();

// سلسلة الاتصال
string connectionString = "Server=localhost;Database=InfinityRetailDB;User Id=sa;Password=123;TrustServerCertificate=True;";

// اختبار الاتصال
app.MapGet("/api/test", async () =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        return Results.Ok(new { connected = true, message = "متصل بنجاح" });
    }
    catch (Exception ex)
    {
        return Results.Ok(new { connected = false, error = ex.Message });
    }
});

// الحصول على الجداول حسب Schema
app.MapGet("/api/tables", async () =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        var cmd = new SqlCommand(@"
            SELECT TABLE_SCHEMA, TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_TYPE = 'BASE TABLE'
            ORDER BY TABLE_SCHEMA, TABLE_NAME", conn);
        
        var reader = await cmd.ExecuteReaderAsync();
        var result = new Dictionary<string, List<string>>();
        
        while (await reader.ReadAsync())
        {
            var schema = reader["TABLE_SCHEMA"].ToString() ?? "";
            var table = reader["TABLE_NAME"].ToString() ?? "";
            if (!result.ContainsKey(schema))
                result[schema] = new List<string>();
            result[schema].Add(table);
        }
        
        return Results.Ok(result);
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// الحصول على أعمدة الجدول
app.MapGet("/api/columns/{schema}/{table}", async (string schema, string table) =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        var cmd = new SqlCommand(@"
            SELECT COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = @schema AND TABLE_NAME = @table
            ORDER BY ORDINAL_POSITION", conn);
        cmd.Parameters.AddWithValue("@schema", schema);
        cmd.Parameters.AddWithValue("@table", table);
        
        var reader = await cmd.ExecuteReaderAsync();
        var columns = new List<string>();
        while (await reader.ReadAsync())
        {
            columns.Add(reader["COLUMN_NAME"].ToString() ?? "");
        }
        return Results.Ok(columns);
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// الحصول على بيانات الجدول
app.MapGet("/api/data/{schema}/{table}", async (string schema, string table, int? limit) =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        var limitValue = limit ?? 100;
        var cmd = new SqlCommand($"SELECT TOP {limitValue} * FROM [{schema}].[{table}]", conn);
        
        var reader = await cmd.ExecuteReaderAsync();
        var result = new List<Dictionary<string, object?>>();
        
        while (await reader.ReadAsync())
        {
            var row = new Dictionary<string, object?>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
                var columnName = reader.GetName(i);
                row[columnName] = reader.IsDBNull(i) ? null : reader.GetValue(i);
            }
            result.Add(row);
        }
        
        return Results.Ok(result);
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// الحصول على عدد الصفوف
app.MapGet("/api/count/{schema}/{table}", async (string schema, string table) =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        var cmd = new SqlCommand($"SELECT COUNT(*) as count FROM [{schema}].[{table}]", conn);
        var count = await cmd.ExecuteScalarAsync();
        return Results.Ok(new { count = Convert.ToInt32(count) });
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// الحصول على المبيعات مع pagination
app.MapGet("/api/sales", async (int? page, int? pageSize, string? search, DateTime? fromDate, DateTime? toDate) =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        
        var pageNum = page ?? 1;
        var size = pageSize ?? 50;
        var offset = (pageNum - 1) * size;
        
        var whereClause = "WHERE 1=1";
        if (!string.IsNullOrEmpty(search))
        {
            whereClause += $" AND (si.InvoiceNumber LIKE '%{search.Replace("'", "''")}%' OR si.CashCustomerName LIKE '%{search.Replace("'", "''")}%')";
        }
        if (fromDate.HasValue)
        {
            whereClause += $" AND si.SalesInvoiceDate >= '{fromDate.Value:yyyy-MM-dd}'";
        }
        if (toDate.HasValue)
        {
            whereClause += $" AND si.SalesInvoiceDate <= '{toDate.Value:yyyy-MM-dd}'";
        }
        
        // الحصول على العدد الإجمالي
        var countCmd = new SqlCommand($"SELECT COUNT(*) FROM BRD.Data_SalesInvoices si {whereClause}", conn);
        var totalCount = Convert.ToInt32(await countCmd.ExecuteScalarAsync());
        
        var query = $@"
            SELECT 
                si.SalesInvoiceID_PK,
                si.SalesInvoiceDate,
                si.InvoiceNumber,
                si.InvoiceSubTotal,
                si.InvoiceDiscountTotal,
                si.InvoiceNetTotal,
                si.CustomerID_FK,
                si.CashCustomerName,
                si.SalePersonID_FK,
                si.LocationID_FK
            FROM BRD.Data_SalesInvoices si
            {whereClause}
            ORDER BY si.SalesInvoiceDate DESC
            OFFSET {offset} ROWS FETCH NEXT {size} ROWS ONLY";
        
        var cmd = new SqlCommand(query, conn);
        var reader = await cmd.ExecuteReaderAsync();
        var result = new List<Dictionary<string, object?>>();
        
        while (await reader.ReadAsync())
        {
            var row = new Dictionary<string, object?>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
                var columnName = reader.GetName(i);
                row[columnName] = reader.IsDBNull(i) ? null : reader.GetValue(i);
            }
            result.Add(row);
        }
        
        return Results.Ok(new
        {
            data = result,
            totalCount = totalCount,
            page = pageNum,
            pageSize = size,
            totalPages = (int)Math.Ceiling(totalCount / (double)size)
        });
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// الحصول على حركات المخزون مع pagination
app.MapGet("/api/movements", async (int? page, int? pageSize, string? search, DateTime? fromDate, DateTime? toDate) =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        
        var pageNum = page ?? 1;
        var size = pageSize ?? 50;
        var offset = (pageNum - 1) * size;
        
        var whereClause = "WHERE 1=1";
        if (!string.IsNullOrEmpty(search))
        {
            whereClause += $" AND (st.StockTransferNumber LIKE '%{search.Replace("'", "''")}%' OR st.StockTransferNote LIKE '%{search.Replace("'", "''")}%')";
        }
        if (fromDate.HasValue)
        {
            whereClause += $" AND st.DocumentDate >= '{fromDate.Value:yyyy-MM-dd}'";
        }
        if (toDate.HasValue)
        {
            whereClause += $" AND st.DocumentDate <= '{toDate.Value:yyyy-MM-dd}'";
        }
        
        // الحصول على العدد الإجمالي
        var countCmd = new SqlCommand($"SELECT COUNT(*) FROM BRD.Data_StockTransfers st {whereClause}", conn);
        var totalCount = Convert.ToInt32(await countCmd.ExecuteScalarAsync());
        
        var query = $@"
            SELECT 
                st.StockTransferID_PK,
                st.StockTransferNumber,
                st.DocumentDate,
                st.FromBranchID_FK,
                st.FromLocationID_FK,
                st.ToBranchID_FK,
                st.ToLocationID_FK,
                st.DocumentTypeID_FK,
                st.StockTransferStateID_FK,
                st.StockTransferNote
            FROM BRD.Data_StockTransfers st
            {whereClause}
            ORDER BY st.DocumentDate DESC
            OFFSET {offset} ROWS FETCH NEXT {size} ROWS ONLY";
        
        var cmd = new SqlCommand(query, conn);
        var reader = await cmd.ExecuteReaderAsync();
        var result = new List<Dictionary<string, object?>>();
        
        while (await reader.ReadAsync())
        {
            var row = new Dictionary<string, object?>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
                var columnName = reader.GetName(i);
                row[columnName] = reader.IsDBNull(i) ? null : reader.GetValue(i);
            }
            result.Add(row);
        }
        
        return Results.Ok(new
        {
            data = result,
            totalCount = totalCount,
            page = pageNum,
            pageSize = size,
            totalPages = (int)Math.Ceiling(totalCount / (double)size)
        });
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// الحصول على المنتجات مع pagination وsearch
app.MapGet("/api/products", async (int? page, int? pageSize, string? search, string? sortBy, string? sortOrder) =>
{
    try
    {
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        
        var pageNum = page ?? 1;
        var size = pageSize ?? 50;
        var offset = (pageNum - 1) * size;
        
        // بناء استعلام البحث
        var whereClause = "WHERE 1=1";
        if (!string.IsNullOrEmpty(search))
        {
            whereClause += $" AND (ProductName LIKE '%{search.Replace("'", "''")}%' OR ProductCode LIKE '%{search.Replace("'", "''")}%')";
        }
        
        // بناء ORDER BY
        var orderBy = "ORDER BY ProductID_PK DESC";
        if (!string.IsNullOrEmpty(sortBy))
        {
            var order = sortOrder?.ToUpper() == "ASC" ? "ASC" : "DESC";
            orderBy = $"ORDER BY {sortBy} {order}";
        }
        
        // الحصول على العدد الإجمالي
        var countCmd = new SqlCommand($"SELECT COUNT(*) FROM Inventory.Data_Products {whereClause}", conn);
        var totalCount = Convert.ToInt32(await countCmd.ExecuteScalarAsync());
        
        // الحصول على البيانات
        var query = $@"
            SELECT 
                ProductID_PK,
                ProductCode,
                ProductName,
                ProductShortName,
                StockOnHand,
                StockOnHold,
                MinStockLevel,
                MaxStockLevel,
                IsInActive,
                TotalSoldQYT,
                LastSalesTransactionDate
            FROM Inventory.Data_Products
            {whereClause}
            {orderBy}
            OFFSET {offset} ROWS FETCH NEXT {size} ROWS ONLY";
        
        var cmd = new SqlCommand(query, conn);
        var reader = await cmd.ExecuteReaderAsync();
        var result = new List<Dictionary<string, object?>>();
        
        while (await reader.ReadAsync())
        {
            var row = new Dictionary<string, object?>();
            for (int i = 0; i < reader.FieldCount; i++)
            {
                var columnName = reader.GetName(i);
                row[columnName] = reader.IsDBNull(i) ? null : reader.GetValue(i);
            }
            result.Add(row);
        }
        
        return Results.Ok(new
        {
            data = result,
            totalCount = totalCount,
            page = pageNum,
            pageSize = size,
            totalPages = (int)Math.Ceiling(totalCount / (double)size)
        });
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

// تنفيذ استعلام SQL مخصص
app.MapPost("/api/query", async (HttpRequest request) =>
{
    try
    {
        using var reader = new StreamReader(request.Body);
        var body = await reader.ReadToEndAsync();
        var json = JsonSerializer.Deserialize<JsonElement>(body);
        var query = json.GetProperty("query").GetString();
        
        if (string.IsNullOrEmpty(query))
        {
            return Results.BadRequest(new { error = "الاستعلام مطلوب" });
        }
        
        using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        var cmd = new SqlCommand(query, conn);
        
        var sqlReader = await cmd.ExecuteReaderAsync();
        var result = new List<Dictionary<string, object?>>();
        
        while (await sqlReader.ReadAsync())
        {
            var row = new Dictionary<string, object?>();
            for (int i = 0; i < sqlReader.FieldCount; i++)
            {
                var columnName = sqlReader.GetName(i);
                row[columnName] = sqlReader.IsDBNull(i) ? null : sqlReader.GetValue(i);
            }
            result.Add(row);
        }
        
        return Results.Ok(result);
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { error = ex.Message });
    }
});

app.Run("http://localhost:5000");

