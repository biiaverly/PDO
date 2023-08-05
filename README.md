# $${\color{black}\text{\ PHP DATA OBJECTS}}$$

# <span style="color:black; font-size:40px;">1. Introduction</span> 
<details>

# 1.1 Introduction to PHP Data Objects (PDO)

The PHP Data Objects (PDO) extension introduces a lightweight and consistent interface for database access within PHP applications. Each database driver that implements the PDO interface can provide database-specific functionalities through standard extension functions. It's important to note that PDO itself doesn't directly execute database operations; instead, you need to employ a database-specific PDO driver to establish connections and perform actions on a database server.

PDO serves as a layer for data access, ensuring that no matter which database system you're utilizing, you utilize the same set of functions for querying data. However, it's essential to understand that PDO doesn't serve as a complete database abstraction solution; it doesn't modify SQL queries or replicate missing features. 

It's worth mentioning that PDO is included as a part of PHP, making it conveniently available for use.

> **Note:** PDO (PHP Data Objects) is a PHP extension providing a uniform interface for interacting with databases, enabling consistent database operations regardless of the underlying database system.
# 1.2 Installation
## Linux

To utilize PDO (PHP Data Objects) on a Linux system, follow these steps:

**Install PHP**: Ensure PHP is installed on your Linux machine. Use the following command:

```bash
# Install PHP
sudo apt-get update
sudo apt-get install php

# Install PDO for MySQL
sudo apt-get install php-mysql

# Install PDO for PostgreSQL
sudo apt-get install php-pgsql

# Install PDO for SQLite
sudo apt-get install php-sqlite3

# Restart Apache or your web server
sudo service apache2 restart
```
## Using github repository

</details>


# <span style="color:black; font-size:40px;">2. Predefined Constants</span> 

## 2.1. PDO Predefined Constants
<details>

PHP Data Objects (PDO) comes with several predefined constants that can be useful when working with databases. Here are some of the key constants:

- `PDO::FETCH_ASSOC`: Fetches the result as an associative array.
- `PDO::FETCH_OBJ`: Fetches the result as an object with property names that correspond to the column names.
- `PDO::ATTR_ERRMODE`: Sets the error handling mode. For example, `PDO::ERRMODE_EXCEPTION` throws exceptions for errors.
- `PDO::ATTR_DEFAULT_FETCH_MODE`: Sets the default fetch mode for result sets.
- `PDO::PARAM_STR`: Represents a string data type parameter.
- `PDO::PARAM_INT`: Represents an integer data type parameter.
- `PDO::PARAM_BOOL`: Represents a boolean data type parameter.
- `PDO::PARAM_NULL`: Represents a NULL data type parameter.
- `PDO::PARAM_STMT`: Represents a statement data type parameter.
- `PDO::PARAM_LOB`: Represents a large object data type parameter.

These constants are used with methods like `PDOStatement::fetch()`, `PDO::setAttribute()`, and more to customize the behavior of PDO when interacting with databases.

