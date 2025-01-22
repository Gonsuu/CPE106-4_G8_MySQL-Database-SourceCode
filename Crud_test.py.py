import mysql.connector

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root123',
    'database': 'testDB5'
}

def connect_db():
    try:
        connection = mysql.connector.connect(**db_config)
        print("Connected to the database successfully")
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

def create_employee(emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id):
    connection = connect_db()
    if connection:
        cursor = connection.cursor()
        sql = """
        INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id)
        cursor.execute(sql, values)
        connection.commit()
        print("Employee added successfully")
        cursor.close()
        connection.close()

def read_employees():
    connection = connect_db()
    if connection:
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM employee")
        for row in cursor.fetchall():
            print(row)
        cursor.close()
        connection.close()

def update_employee_salary(emp_id, new_salary):
    connection = connect_db()
    if connection:
        cursor = connection.cursor()
        sql = "UPDATE employee SET salary = %s WHERE emp_id = %s"
        values = (new_salary, emp_id)
        cursor.execute(sql, values)
        connection.commit()
        print("Employee salary updated successfully")
        cursor.close()
        connection.close()

def delete_employee(emp_id):
    connection = connect_db()
    if connection:
        cursor = connection.cursor()
        sql = "DELETE FROM employee WHERE emp_id = %s"
        cursor.execute(sql, (emp_id,))
        connection.commit()
        print("Employee deleted successfully")
        cursor.close()
        connection.close()

if __name__ == "__main__":
    create_employee(200, 'John', 'Doe', '1990-01-01', 'M', 60000, None, 1)

    print("Employees after insertion:")
    read_employees()

    update_employee_salary(200, 70000)

    print("Employees after update:")
    read_employees()

    delete_employee(200)

    print("Employees after deletion:")
    read_employees()