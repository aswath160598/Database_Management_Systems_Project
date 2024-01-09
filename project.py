from getpass import getpass

import re

import numpy as np
import pandas as pd
import pymysql
from tabulate import tabulate

import seaborn as sns
import matplotlib.pyplot as plt

createEmployeeAuthCode = "busybee"

emailRegex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'


def emailValidChecker(email):
    if re.fullmatch(emailRegex, email):
        return True
    else:
        return False


def mobileNumberValid(mobile):
    if mobile.isnumeric() and len(mobile) == 10:
        return True
    else:
        return False


def validatePassword(password):
    if password.strip() == '' or len(password) < 5:
        return False
    else:
        return True


def changePassword():
    passwordValid = False
    while not passwordValid:
        newPassword = getpass("Enter your password (min length 5): ")
        passwordValid = validatePassword(newPassword)
        if not passwordValid:
            print('\nPlease enter a valid password')
            newPassword = getpass("Enter your password (min length 5): ")
            passwordValid = validatePassword(newPassword)

    return newPassword


def inputFirstName():
    firstNameValid = False
    while not firstNameValid:
        firstName = input("Please enter your First Name: ")
        firstNameValid = True
        if firstName.isnumeric() or firstName == '':
            print("Please enter a valid First Name")
            firstNameValid = False
    return firstName


def inputLastName():
    lastNameValid = False
    while not lastNameValid:
        lastName = input("Please enter your Last Name: ")
        lastNameValid = True
        if lastName.isnumeric() or lastName == '':
            print("Please enter a valid Last Name")
            lastNameValid = False
    return lastName


def inputEmail():
    emailValid = False
    while not emailValid:
        email = input("Enter your email: ")
        emailValid = emailValidChecker(email)
        if not emailValid:
            print("Please enter a valid email")
    return email


def inputMobileNumber():
    mobileValid = False
    while not mobileValid:
        mobileNumber = input("Please enter your mobile number: ")
        mobileValid = mobileNumberValid(mobileNumber)
        if not mobileValid:
            print("Please enter a valid mobile number")
    return mobileNumber


def inputPassword():
    passwordValid = False
    while not passwordValid:
        password = getpass("Enter your password (min length 5): ")
        passwordValid = validatePassword(password)
        if not passwordValid:
            print('\nPlease enter a valid password')
    return password


def printCustomerOrders(cid):
    stmt_select = "call listOrdersCustomer('{}')".format(cid)
    cur.execute(stmt_select)

    rows = []
    for order in cur.fetchall():
        row = []
        for k, v in order.items():
            if k != 'custID':
                row.append(v)
        rows.append(row)

    orderCount = len(rows)

    if orderCount == 0:
        print("\nNo orders found\n")

    else:
        print()
        print("YOU HAVE THE FOLLOWING ORDERS:")
        print(tabulate(rows, headers=["ORDER ID", "DELIVERY DATE",
                                      "ORDER STATUS",
                                      "ORDER DATE"]))

    return orderCount


def inputAge():
    ageValid = False
    while not ageValid:
        age = input("Please enter your age number: ")
        ageValid = True
        if age < 18:
            print("Please enter a valid age")
            ageValid = False
    return age


dbUsername = input("Please enter the username to connect to the database: ")
dbPassword = getpass("Please enter the password: ")


cnx = pymysql.connect(host='localhost',
                      user=dbUsername,
                      password=dbPassword,
                      db='laptop_ordering',
                      charset='utf8mb4',
                      cursorclass=pymysql.cursors.DictCursor)

print("\nDatabase connection successful\n")
print("\nWelcome to Laptop Ordering System")
print("\nPlease select one of the below options to continue")

cur = cnx.cursor()


def getCustomerID(customerEmail):
    stmt_select = "select getCustomerID('{}')".format(customerEmail)
    cur.execute(stmt_select)

    ret = cur.fetchall()

    for k, v in ret[0].items():
        return v


def getEmployeeID(employeeEmail):
    stmt_select = "select getEmployeeID('{}')".format(employeeEmail)
    cur.execute(stmt_select)

    ret = cur.fetchall()

    for k, v in ret[0].items():
        return v