For a full list of constants and their descriptions, refer to the official PHP documentation: [PDO Predefined Constants](https://www.php.net/manual/en/pdo.constants.php).

</details>


## 2.2 Connections and Connection Management in PDO
<details>

PHP Data Objects (PDO) offers a straightforward way to establish and manage connections to databases. Here's how you can work with connections using PDO:

- **Establishing a Connection**:

    To connect to a database, you use the `PDO` class constructor and provide the Data Source Name (DSN), username, and password. For example:

    ```php
    <?php
    $dsn = "mysql:host=localhost;dbname=mydatabase";
    $username = "your_username";
    $password = "your_password";

    try {
        $pdo = new PDO($dsn, $username, $password);
        echo "Connected successfully!";
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }
    ?>
    ```

- **Closing a Connection:**:
PDO connections are automatically closed when the script ends or when the $pdo variable is no longer in scope. However, you can explicitly close the connection using:

```php
$pdo = null; // Closes the connection
```

- **Persistent Connections:**:
PDO supports persistent connections using the PDO::ATTR_PERSISTENT attribute. These connections remain open between requests, potentially improving performance. For example:

```php
$options = [PDO::ATTR_PERSISTENT => true];
$pdo = new PDO($dsn, $username, $password, $options);
```

- **Connection Status:**:
You can check the connection status using the PDO::getAttribute() method with the PDO::ATTR_CONNECTION_STATUS attribute. For example:

```php
$status = $pdo->getAttribute(PDO::ATTR_CONNECTION_STATUS);
echo "Connection status: $status";
```
</details>

## 2.3 Transactions and Auto-Commit in PDO
<details>

Transactions are essential for maintaining data integrity when performing multiple database operations. PHP Data Objects (PDO) provides support for transactions and gives you control over the auto-commit behavior. Here's how you can work with transactions and auto-commit in PDO:

### Starting a Transaction

To begin a transaction, you use the `beginTransaction()` method on the PDO object:

```php
$pdo->beginTransaction();
``` 

### Committing a Transaction

After executing a series of operations, you can commit the changes to the database using the `commit()` method:

```php
$pdo->commit();
```

### Rolling Back a Transaction

If an error occurs or you need to undo changes, you can roll back the transaction using the `rollBack()` method:

```php
$pdo->rollBack();
```

#### Auto-Commit

By default, PDO operates in auto-commit mode, where each SQL statement is automatically committed as soon as it's executed. To disable auto-commit and manage transactions manually, you can use:

```php
$pdo->setAttribute(PDO::ATTR_AUTOCOMMIT, 0);
```
Then, you control when to commit or roll back changes explicitly.These features are crucial for maintaining data consistency and handling complex database operations. Proper use of transactions ensures that a series of operations either complete successfully or leave the database in its initial state.
</details>

## 2.4 Prepared Statements and Stored Procedures in PDO
<details>

Prepared statements and stored procedures are powerful features of PHP Data Objects (PDO) that enhance security and efficiency in database operations. 

### Prepared Statements

Prepared statements offer protection against SQL injection by separating SQL code from user input. Here's an example of using prepared statements to execute a parameterized query:

```php
$sql = "SELECT * FROM users WHERE username = :username";
$stmt = $pdo->prepare($sql);
$stmt->bindParam(':username', $username);
$stmt->execute();
$result = $stmt->fetchAll();
```

#### Named Placeholders

PDO supports named placeholders for prepared statements, allowing you to bind parameters using associative arrays:

```php
$sql = "INSERT INTO products (name, price) VALUES (:name, :price)";
$stmt = $pdo->prepare($sql);
$params = [':name' => 'Product Name', ':price' => 19.99];
$stmt->execute($params);
```

#### Stored Procedures

Stored procedures are precompiled SQL statements that can be executed multiple times. PDO enables you to call stored procedures using the `CALL` statement:

```php
$procedure = "CALL sp_get_user(:user_id)";
$stmt = $pdo->prepare($procedure);
$stmt->bindParam(':user_id', $userId, PDO::PARAM_INT);
$stmt->execute();
$result = $stmt->fetchAll();
```
</details>

## 2.5 Errors and Error Handling in PDO
<details>

Errors and error handling are crucial aspects of database interactions. PHP Data Objects (PDO) provides mechanisms for managing errors and exceptions during database operations. 

### Error Handling

PDO can be set to throw exceptions on error, making it easier to handle errors in a consistent way:

```php
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
```

### Catching Exceptions

When exceptions are thrown, you can catch them and handle errors gracefully:

```php
try {
    // PDO operations here
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
```

### Error Codes

PDO exceptions provide detailed error information, including error codes:

```php
try {
    // PDO operations here
} catch (PDOException $e) {
    echo "Error Code: " . $e->getCode();
    echo "Error Message: " . $e->getMessage();
}
```


### Custom Error Messages

You can customize error messages to provide more context:

```php
try {
    // PDO operations here
} catch (PDOException $e) {
    echo "An error occurred: " . $e->getMessage();
}
```

#### Error Information

PDO provides methods to access additional error information:

```php
try {
    // PDO operations here
} catch (PDOException $e) {
    echo "Error Info: ";
    print_r($e->errorInfo());
}
```

Handling errors effectively helps in diagnosing issues and maintaining the reliability of your database interactions.
</details>

## 2.6 Large Objects (LOBs) in PDO
<details>

Large Objects (LOBs) are data types used to store large amounts of binary or text data, such as images, audio, and documents. PHP Data Objects (PDO) provides support for working with LOBs in your database operations. 

### Inserting and Retrieving LOBs

You can insert LOBs into the database and retrieve them using prepared statements:

```php
$sql = "INSERT INTO files (filename, content) VALUES (?, ?)";
$stmt = $pdo->prepare($sql);
$fileContent = file_get_contents('file.jpg');
$stmt->bindParam(1, 'file.jpg');
$stmt->bindParam(2, $fileContent, PDO::PARAM_LOB);
$stmt->execute();

// Retrieving LOB
$sql = "SELECT content FROM files WHERE filename = ?";
$stmt = $pdo->prepare($sql);
$stmt->bindParam(1, 'file.jpg');
$stmt->execute();
$result = $stmt->fetch();
$imageContent = $result['content'];
```
### Streaming LOBs

PDO allows you to stream LOB data, which is useful for working with large files without loading them entirely into memory:

```php
$stream = fopen('large_file.pdf', 'rb');
$stmt = $pdo->prepare("INSERT INTO documents (name, content) VALUES (?, ?)");
$stmt->bindParam(1, 'document.pdf');
$stmt->bindParam(2, $stream, PDO::PARAM_LOB);
$stmt->execute();
fclose($stream);
```

Using LOBs allows you to work with large data efficiently while benefiting from PDO's features and security.
</details>

# 3. PDO CLASS

## 3.1. Connection Management
<details>

### PDO::__construct

The `__construct` method in PDO is used to create an instance of the PDO class, representing a connection to a database. You provide the Data Source Name (DSN), username, and password as parameters to establish the connection. Here's how you can use `__construct`:

```php
$dsn = "mysql:host=localhost;dbname=mydatabase";
$username = "your_username";
$password = "your_password";
$pdo = new PDO($dsn, $username, $password);
```
When you call the constructor with the appropriate DSN and credentials, PDO establishes a connection to the specified database. The DSN contains information about the database driver, host, port, and database name.
### PDO::getAttribute

The `getAttribute` method in PDO allows you to retrieve the value of a specific database connection attribute. Database connection attributes provide information about the current state and settings of the PDO connection. Here's how you can use `getAttribute`:

```php
$attributeValue = $pdo->getAttribute(PDO::ATTR_AUTOCOMMIT);
```
The getAttribute method takes a single parameter, which is the attribute constant representing the attribute you want to retrieve. It returns the value of the requested attribute.

Commonly used attributes include:

* PDO::ATTR_AUTOCOMMIT: Whether auto-commit mode is enabled.
* PDO::ATTR_ERRMODE: The error handling mode.
* PDO::ATTR_DRIVER_NAME: The name of the database driver.

You can use getAttribute to programmatically retrieve information about the connection, which can be useful for various purposes, including debugging and logging.
### PDO::getAvailableDrivers

The `getAvailableDrivers` method in PDO returns an array containing the names of all available PDO drivers. These drivers represent different database management systems that PDO can connect to. Here's how you can use `getAvailableDrivers`:

```php
$availableDrivers = PDO::getAvailableDrivers();
```
The `getAvailableDrivers` method doesn't require an instance of PDO; you can call it directly using the class name. It returns an array containing the names of available drivers, such as "mysql", "sqlite", "pgsql", "oci", and more.

This method is useful if you want to dynamically discover the available PDO drivers on the system or if you want to provide a list of supported database systems in your application.
</details>

## 3.2  Transaction Management
<details>

### PDO::beginTransaction

The `beginTransaction` method in PDO initiates a transaction, allowing you to group multiple database operations into a single unit of work. Transactions are essential for maintaining data consistency and integrity. 

```php
$pdo->beginTransaction();
```
### PDO::commit

The `commit` method in PDO finalizes a transaction, making the changes permanent in the database. This is typically used when you've successfully completed a series of database operations and want to persist the changes. Here's how you can use `commit`:

```php
$pdo->commit();
```
After executing a series of operations within a transaction, if everything is successful and you want to save the changes, you can call the commit method. This ensures that all changes made within the transaction are permanently stored in the database.

Remember that committing a transaction should be done only when you're confident that all operations within the transaction have been successfully completed. If an error occurs or if you need to discard the changes, you can roll back the transaction using the rollBack method.
### PDO::inTransaction

The `inTransaction` method in PDO allows you to determine whether you are currently inside a transaction. Transactions are units of work that allow you to perform multiple database operations as a single logical operation. Here's how you can use `inTransaction`:

```php
$insideTransaction = $pdo->inTransaction();
```
The inTransaction method returns a boolean value indicating whether you are currently inside a transaction. If the return value is true, you are within an active transaction; if it's false, you are not in a transaction.

This method is helpful if you need to conditionally execute certain operations based on whether a transaction is currently active or not.
### PDO::rollBack

The `rollBack` method in PDO is used to roll back a transaction, canceling all changes made within the transaction. Transactions provide a way to group multiple database operations into a single logical unit of work. If an error occurs during the transaction or if you decide to discard the changes, you can use `rollBack` to undo the changes. Here's how you can use `rollBack`:

```php
$pdo->rollBack();
```
Calling the rollBack method on a PDO instance rolls back the changes made within the current transaction. After rolling back, the database returns to the state it was in before the transaction started.

This method is particularly useful for ensuring data consistency and integrity in scenarios where multiple operations need to be executed together or when errors are encountered.
</details>

## 3.3. Error Handling and Information
<details>

### PDO::errorCode

The `errorCode` method in PDO allows you to fetch the SQLSTATE associated with the last database operation performed using the PDO instance. SQLSTATE is a standardized error code that provides information about the outcome of the most recent operation. Here's how you can use `errorCode`:

```php
$errorCode = $pdo->errorCode();
```

The errorCode method returns a string representing the SQLSTATE associated with the last operation. A SQLSTATE consists of a two-character class value followed by a three-character subclass value. For example, a SQLSTATE value of "42S02" might indicate that a table was not found.

You can use the returned SQLSTATE value to identify the type of error that occurred and take appropriate actions based on it.
### PDO::errorInfo
The `errorInfo` method in PDO allows you to fetch extended error information associated with the last database operation performed using the PDO instance. The returned information includes an array with the SQLSTATE, driver-specific error code, and error message. Here's how you can use `errorInfo`:

```php
$errorInfo = $pdo->errorInfo();
```

The errorInfo method returns an array with three elements:
* The first element represents the SQLSTATE, a standardized error code.
* The second element is the driver-specific error code.
* The third element is the driver-specific error message.

This information can help you diagnose and handle errors that occurred during database operations. For example, you can use the SQLSTATE to categorize the error and the error message to provide more context for troubleshooting.

</details>

## 3.4. Query Execution and Result Handling
<details>

### PDO::exec

The `exec` method in PDO is used to execute an SQL statement that doesn't return a result set, such as an INSERT, UPDATE, DELETE, or other non-query statements. It returns the number of rows affected by the operation. Here's how you can use `exec`:

```php
$sql = "UPDATE users SET status = 'inactive' WHERE last_login < :last_login";
$affectedRows = $pdo->exec($sql);
```
The `exec` method is suitable for executing SQL statements that perform data manipulation, and it's particularly useful when you want to know the number of affected rows. For example, after an UPDATE statement, the exec method will return the count of rows that were updated.
Keep in mind that the exec method does not return result sets for SELECT queries. For SELECT queries, you should use methods like query or prepare along with execute.
### PDO::query

The `query` method in PDO is used to prepare and execute an SQL statement without placeholders. This method is particularly useful for executing SELECT queries or statements that do not require parameter binding. It returns a result set as a PDOStatement object. Here's how you can use `query`:

```php
$sql = "SELECT * FROM users";
$result = $pdo->query($sql);
```

n the example above, the query method prepares and executes an SQL SELECT statement and returns a PDOStatement object stored in the variable $result. You can then fetch data from the result set using methods like `fetch` or `fetchAll`.

Keep in mind that when using the `query` method, you should be cautious about SQL injection vulnerabilities if you're incorporating user-provided data directly into the query.


</details>

## 3.5 Prepared Statements and Binding
<details>

### PDO::prepare

The `prepare` method in PDO is used to prepare an SQL statement for execution. This method returns a statement object that can be used to bind parameters, execute the statement, and fetch results. Prepared statements provide security against SQL injection and allow for efficient execution of multiple similar queries. Here's how you can use `prepare`:

```php
$sql = "SELECT * FROM users WHERE username = :username";
$stmt = $pdo->prepare($sql);
```
In the example above, the prepare method prepares an SQL SELECT statement and returns a statement object stored in the variable $stmt.

After preparing the statement, you can bind parameters using methods like `bindParam` or `bindValue`, execute the statement using `execute`, and fetch results using methods like fetch or fetchAll.
### PDO::quote

The `quote` method in PDO is used to escape and quote a string value for safe inclusion in a SQL query. This is particularly important for preventing SQL injection when incorporating user-provided data into queries. The method returns the escaped and quoted string. Here's how you can use `quote`:

```php
$userInput = "John's message";
$quotedValue = $pdo->quote($userInput);
```
In the example above, the quote method escapes and quotes the value of $userInput to make it safe for use in a query.

Remember that using prepared statements with parameter binding is the recommended way to prevent SQL injection. However, if you need to manually include string values in a query, using quote ensures that the values are properly escaped and quoted.

</details>

## 3.6 Miscellaneous
<details>

### PDO::setAttribute


The `setAttribute` method in PDO allows you to set various attributes for the PDO connection. Attributes are used to customize the behavior of the PDO connection or adjust its settings. Here's how you can use `setAttribute`:

```php
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
```

In the example above, the setAttribute method is used to set the error handling mode for the PDO connection to ERRMODE_EXCEPTION. This mode causes PDO to throw exceptions for errors, providing a more structured way to handle errors.

The setAttribute method takes two parameters:

* The attribute constant representing the attribute you want to set.
* The value you want to assign to the attribute.

Commonly used attributes include:

* PDO::ATTR_ERRMODE: Error handling mode.
* PDO::ATTR_DEFAULT_FETCH_MODE: Default fetch mode for result sets.
* PDO::ATTR_EMULATE_PREPARES: Emulation of prepared statements.

Setting attributes using setAttribute allows you to fine-tune the behavior of the PDO connection to suit your application's requirements.
### PDO::lastInsertId

The `lastInsertId` method in PDO returns the ID of the last inserted row or sequence value, typically after performing an INSERT operation. This is particularly useful when you need to obtain the primary key value generated for an auto-incrementing column. Here's how you can use `lastInsertId`:

```php
$lastInsertId = $pdo->lastInsertId();
```

</details>


# PDOStatement — The PDOStatement class

The `PDOStatement` class represents a prepared statement and provides methods for executing and fetching results from the statement. Below are the methods available in the `PDOStatement` class:

## 1. Binding Parameters and Values


### BindColumn — Bind a column to a PHP variable

The `bindColumn` method in PDOStatement allows you to bind a specific column from the result set to a PHP variable. This technique is particularly useful when you want to directly fetch values from the result set into variables. Here's how to use `bindColumn`:

```php
$stmt = $pdo->prepare("SELECT name, age FROM users");
$stmt->execute();

$stmt->bindColumn('name', $name);
$stmt->bindColumn('age', $age);

while ($stmt->fetch()) {
    // Now $name and $age contain the values from the result set
}
```
In the example above, the bindColumn method is used to associate the columns 'name' and 'age' from the result set with the variables $name and $age. As you loop through the result set using fetch, the values are automatically populated into these variables.

This method is particularly handy when you need fine-grained control over fetched column values and want to directly assign them to variables.

### BindParam

The `bindParam` method in PDOStatement allows you to bind a named or positional parameter to a PHP variable. This technique is commonly used when you want the variable's value to be dynamically updated as you iterate through the result set or as the parameter value changes. Here's how to use `bindParam`:

```php
$stmt = $pdo->prepare("SELECT name, age FROM users WHERE age > :age");
$age = 30;
$stmt->bindParam(':age', $age, PDO::PARAM_INT);

$stmt->execute();

// Now the query will use the updated $age value when ex
```
n the example above, the bindParam method binds the parameter :age to the PHP variable $age. Any changes made to $age will be reflected in the parameter when the statement is executed.

This method is useful when you need to pass variables to the query that may change during the execution of the script.

### BindValue

The `bindValue` method in PDOStatement allows you to bind a named or positional parameter to a specific value. Unlike `bindParam`, the value assigned to the parameter remains constant throughout the execution of the statement. Here's how to use `bindValue`:

```php
$stmt = $pdo->prepare("SELECT name, age FROM users WHERE age > :age");
$stmt->bindValue(':age', 30, PDO::PARAM_INT);

$stmt->execute();

// The query will use the constant value 30 for the age parameter
```
In the example above, the bindValue method sets the value of the parameter :age to a constant value of 30. This value remains the same each time the statement is executed.

This method is useful when you need to pass a fixed value to the query as a parameter, regardless of any changes in the script.

## Statement Execution and Cursor Control

- `closeCursor` — Closes the cursor, enabling the statement to be executed again
- `execute` — Executes a prepared statement

## Fetching Results

- `fetch` — Fetches the next row from a result set
- `fetchAll` — Fetches the remaining rows from a result set
- `fetchColumn` — Returns a single column from the next row of a result set
- `fetchObject` — Fetches the next row and returns it as an object

## Result Set Metadata

- `columnCount` — Returns the number of columns in the result set
- `getColumnMeta` — Returns metadata for a column in a result set

## Error Handling

- `errorCode` — Fetch the SQLSTATE associated with the last operation on the statement handle
- `errorInfo` — Fetch extended error information associated with the last operation on the statement handle

## Statement Attributes

- `getAttribute` — Retrieve a statement attribute
- `setAttribute` — Set a statement attribute

## Cursor and Rowset Navigation

- `nextRowset` — Advances to the next rowset in a multi-rowset statement handle

## Miscellaneous

- `rowCount` — Returns the number of rows affected by the last SQL statement
- `setFetchMode` — Set the default fetch mode for this statement

## Debugging and Inspection

- `debugDumpParams` — Dump an SQL prepared command

## Advanced Result Handling

- `getIterator` — Gets result set iterator

