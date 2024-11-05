import mysql.connector

# Database connection function
def connect_to_database():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="your_password",  # Replace 'your_password' with your MySQL root password
            database="SampleDB"
        )
        if conn.is_connected():
            print("Connected to MySQL database")
        return conn
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

# Function to add a new employee
def add_employee(conn):
    name = input("Enter employee name: ")
    position = input("Enter employee position: ")
    salary = float(input("Enter employee salary: "))
    cursor = conn.cursor()
    query = "INSERT INTO Employees (name, position, salary) VALUES (%s, %s, %s)"
    cursor.execute(query, (name, position, salary))
    conn.commit()
    print("Employee added successfully!")

# Function to view all employees
def view_employees(conn):
    cursor = conn.cursor()
    query = "SELECT * FROM Employees"
    cursor.execute(query)
    rows = cursor.fetchall()
    print("ID | Name | Position | Salary")
    for row in rows:
        print(row)

# Function to update employee details
def update_employee(conn):
    emp_id = int(input("Enter employee ID to update: "))
    name = input("Enter new name: ")
    position = input("Enter new position: ")
    salary = float(input("Enter new salary: "))
    cursor = conn.cursor()
    query = "UPDATE Employees SET name = %s, position = %s, salary = %s WHERE id = %s"
    cursor.execute(query, (name, position, salary, emp_id))
    conn.commit()
    print("Employee updated successfully!")

# Function to delete an employee
def delete_employee(conn):
    emp_id = int(input("Enter employee ID to delete: "))
    cursor = conn.cursor()
    query = "DELETE FROM Employees WHERE id = %s"
    cursor.execute(query, (emp_id,))
    conn.commit()
    print("Employee deleted successfully!")

# Main menu
def main_menu():
    conn = connect_to_database()
    if conn is None:
        print("Failed to connect to database.")
        return
    while True:
        print("\nMenu:")
        print("1. Add Employee")
        print("2. View Employees")
        print("3. Update Employee")
        print("4. Delete Employee")
        print("5. Exit")
        
        choice = int(input("Enter your choice: "))
        
        if choice == 1:
            add_employee(conn)
        elif choice == 2:
            view_employees(conn)
        elif choice == 3:
            update_employee(conn)
        elif choice == 4:
            delete_employee(conn)
        elif choice == 5:
            conn.close()
            print("Exiting program.")
            break
        else:
            print("Invalid choice. Please try again.")

# Run the program
if __name__ == "__main__":
    main_menu()
