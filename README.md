# Hotel-App-Swift

Overview
The UITableView is a powerful tool in Swift that allows you to display large amounts of data in a scrollable list. The UITableView works in conjunction with a data source and delegate to populate the table view with data and respond to user interactions.

Usage
To use the UITableView in your project, you need to follow these steps:

1. Set up the UITableView
First, you need to create a UITableView and add it to your view hierarchy. You can do this programmatically or by using Interface Builder.

2. Implement the UITableViewDataSource protocol
The UITableViewDataSource protocol is responsible for providing the data that will be displayed in the table view. You need to implement the following two methods:

tableView(_:numberOfRowsInSection:)
This method returns the number of rows in a section of the table view.

tableView(_:cellForRowAt:)
This method returns the cell to be displayed for a given row in the table view.

3. Implement the UITableViewDelegate protocol
The UITableViewDelegate protocol is responsible for handling user interactions with the table view. You need to implement the following method:

tableView(_:didSelectRowAt:)
This method is called when the user selects a row in the table view. You can use this method to perform an action when the user selects a row.

4. Fetch data
Before you can display data in the table view, you need to fetch the data from an external source. You can use URLSession to fetch data from a web service or Core Data to fetch data from a local database.

5. Populate the table view with data
Once you have fetched the data, you can use the UITableViewDataSource methods to populate the table view with the data. You can use a custom UITableViewCell to display the data in a way that suits your needs.


Overview
The Hotel API allows you to fetch data from various hotels. You can retrieve information such as full name, short name, display name, primary display name, secondary display name, last search name: . The API is RESTful and returns data in JSON format.

Authentication
To use the Hotel API, you will need to obtain an API key. Please contact the API provider to obtain the API key. Once you have the API key, you can include it in your requests as an HTTP header.

Endpoints
The Hotel API provides the following endpoints:

/hotels
This endpoint returns a list of hotels.

Query parameters
1. full name: The full name of the city where the hotels are located.
2. short name: The short name of the city.
3. display name: The display name of the city.
4. primary display name: The primary display name of the city.
5. secondary display name : The secondary display name of the city.
6. last search name: The last search name of the city.

Registation with firebase

Usage
To create a registration page using Firebase in Swift, you need to follow these steps:

1. Create a Firebase Project
First, you need to create a Firebase project in the Firebase console. Go to the Firebase console, click on "Create Project," and follow the instructions to create a new project.

2. Add Firebase to Your Project
Once you have created a Firebase project, you need to add Firebase to your Swift project. You can do this by following the instructions in the Firebase documentation.

3. Design the User Interface
Next, you need to design the user interface for your registration page. You can do this by using Interface Builder to create a view controller and adding the necessary UI elements such as text fields, labels, and buttons.

4. Implement the User Interface
Once you have designed the user interface, you can implement the registration page. You need to do the following:

Connect UI Elements to Code
Connect the UI elements to your view controller's code by creating outlets and actions. Outlets allow you to access the UI elements in your code, and actions allow you to respond to user interactions.

Register User with Firebase
When the user taps the register button, you need to create a new user account in Firebase Authentication. You can do this by calling the createUser method of the Auth class, passing in the user's email address and password. This method will create a new user account and sign the user in automatically.