validSelection = False
while not validSelection:
    print("Enter 1 for customer options")
    print("Enter 2 for employee options")
    optionsInput = input()
    if optionsInput == "1" or optionsInput == "2":
        validSelection = True
    if not validSelection:
        print("\nPlease enter a valid input\n")

if optionsInput == "1":

    validSelection = False
    while not validSelection:
        print("Enter 1 to login to existing customer account")
        print("Enter 2 to create new customer account")
        userLoginInput = input()
        if userLoginInput == "1" or userLoginInput == "2":
            validSelection = True
        if not validSelection:
            print("\nPlease enter a valid input\n")

    if userLoginInput == "1":
        print("\nCustomer Login Selected")
        valid = False
        while not valid:
            customerEmail = input("Enter your email: ")
            valid = emailValidChecker(customerEmail)
            if not valid:
                print("Please enter a valid email")

        customerPassword = getpass("Enter your password: ")

        stmt_select = "call returnCustomerEmails()"
        cur.execute(stmt_select)

        customerEmailList = []
        for r in cur.fetchall():
            customerEmailList.append(r['customerEmail'])

        if customerEmail in customerEmailList:
            stmt_select = "call checkCustomerPassword('{}')" \
                .format(customerEmail)

            cur.execute(stmt_select)
            if customerPassword == cur.fetchall()[0]['customerPassword']:
                print("Login Successful")

                continueInput = 'y'
                while continueInput == 'y':
                    cid = getCustomerID(customerEmail)

                    print("\nEnter 1 to edit your profile")
                    print("Enter 2 to delete your account")
                    print("Enter 3 to place an order for a laptop")
                    print("Enter 4 to check order status")
                    print("Enter 5 to cancel an order")
                    print("Enter 6 to check payment status")

                    postLoginSelection = input()

                    if postLoginSelection == "1":
                        validSelection = False
                        while not validSelection:
                            print("Enter 1 to edit mobile number")
                            print("Enter 2 to change password")
                            editSelection = input()
                            if editSelection == "1" or editSelection == "2":
                                validSelection = True
                            if not validSelection:
                                print("\nPlease enter a valid input\n")

                        if editSelection == "1":

                            newMobileNumber = inputMobileNumber()

                            stmt_select = "call updateCustomerPhone('{}', '{}')" \
                                .format(int(cid), newMobileNumber)
                            cur.execute(stmt_select)
                            print("Mobile number updated successfully.")

                        elif editSelection == "2":

                            newPassword = changePassword()

                            stmt_select = "call updateCustomerPassword('{}', '{}')" \
                                .format(int(cid), newPassword)
                            cur.execute(stmt_select)
                            print("Password updated successfully.")

                    elif postLoginSelection == '2':
                        print("Are you sure you want to delete your account? (y/n)")
                        deleteSelection = input()
                        if deleteSelection == 'y':
                            stmt_select = "call deleteCustomer('{}')".format(int(cid))
                            cur.execute(stmt_select)
                            print("Your account has been deleted")
                            break

                    elif postLoginSelection == '3':
                        print("Do you want to filter laptops? (y/n)")
                        filterLaptop = input()
                        d = dict()
                        ram = ''
                        ssd = ''
                        screenSize = ''
                        operatingSystem = ''
                        s = []
                        if filterLaptop == 'y':
                            print("Available RAM options are 8, 16, 32")
                            ram = input("Enter the RAM (Leave blank for skip): ")
                            if not ram == '':
                                d["RAM"] = "'" + ram + "'"
                            print("Available SSD options are 512, 1024")
                            ssd = input("Enter SSD capacity (Leave blank for skip): ")
                            if not ssd == '':
                                d["SSD"] = "'" + ssd + "'"
                            print("Available screen size options are 13, 14, 16")
                            screenSize = input("Enter the screen size (Leave blank for skip): ")
                            if not screenSize == '':
                                d["screenSize"] = "'" + screenSize + "'"
                            print("Available operating system options are Windows, macOS")
                            operatingSystem = input("Enter the operating system (Leave blank for "
                                                    "skip): ")
                            if not operatingSystem == '':
                                d["operatingSystem"] = "'" + operatingSystem + "'"
                            if len(d) > 0:
                                # s = []
                                for k, v in d.items():
                                    s.append(k + '=' + v)

                            if s:
                                l = " and ".join(s)
                                stmt_select = 'select * from laptop_model where ' + l
                                cur.execute(stmt_select)
                            else:
                                stmt_select = "call listLaptopModels()"
                                cur.execute(stmt_select)

                        elif filterLaptop == 'n':
                            stmt_select = "call listLaptopModels()"
                            cur.execute(stmt_select)
                        else:
                            print("Invalid Input")

                        availableModels = []
                        rows = []
                        for laptop in cur.fetchall():
                            row = []
                            for k, v in laptop.items():
                                if k == 'storeID' or k == 'numOfLaptops':
                                    continue
                                if k == 'modelID':
                                    availableModels.append(v)
                                row.append(v)
                            rows.append(row)

                        if len(rows) == 0:
                            print("\nNo laptops found\n")

                        else:

                            print()
                            print("LIST OF AVAILABLE LAPTOPS:")
                            print(tabulate(rows, headers=["MODEL ID", "MODEL NAME", "BRAND",
                                                          "RAM", "SSD", "SCREEN SIZE",
                                                          "GPU", "OS"]))

                            customerModelID = input("\nEnter the model ID of the laptop to be "
                                                    "purchased: ")

                            if int(customerModelID) not in availableModels:
                                print("Invalid model ID selected")

                            else:
                                stmt_select = "call insertOrder('{}', '{}')".format(cid,
                                                                                    customerModelID)
                                cur.execute(stmt_select)

                                paymentModeSelectionValid = False

                                while not paymentModeSelectionValid:

                                    print("Select payment mode:")
                                    print("Enter 1 for credit card")
                                    print("Enter 2 for debit card")

                                    paymentModeSelection = input()

                                    if paymentModeSelection == "1":
                                        paymentMode = "Credit Card"
                                        paymentModeSelectionValid = True
                                    elif paymentModeSelection == "2":
                                        paymentMode = "Debit Card"
                                        paymentModeSelectionValid = True
                                    else:
                                        print("Invalid Selection")

                                customerCardNumber = input("Please enter your card number: ")
                                nameOnCard = input("Please enter the name on the card: ")

                                stmt_select = "call insertPayment('{}', '{}', '{}', '{}')" \
                                    .format(cid, paymentMode, customerCardNumber, nameOnCard)
                                cur.execute(stmt_select)
                                print("Laptop Order Successful")

                    elif postLoginSelection == '4':
                        orderCount = printCustomerOrders(cid)

                    elif postLoginSelection == '5':
                        orderCount = printCustomerOrders(cid)
                        if orderCount == 0:
                            continue
                        else:
                            print("\nPlease select an order ID from the above list to proceed "
                                  "with cancellation")
                            selectedOrderID = input()
                            stmt_select = "call cancelOrder('{}', '{}')".format(selectedOrderID,
                                                                                cid)
                            cur.execute(stmt_select)

                            status = cur.fetchall()
                            if len(status) == 0:
                                print("\nOrder cancelled successfully\n")
                            elif status[0]['MYSQL_ERROR'] == 1100:
                                print("\nDelivered orders cannot be cancelled.\n")
                            elif status[0]['MYSQL_ERROR'] == 1001:
                                print("\nOrder is already cancelled.\n")
                            elif status[0]['MYSQL_ERROR'] == 1002:
                                print("\nInvalid order ID.\n")

                    elif postLoginSelection == '6':
                        orderCount = printCustomerOrders(cid)

                        if orderCount == 0:
                            continue
                        else:
                            print("\nPlease select an order ID from the above list to check "
                                  "payment status")
                            selectedOrderID = input()
                            stmt_select = "select returnPaymentStatus('{}')".format(selectedOrderID)
                            cur.execute(stmt_select)

                            ret = cur.fetchall()

                            for k, v in ret[0].items():
                                print("Payment status for order ID " + selectedOrderID + " is " + v)

                    continueInput = input("Do you want to continue? (y/n) ")

            else:
                print("Incorrect Password")
        else:
            print("Incorrect Email")

    elif userLoginInput == "2":
        print("Creating new Customer Account")

        customerFirstName = inputFirstName()
        customerLastName = inputLastName()
        customerEmail = inputEmail()
        customerMobile = inputMobileNumber()
        customerPassword = inputPassword()

        # asking for the customer's address
        print("Please enter your address")
        bNoValid = False
        while not bNoValid:
            bNo = input("Please enter your building number: ")
            bNoValid = True
            if not bNo.isnumeric() or bNo == '':
                print("Please enter a valid building number: ")
                bNoValid = False

        cityValid = False
        while not cityValid:
            city = input("Please enter your city: ")
            cityValid = True
            if city.isnumeric() or city == '':
                print("Please enter a valid city")
                cityValid = False

        stateValid = False
        while not stateValid:
            state = input("Please enter your state: ")
            stateValid = True
            if state.isnumeric() or state == '':
                print("Please enter a valid state")
                stateValid = False

        zipcodeValid = False
        while not zipcodeValid:
            zipcode = input("Please enter your zipcode: ")
            zipcodeValid = True
            if not zipcode.isnumeric() or zipcode == '' or len(zipcode) < 6:
                print("Please enter a valid zipcode")
                zipcodeValid = False

        stmt_select = "call createCustomer('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}')" \
            .format(customerFirstName,
                    customerLastName,
                    customerEmail,
                    customerMobile,
                    customerPassword,
                    bNo,
                    city,
                    state,
                    zipcode)
        cur.execute(stmt_select)
        status = cur.fetchall()
        if len(status) == 0:
            print("Account creation successful")
        else:
            # print("\nEmail already exists. ERR code: " + str(status[0]['MYSQL_ERROR']))
            print("\nAccount cannot be created. Email already exists.")

