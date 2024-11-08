import mysql.connector

def connect_to_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="naman",
        database="Pconnect"
    )

def add_student():
    db = connect_to_database()
    cursor = db.cursor()
    roll = int(input("Enter roll number: "))
    name = input("Enter name: ")
    sql = "INSERT INTO student (roll, name) VALUES (%s, %s)"
    val = (roll, name)
    cursor.execute(sql, val)
    db.commit()
    print("Student added successfully!")
    cursor.close()
    db.close()

def delete_student():
    db = connect_to_database()
    cursor = db.cursor()
    roll = int(input("Enter roll number of the student to delete: "))
    sql = "DELETE FROM student WHERE roll = %s"
    val = (roll,)
    cursor.execute(sql, val)
    db.commit()
    print("Student deleted successfully!")
    cursor.close()
    db.close()

def edit_student():
    db = connect_to_database()
    cursor = db.cursor()
    roll = int(input("Enter roll number of the student to edit: "))
    new_name = input("Enter the new name: ")
    sql = "UPDATE student SET name = %s WHERE roll = %s"
    val = (new_name, roll)
    cursor.execute(sql, val)
    db.commit()
    print("Student record updated successfully!")
    cursor.close()
    db.close()

def view_students():
    db = connect_to_database()
    cursor = db.cursor()
    cursor.execute("SELECT * FROM student")
    results = cursor.fetchall()
    print("Student Records:")
    for row in results:
        print(f"Roll: {row[0]}, Name: {row[1]}")
    cursor.close()
    db.close()

def main():
    while True:
        print("\n--- Student Database Menu ---")
        print("1. Add Student")
        print("2. Delete Student")
        print("3. Edit Student")
        print("4. View Students")
        print("5. Exit")
        choice = input("Enter your choice (1-5): ")
        
        if choice == '1':
            add_student()
        elif choice == '2':
            delete_student()
        elif choice == '3':
            edit_student()
        elif choice == '4':
            view_students()
        elif choice == '5':
            print("Exiting the program.")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