elif optionsInput == "2":
    print("\nEnter 1 for employee login")
    print("Enter 2 to create new employee login")

    employeeLoginInput = input()

    if employeeLoginInput == "1":
        print("\nEmployee Login Selected")
        valid = False
        while not valid:
            employeeEmail = input("Enter your email: ")
            valid = emailValidChecker(employeeEmail)
            if not valid:
                print("Please enter a valid email")

        employeePassword = getpass("Enter your password: ")

        stmt_select = "call returnEmployeeEmails()"
        cur.execute(stmt_select)

        employeeEmailList = []
        for r in cur.fetchall():
            employeeEmailList.append(r['employeeEmail'])

        if employeeEmail in employeeEmailList:
            stmt_select = "call checkEmployeePassword('{}')" \
                .format(employeeEmail)

            cur.execute(stmt_select)
            if employeePassword == cur.fetchall()[0]['employeePassword']:
                print("Login Successful")

                continueInput = 'y'
                while continueInput == 'y':
                    eid = getEmployeeID(employeeEmail)

                    print("\nEnter 1 to edit your profile")
                    print("Enter 2 to approve a payment")
                    print("Enter 3 to visualize laptop model sales")
                    print("Enter 4 to visualize brand sales")

                    postLoginSelection = input()

                    if postLoginSelection == "1":
                        validSelection = False
                        while not validSelection:
                            print("Enter 1 to edit mobile number")
                            print("Enter 2 to change password")
                            editSelection = input()
                            if editSelection == "1" or editSelection == "2":
                                validSelection = True
                            if not validSelection:
                                print("\nPlease enter a valid input\n")

                        if editSelection == "1":
                            newMobileNumber = inputMobileNumber()

                            stmt_select = "call updateEmployeePhone('{}', '{}')" \
                                .format(int(eid), newMobileNumber)
                            cur.execute(stmt_select)
                            print("Mobile number updated successfully.")

                        if editSelection == "2":
                            newPassword = changePassword()

                            stmt_select = "call updateEmployeePassword('{}', '{}')" \
                                .format(int(eid), newPassword)
                            cur.execute(stmt_select)
                            print("Password updated successfully.")

                    elif postLoginSelection == "2":
                        # show list of customers for that employee
                        # ask employee to select a customer
                        # check if that customer has any pending payments
                        stmt_select = "call getListCustomers('{}')".format(eid)
                        cur.execute(stmt_select)

                        customers = []
                        for customer in cur.fetchall():
                            customers.append(customer['customerID'])

                        if len(customers) == 0:
                            print("\nNo customers found\n")

                        else:
                            print()
                            print("Please select a customer ID from the below list:")
                            print(customers)
                            selected_cid = input()

                            stmt_select = "call getOrdersListCust('{}', '{}')".format(selected_cid,
                                                                                      eid)
                            cur.execute(stmt_select)

                            rows = []
                            for order in cur.fetchall():
                                row = []
                                for k, v in order.items():
                                    row.append(v)
                                rows.append(row)

                            if len(rows) == 0:
                                print("\nNo order found for the customer\n")

                            else:
                                print()
                                print("LIST OF PENDING ORDERS:")
                                print(tabulate(rows, headers=["ORDER ID", "CUSTOMER NAME"]))

                                print("Please enter order ID to approve payment")
                                selected_orderID = input()

                                stmt_select = "call updatePaymentStatus('{}', '{}', '{}')" \
                                    .format(eid, selected_orderID, selected_cid)
                                cur.execute(stmt_select)

                                print("Payment status marked as COMPLETED and order status set to "
                                      "PROCESSING")

                    elif postLoginSelection == "3":
                        # plot a bar chart for model visualization

                        stmt_select = "call returnLaptopModelCount()"
                        cur.execute(stmt_select)

                        models = []
                        sale_count = []

                        for m in cur.fetchall():
                            models.append(m['model'])
                            sale_count.append(m['numOfLaptops'])

                        plt.pie(sale_count,
                                autopct=lambda x: '{:.0f}'.format(x * np.sum(sale_count) / 100),
                                shadow=False)
                        plt.legend(models, bbox_to_anchor=(0.9, 1.0), loc="upper left")

                        plt.tight_layout()

                        plt.show()

                    elif postLoginSelection == "4":
                        # plot a pie chart for brand visualization
                        stmt_select = "call returnBrandCount()"
                        cur.execute(stmt_select)

                        brands = []
                        sale_count = []

                        for m in cur.fetchall():
                            brands.append(m['brandName'])
                            sale_count.append(m['numOfProducts'])

                        fig, ax = plt.subplots()

                        sns.barplot(x='brands', y='sale_count',
                                    data=pd.DataFrame(zip(brands, sale_count),
                                                      columns=['brands', 'sale_count']))
                        ax.spines['right'].set_visible(False)
                        ax.spines['top'].set_visible(False)

                        plt.show()

                    continueInput = input("\nDo you want to continue? (y/n) ")

            else:
                print("Incorrect Password")
        else:
            print("Incorrect Email")

    if employeeLoginInput == "2":

        authAccepted = False
        while not authAccepted:
            authCode = input("Enter employee creation auth code: ")
            if authCode == createEmployeeAuthCode:
                authAccepted = True
            if not authAccepted:
                print("\nPlease enter valid employee creation auth code")

        print("\nCreating new Employee Account")

        employeeFirstName = inputFirstName()
        employeeLastName = inputLastName()
        employeeEmail = inputEmail()
        employeeMobile = inputMobileNumber()

        employeeAge = inputAge()
        employeeStoreID = input("Please enter your Store ID: ")
        employeePassword = inputPassword()

        stmt_select = "call createEmployee('{}', '{}', '{}', '{}', '{}', '{}', '{}')" \
            .format(employeeFirstName,
                    employeeLastName,
                    employeeEmail,
                    employeeMobile,
                    employeeAge,
                    employeeStoreID,
                    employeePassword)
        cur.execute(stmt_select)
        status = cur.fetchall()
        if len(status) == 0:
            print("Account creation successful")
        else:
            print("\nEmail already exists. ERR code: " + str(status[0]['MYSQL_ERROR']))

cur.close()
cnx.close()
