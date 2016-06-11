# Timeline

### Level 3

Timeline is a simple photo sharing service. Students will bring in many concepts that they have learned, and add complex data modeling, Image Picker, Collection Views, NSURLSession, Firebase, and protocol-oriented programming, 

This is a Capstone Level project spanning many class days and concepts. Most concepts will be covered during class, others are introduced during the project. Not every instruction will outline each line of code to write, but lead the student to the solution.

Students who complete this project independently are able to:

#### Part One - Project Planning, Model Objects, and Controllers

* follow a project planning framework to build a development plan
* follow a project planning framework to prioritize and manage project progress
* implement a layered tab bar based view hierarchy
* implement a related data model architecture
* add staged data to a model object controller

#### Part Two - Wire Up Views

* use an enum to create a customizable table view
* build a reusable log in/sign-up view controller
* implement a collection view based master-detail interface
* implement a search controller

#### Part Three - Wire Up Views (contd)

* implement a complex UITableView with multiple cell types and sections
* implement multiple custom table view cells with delegate pattern
* use an image picker to access and work with photos
* use an accessory editing view as a text field and send button

#### Part Four - Implement Controllers

* use Firebase as a backend for storing and pulling related model objects
* implement the Firebase controller and model object controllers to work with live data
* implement a custom protocol for Firebase model objects, controllers, and live updating views
* use dispatch groups to verify task completion before returning values

#### Part Five - Implement Controllers

* upload photos to Firebase as base64 strings
* asynchronously download photos to display
* authenticate users via e-mail

Follow the development plan included with the project to build out the basic view hierarchy, basic implementation of local model objects and model object controllers, and build staged data to lay a strong foundation for the rest of the project.

### View Hierarchy

1. Add a ```UITableViewController``` Timeline view controller, embed it in a ```UINavigationController```, add a + button as the right ```UIBarButtonItem```, embed the ```UINavigationController``` in a ```UITabBarController```, update the ```UITabBarItem``` to describe the scene.
    * note: The + button will be used to add photos.
2. Add a ```TimelineTableViewController.swift``` subclass of ```UITableViewController``` and assign it to the Timeline scene.
3. Add a ```UITableViewController``` Post Detail view controller, add a segue to it from a cell in the table view of the Timeline scene.
4. Add a ```PostDetailTableViewController.swift``` subclass of ```UITableViewController``` and assign it to the Post Detail scene.
5. Add a ```UITableViewController``` User List / Search view controller, embed it in a ```UINavigationController```, add a segmented control as the title view for the navigation bar with 'Friends' and 'Add Friend' segment titles, and add it to the ```UITabBarController```, update the ```UITabBarItem``` to describe the scene.
    * note: This view will be used for search and for listing friends.
6. Add a ```UserSearchTableViewController.swift``` subclass of ```UITableViewController``` and assign it to the User List/Search scene.
7. Add a ```UIViewController``` User Detail / Profile view controller, embed it in a ```UINavigationController```, and add it to the ```UITabBarController```, update the ```UITabBarItem``` to describe the scene. Now, add a segue from a table view cell of the User Search view directly to the User Detail / Profile view controller (bypass it's ```UINavigationController```).
8. Add a ```ProfileViewController.swift``` subclass of ```UIViewController``` and assign it to the Profile scene.
9. Add a ```UITableViewController``` Add Photo table view controller, embed in ```UINavigationController```, add a segue to it from the Timeline scene ```UIBarButtonItem```.
    * note: We will use a static table view for our Add Photo view, static table views should be used sparingly, but they can be useful for a table view that will never change, such as a basic form.
10. Add a ```AddPhotoTableViewController.swift``` subclass of ```UITableViewController``` and assign it to the Add Photo scene.
11. Add a ```UIViewController``` Login / Signup Choice view controller, embed it in a ```UINavigationController```, add a login button and a sign up button, add a ```Present Modally``` segue to it from the ```UITabBarController```.
12. Add a ```LoginSignupChoiceViewController.swift``` subclass of ```UIViewController``` and assign it to the Login / Signup Choice scene.
13. Add a ```UIViewController``` Login / Signup view controler, add two segues to it from the login and signup buttons on the Login / Signup Choice scene.
14. Add a ```LoginSignupViewController.swift``` subclass of ```UIViewcontroller``` and assign it to the Login / Signup scene.
    
### Implement Model

#### User

Create a 'User' model struct that will hold a username, optional bio, and optional url.

1. Create a ```User.swift``` file and define a new ```User``` struct.
2. Add properties for ```username```, ```bio```, ```url```, and optional ```identifier```.
    * note: Since a ```User``` can exist without a bio or url, ```bio``` and ```url``` are optional properties.
3. Add a memberwise initializer that takes parameters for each property. The parameter for ```identifier``` should be of type String.
    * Set a default parameter ```nil``` for the ```bio``` and ```url``` properties.
4. Implement the Equatable protocol by comparing both the ```username```s and ```identifier```s.

#### Comment

Create a 'Comment' model struct that will hold a username, text, and reference to the parent ```Post```.

1. Create a ```Comment.swift``` file and define a new ```Comment``` struct.
2. Add properties for ```username```, ```text```, ```postIdentifier```, and optional ```identifier```.
3. Add a memberwise initializer that takes parameters for each property
    * Set a default parameter ```nil``` for optional properties
4. Implement the Equatable protocol by comparing bolth the ```username```s and ```identifier```s.

#### Like

Create a 'Like' model struct that will hold a username, and reference to the parent ```Post```.

1. Create a ```Like.swift``` class file and define a new ```Like``` struct
2. Add properties for ```username```, ```postIdentifier```, and optional ```identifier```
3. Add a memberwise initializer that takes parameters for each property
    * Set a default parameter ```nil``` for optional properties
4. Implement the Equatable protocol by comparing both the ```username```s and ```identifier```s.

#### Post

Create a 'Post' model struct that will hold a pointer to an image, optional caption, username, array of comments, array of likes.

1. Create a ```Post.swift``` file and define a new ```Post``` struct.
2. Add properties for ```imageEndPoint```, ```caption```, ```username```, ```comments```, ```likes```, and optional ```identifier```.
    * note: Since a ```Post``` can exist without a caption, ```caption``` is an optional property.
3. Add a memberwise initializer that takes parameters for each property.
    * Set a default parameter ```nil``` for optional properties, and empty arrays for the ```commments``` and ```likes```.
4. Implement the Equatable protocol by comparing both the ```username```s and ```identifier```s.

The model objects will later conform to a FirebaseType protocol that will ease working with Firebase. You will add the required properties and functions at that point.

### Model Controller API

All of our calls to Firebase will be asynchronous. We will need to use completion closures for each call that reaches out to the network and returns a value.

### UserController

Create a ```UserController``` model object controller that will manage and serve ```User``` objects to the rest of the application. The ```UserController``` will also handle managing followers and followed accounts. As you write each function, consider how you would approach writing the implementation, consider writing comments on the steps you would take to compare to later instructions.

1. Create a ```UserController.swift``` file and define a new ```UserController``` class inside.
2. Add a ```currentUser: User!``` property that returns the current user as an implicitly unwrapped optional.
    * note: The current user's authentication details will be stored locally or set during initialization, so this can be a synchronous property.
    * note: Implicitly unwrapped optionals can be treated as optionals for checking, and as regular functions, we are building an assumption that if there is no user, the login/signup screen will be presented until there is one.
3. Set the default value of ```currentUser``` property to nil.
4. Add a static ```sharedController``` property that will help serve our ```currentUser``` consistently through the app.
5. Define a static function ```userForIdentifier``` that takes an identifier and completion closure with an optional User parameter.

One time sample included:

```
static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
    
}
```

6. Define a static function ```fetchAllUsers``` that takes a completion closure with an array of User parameter.
7. Define a static function ```followUser``` that takes a user and completion closure with a success Boolean parameter.
8. Define a static function ```unfollowUser``` that takes a user and a completion closure with a success Boolean parameter.
9. Define a static function ```userFollowsUser``` that takes a user, and a user to check against, and a completion closure with a follows Boolean parameter.
10. Define a static function ```followedByUser``` that takes a user and completion closure with an optional array of Users parameter.
11. Define a static function ```authenticateUser``` that takes an email, password, and completion closure with a success Boolean parameter and optional User parameter.
    * note: Will be used to authenticate against our Firebase database of users.
12. Define a static function ```createUser``` that takes an email, username, password, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
    * note: Will be used to create a user in Firebase.
13. Define a static function ```updateUser``` that takes a user, username, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
14. Define a static function ```logOutCurrentUser``` that takes no parameters.
15. Define a static function ```mockUsers()``` that returns an array of sample users.
16. Implement the ```mockUsers()``` function by returning an array of at least 3 initialized users
17. Use the ```mockUsers()``` function to implement staged completion closures in the rest of your static functions with completion closures.
18. Update the initialization of the ```currentUser``` to the result of the first mock user.

### PostController

Create a ```PostController``` model object controller that will manage and serve ```Post``` objects to the rest of the application. The ```PostController``` will also handle managing comments and likes. As you write each function, consider how you would approach writing the implementation, consider writing comments on the steps you would take to compare to later instructions.

1. Create a ```PostController.swift``` file and define a new ```PostController``` class inside.
2. Define a static function ```fetchTimelineForUser``` that takes a user and completion closure with an array of ```Post``` object parameter.
3. Define a static function ```addPost``` that takes an image, optional caption, and completion closure with a success Boolean parameter and optional ```Post``` parameter.
4. Define a static function ```postFromIdentifier``` that takes an identifier and completion closure with optional ```Post``` parameter.
5. Define a static function ```postsForUser``` that takes a ```User``` and completion closure with optional array of ```Post``` objects parameter.
6. Define a static function ```deletePost``` that takes a ```Post```.
7. Define a static function ```addCommentWithTextToPost``` that takes a ```String```, ```Post```, and completion closure with a success Boolean parameter and optional ```Post``` parameter.
8. Define a static function ```deleteComment``` that takes a ```Comment``` and completion closure with a success Boolean parameter and optional ```Post``` parameter.
9. Define a static function ```addLikeToPost``` that takes a ```Post```, and completion closure with a success Boolean parameter and optional ```Post``` parameter.
10. Define a static function ```deleteLike``` that takes a ```Like``` and completion closure with a success Boolean parameter and optional ```Post``` parameter.
11. Define a static function ```orderPosts``` that takes an array of ```Post``` objects and returns a sorted array of ```Post``` objects. For now, return an empty array.
12. Define a static function ```mockPosts()``` function that returns an array of sample posts.
13. Implement the ```mockPosts()``` function by returning an array of at least 3 initalized posts.
    * note: Use a static string ```-K1l4125TYvKMc7rcp5e``` as the sample image identifier.
14. Use the ```mockPosts()``` function to implement staged completion closures in the rest of your static functions.

### ImageController

Create an ```ImageController``` that will manage and serve images to the rest of the application. The ```ImageController``` will also handle uploading and downloading photos, and add an extension on UIImage that allows converting the image to and from Base 64 encoded strings. As you write each function, consider how you would approach writing the implementation, consider writing comments on the steps you would take to compare to later instructions.

1. Create a ```ImageController.swift``` file and define a new ```ImageController``` class inside.
2. Define a static function ```uploadImage``` that takes an image and completion closure with an identifier ```String``` parameter.
    * note: We use an identifier for the image instead of a URL because we are uploading to Firebase. If we were uploading to Amazon S3 or other cloud service, we would probably return a URL instead of identifier.
3. Implement a mock response by calling the completion closure with ```-K1l4125TYvKMc7rcp5e``` as the identifier.
4. Define a static function ```imageForIdentifier``` that takes an identifier (String) and completion closure with an optional UIImage parameter.
5. Implement a mock response by returning a UIImage named "MockPhoto"
6. Add a sample photo to the ```Assets.xcassets``` folder named ```MockPhoto``` for you to use as staged data.

### Black Diamonds


### Tests


## Part Two - Wire Up Views

* build a reusable login/signup view controller
* implement a collection view based master-detail interface
* implement a search controller

Build the login/signup view controller, the profile view, and the user list/search controller that will be used to list friends and search users to add as friends. Do not focus too much time on polishing the views. The purpose of wiring up view controllers is to get things functional.

### Signup / Login Picker View

This is the first view that the user will see of our application. We want it to briefly describe the app and present the option for the user to Sign Up or Log In. There are many ways to lay out this view. The steps below are simply one way to do so. Experiment with stack views and autolayout to get a pleasing view. Use the Storyboard Preview feature to see your changes on various device sizes.

##### Storyboard Setup

1. Add a vertical stack view that will hold our labels and buttons, constrain it to the leading and trailing margins, 44 points from the top, and at least 225 points from the bottom.
    * note: Because resizing a view based on keyboard presence is outside the scope of this project, we add a 225 point margin to the bottom to allow space for the keyboard.
    * note: To keep the bottom of the ```UIStackView``` at least 225 points from the bottom, but allow it to be further if the content allows for it, adjust the priority of the bottom constraint to 750.
2. Add a ```UILabel``` with the word 'Timeline' in big, bold text.
3. Add a ```UILabel``` with a short description for the app in smaller text.
4. Move your 'Sign Up' and 'Log In' buttons from Part 1 into the ```UIStackView``` and embed them in a horizontal stack view to place them side by side.

We will implement the code for this view after setting up the Signup / Login View scene.

### Signup / Login View

Build a view to manage signup and login features for the application. The view will have two modes: Signup and Login. When in Signup mode, we will display all fields required to sign up a new user. When in Login mode, we will programmatically remove unnecessary fields. 

1. Add a vertical stack view that will hold our labels and buttons, constrain it to the leading and trailing margins, 44 points from the top, and at least 225 points from the bottom.
    * note: Because resizing a view based on keyboard presence is outside the scope of this project, we add a 225 point margin to the bottom to allow space for the keyboard.
    * note: To keep the bottom of the ```UIStackView``` at least 225 points from the bottom, but allow it to be further if the content allows for it, adjust the priority of the bottom constraint to 750.
2. Add a ```UITextField``` with placeholder text 'Username*'.
3. Add a ```UITextField``` with placeholder text 'Email*'.
4. Add a ```UITextField``` with placeholder 'Password*'.
    * note: Password fields should be set to 'Secure Text Entry' so that text is obscured.
5. Add a ```UITextField``` with placeholder 'Bio'.
6. Add a ```UITextField``` with placeholder 'Website URL'.
7. Add a ```UIButton``` with title 'Action'.
    * note: The title of the button will be updated to 'Sign Up' or 'Log In' based on the mode.

##### Class Implementation

You will create outlets to all required elements for the view. You will implement an enum ```ViewMode``` with ```.Signup``` and ```.Login``` cases. You will respond to the ```ViewMode``` to determine what fields to display, the title for the action button, text input validation, and action implementation. You will add a ```fieldsAreValid``` calculated property that provides a validation check on the text fields. You will respond to invalid fields or failed attempts to create or authenticate an account with an alert.

1. Open the ```LoginSignupViewController.swift``` subclass of ```UIViewController``` and check that it is assigned to the associated scene in ```Main.storyboard```.
2. Add outlets for the usernameTextField, emailTextField, passwordTextField, bioTextField, urlTextField, actionButton.
3. Add a ```ViewMode``` enum with 'Login' and 'Signup' cases.
4. Add a ```mode``` property of ```ViewMode``` type, we will switch on this property to determine functionality, give it a default value of ```.Signup```.

Your view should follow the 'updateWith' pattern for updating the view elements with the details of the mode. 

5. Add an ```updateViewBasedOnMode``` function
6. Implement the 'updateWith' function to update all view elements to reflect the current mode.
    * note: Use a switch to determine the mode. Leave all fields for .Signup, remove unnecessary fields for .Login (username, bio, url).
    * note: Update the title of the 'Action' button.
7. Call the ```updateViewBasedOnMode()``` function in the ```viewDidLoad()``` function.

Add a calculated property that validates that there is text in the required text fields based on the mode.

8. Add a calculated property named ```fieldsAreValid``` that returns a Bool.
9. Implement the calculated property get by switching the mode, and returning true only if the required text fields are not empty.
    * note: Email and Password are required for logging in. Username, e-mail, and password are required for registering.
10. Add an ```actionButtonTapped``` action from the Action button.
11. Implement the ```actionButtonTapped``` by checking the fields are valid, switching on the mode, calling the applicable ```UserController``` functions, and responding to the closure parameters. Successful authentication or registration should dismiss the view controller. Unsuccessful authentication or registration should present an alert telling the user to try again.
    * note: Because you are presenting multiple alert views with potentially slightly different wording, consider creating a ```presentValidationAlertWithTitle(title: String, message: String)``` and implementing it to create and present the alert

##### Present the View if No Current User

Build a check on the ```UserController.currentUser()``` to present the Login / Signup Picker scene if there is no user logged in.

1. In the ```TimelineTableViewController.swift``` file, we will build the check since this will be the first view of the app.
2. Override ```viewWillAppear()```.
3. Implement the function to check if ```UserController.currentUser()``` is nil, if it is, perform the modal segue from the ```UITabBarController``` to the Login / Signup Picker scene, otherwise, load the timeline for the current user (set a property of an array of Posts).
    * note: Consider adding a check to see if the view already has posts, if so, skip reloading the view.
4. Test the sequence by returning ```nil``` from the ```UserController.currentUser()``` function.

##### Setting the Mode from the Choice Scene

1. Open the ```LoginSignupChoiceViewController.swift``` file and check that it is assigned to the associated scene in ```Main.storyboard```.
2. Add a ```prepareForSegue()``` function, use the segue identifier to determine what mode to set on the destination view controller.
    * note: You may need to add segue identifiers in ```Main.storyboard```.
3. Test your different modes to verify they work as expected, that the view is presented, and that the view is dismissed when the user successfully logs in or registers.

### User Search Table View

The User Search Table View will be used for any list of multiple users, and provide search functionality for that list. The default view will have the option to view current friends, or all users of the app, and search between both. Each user cell should segue to the profile view for that user.

1. Open the ```UserSearchTableViewController.swift``` subclass of ```UITableViewController``` and check that it is assigned to the associated scene in ```Main.storyboard```.
2. Add a ```usersDataSource``` property as an empty array of Users.
    * note: This array will hold the users that should be displayed in the table view. Only friends when displaying the friends list, all users when adding a friend.
3. Add a an outlet ```modeSegmentedControl``` for the segmented control.
4. Add a ```ViewMode``` Int type enum with 'Friends' and 'All' cases.
5. Add a calculated ```mode``` property of ```ViewMode``` type, return a ViewMode initialized with a rawValue from the selected segment index on ```modeSegmentedControl```.

Add functionality to the ViewMode that you can use to fetch the correct set of ```User``` objects. We will use this in our ```updateViewForMode``` to set the ```usersDataSource``` array with either friends, or all users. 

6. Add a function to the ViewMode enum called ```users``` that takes a completion closure with an optional array of users as a parameter.
    * note: All calls to the network should be asynchronous, so we will need to call this method and then set the ```usersDataSource``` after the results are returned via completion closure.
7. Implement the function by switching on the enum, performing the appropriate ```UserController``` function, and running the completion block with the returned users.

Your view should follow the 'updateWith' pattern for updating the view elements with the details of the mode.

8. Add an ```updateViewBasedOnMode()``` function.
9. Implement the 'updateWith' function to call the ```mode.users()``` function, implement the completion block to set the ```usersDataSource``` to the results, handle the case in which there are no results, and then reload the tableview with the updated array.
10. Call the ```updateViewForMode()``` function in the ```viewDidLoad()``` function.
11. Add an IBAction ```selectedIndexChanged``` for the segmented control that updates the view with the newly updated mode.

Now that you have an array of ```User``` objects you can implement the required ```UITableViewDataSource``` functions to display usernames.

12. Implement the ```numberOfRowsInSection``` by returning the count of displayed users.
13. Implement the ```cellForRowAtIndexPath``` by capturing the ```User``` and setting the textlabel of the cell to the username.

Check the view for functionality, you should get different results, if you return different results from your ```followedByUser()``` function.

##### Search Controller Implementation

Search controllers typically have two views: a list view, and a search result view that displays the filtered results. You must create a 'search results view' that is overlayed on top of your list view when the search bar is actively editing, and then your main list view handles a ```SearchResultsUpdating``` protocol function that updates the results view.

Understanding Search Controllers requires you to understand that the main view controller can (and must) implement methods that handle what is being displayed on another view controller. The results controller must also implement a way to communicate back to the main list view controller to notify it of events. This two way relationship with communication happening in both directions.

Add the Search Results Controller

1. Add a ```UITableViewController``` Search Results scene to ```Main.storyboard``` and assign the scene a storyboard identifier.
2. Create a ```UserSearchResultsTableViewController.swift``` subclass of ```UITableViewController``` and assign it to the newly created scene in ```Main.storyboard```.
3. Add a ```usersResultsDataSource``` property as an empty array of Users.
    * note: This array will hold the users that should be displayed as search results, this array will be updated by our main list view controller when the user updates the search field.
4. Implement the ```numberOfRowsInSection``` by returning the count of displayed users.
5. Implement the ```cellForRowAtIndexPath``` by capturing the ```User``` and setting the textlabel of the cell to the username.

Add the ```UISearchController``` to the UserSearchTableViewController

6. Add a function ```setUpSearchController()``` that will initialize and assign settings to the ```UISearchController```.
7. Add an implicily unwrapped property of ```UISearchController```.
8. Implement the function by capturing an instance of the Search Results scene as a ```resultsController``` in ```Main.storyboard``` using the scene's storyboard identifier, initializing the ```UISearchController``` with the the ```resultsController```, setting the ```searchResultsUpdater``` to self, sizing the search bar, and setting the search controller's search bar as the header of the ```tableView```.
9. Call the ```setUpSearchController()``` function in the ```viewDidLoad()```.
10. Adopt the ```UISearchResultsUpdating``` protocol and add the required ```updateSearchResultsForSearchController(searchController: UISearchController)``` function.
11. Implement the ```UISearchResultsUpdating``` function by capturing the text in the search bar and assigning the search controller's ```usersDataSource``` to a filtered array of ```User``` objects where the username contains the search term, then reload the result view's ```tableView```.
    * note: You may want to convert the search term and usernames to lowercase using ```.lowercaseString``` to avoid case sensitive search results.

##### Segue to the Profile View

1. Open the ```ProfileViewController.swift``` file and add an optional ```User``` property that will be set in the inbound ```prepareForSegue``` function.
2. Open the ```UserSearchTableViewController.swift``` and add/uncomment a ```prepareForSegue``` function.
3. Implement the function by casting the sender to a UITableViewCell, capturing the indexPath of the cell, capturing the selected user, capturing and casting the destination view controller as a ```ProfileViewController```, and assigning user to the destination view controller's property.
4. Temporarily add a ```print(user)``` to the ```viewDidLoad``` function of the ```ProfileViewController``` to see that the user has correctly been assigned.

Run the application and identify the issue you will solve next by navigating to the Profile View via the User List. Try again using the Search Results. Consider why this doesn't work, and what avenues you could take to fix it.

The user should be able to select a user to view the Profile view for that user in both the regular list view and the search detail view. Implementing a segue from the Search Results view will only present the Profile View modally, not using the ```UINavigationController``` to push the view. You will implement the segue, then use the ```UITableViewDelegate``` function ```didSelectRowAtIndexPath``` to manually perform the segue on the main list view. 

5. Open the ```UserSearchResultsTableViewController.swift``` file and add the ```UITableViewDelegate``` function ```didSelectRowAtIndexPath```.
6. Implement the function by capturing the sending cell and telling it's ```presentingViewController``` to perform the segue manually.
    * example: ```self.presentingViewController?.performSegueWithIdentifier("toProfileView", sender: sender)```
One more step to get the segue working as expected. You need to update the ```prepareForSegue``` function to get the correct ```User``` to the ```ProfileViewController```. Try to work through the problem without looking at the solution code.

7. Update the ```prepareForSegue``` function in ```UserSearchTableViewController``` to check if ```self.tableView``` can get an ```indexPath``` for the sender. If it can, that means that the cell was from ```self.tableView``` and we can capture the user from ```usersDataSource``` using the index path. If it cannot get an indexPath from ```self.tableView```, then the cell is from the table view that lives on the ```searchResultsController```. If that is the case, capture the user from the ```usersResultsDataSource``` on the ```searchResultController```.
    * note: You can access the ```searchResultsController``` by calling ```(searchController.searchResultsController as! UserListSearchResultsTableViewController)```. 

### Profile View

Build a view to display details about any user of the app. The view will also allow the ```currentUser``` to update their profile photo, bio, or url. 

##### Collection View Section Header

1. Add a Collection View to the ```ProfileViewController``` scene in ```Main.storyboard```.
2. Add a Collection Reusable View in the collection view.
3. Assign ProfileViewController (self) as the ```datasource``` and ```delegate``` of the collection view.
4. Design the Collection Reusable View using a ```UIStackView``` to display a bio label, a homepage button, and a follow user button.
5. Assign a reuse identifier to the reusable view.
6. Create a ```ProfileHeaderCollectionResuableView.swift``` subclass of ```UICollectionReusableView``` and assign it to the associated view in ```Main.storyboard```.
7. Add IBOulets for the bioLabel, urlButton, and followUserButton.
8. Add a ```updateWithUser(user: User)``` function.
9. Implement the function to set the title and bioLabel, remove labels if the user doesn't have an associated value, sets the title of ```followUserButton``` based on whether the current user is following, removes the ```followUserButton``` if the user is the ```currentUser```.
10. Define a ```ProfileHeaderCollectionReusableViewDelegate``` protocol with required functions for ```userTappedFollowActionButton``` and ```userTappedURLButton```.
11. Add an optional delegate property.
12. Add IBActions ```urlButtonTapped``` and ```followActionButtonTapped```.
13. Implement the action functions by calling the appropriate function on the delegate.

##### Set up the Image Cell

1. Assign a reuse identifier for the included cell.
2. Add a ```UIImageView``` that fills the cell.
3. Create a ```ImageCollectionViewCell.swift``` subclass of ```UICollectionViewCell```.
4. Add an outlet ```imageView``` for the image view.
5. Add a function ```updateWithImageIdentifier(identifier: String)```.
6. Implement the function to use the ImageController to get the image matching the identifier, assign the image to the image view in the completion closure.

##### Collection View DataSource

1. In the ```ProfileViewController```, add a ```userPosts``` property as an empty array of ```Post``` objects.
    * note: This array will hold the posts that should be displayed in the collection view.
2. Add a ```updateBasedOnUser``` function.
3. Implement the function by setting the title of the view, using the ```PostController``` to fetch the posts for the user, assigning the ```userPosts``` to the results, and reloading the collection view in the completion closure.

Now that you have an array of ```userPosts``` you can implement the required ```UICollectionViewDataSource``` functions to display the posts, and update the Header View with the current user.

4. Implement the ```numberOfItemsInSection``` by returning the count of ```userPosts```.
5. Implement the ```cellForItemAtIndexPath``` by dequeing a ```ImageCollectionViewCell```, capturing the ```Post``` at the indexPath, and calling the ```updateWithImageIdentifier``` function with the correct endpoint.
6. Implement the ```viewForSupplementaryElementOfKind``` by dequeing the ```ProfileHeaderCollectionReusableView``` and calling the ```updateWithUser``` with the Profile View's ```User``` property.

Use the ```ProfileHeaderReusableViewDelegate``` to implement functionality for the 'URL' and 'Follow' buttons

7. Adopt the ```ProfileHeaderReusableViewDelegate``` protocol on the ```ProfileViewController```.
8. Implement the ```userTappedURLButton``` function to initialize and present a ```SafariViewController``` to the profile url.
9. Implement the ```userTappedFollowActionButton``` to use the ```UserController``` to determine if the current user follows the user, appropriately follow or unfollow the user, and update the view with the updated user.
    * note: You have to define a static function ```unfollowUser``` (on UserController) that takes a user and a completion closure with a success Boolean parameter.
10. Update the ```viewForSupplementaryElementOfKind``` datasource function to set the ```ProfileHeaderCollectionReusableView``` delegate.

##### View Hierarchy Details

1. When we set up the View Hierarchy in Part 1, you may have created a segue from the Profile View to the Post Detail View. If so, Delete that segue. Create/Recreate it from the collection view cell in ```Main.storyboard```.
2.  The profile view is displayed within a Navigation Controller when accessed through the User List / Search View, but MAY not when accessed as the third tab in our ```UITabBarController```. If not, add a ```UINavigationController```, set the ```ProfileViewController``` as it's root view controller, and update the ```UITabBarController``` relationship segue to point to the ```UINavigationController```.
3. Update the ```viewDidLoad``` function to check ```self.user``` for nil, if it is, assign the current user to the value.

##### Enable Profile Editing for Current User

Build functionality for the user to update their profile using the Login/Signup View we built earlier.

Update the Login / Signup View to support updating a ```User```.

1. Open the ```LoginSignupViewController.swift``` file.
2. Add a ```ViewMode``` case 'Edit'.
3. Update the ```fieldsAreValid``` calculated property so that the ```.Edit``` validates the presence of text in the ```usernameField```.
    * note: this is the only field we need to validate as it is the only required method. (email and password will be hidden, bio and url are optional)
4. Add an optional ```user``` property.
5. Update the ```actionButtonTapped``` function to add a case for ```.Edit``` that uses the ```UserController``` to update the user with the current values and handles success or failure by dismissing the view or presenting a validation alert.
6. Add a ```updateWithUser``` function.
7. Implement the function to set ```self.user```, set the ```ViewMode``` to ```.Edit```.
8. Update the ```updateViewBasedOnMode``` function for the new mode.

Update the Profile View Controller to support Editing

1. Open the Profile View Controller scene in ```Main.storyboard```.
2. Add a ```UIBarButtonItem``` to the navigation bar. Use system item 'Edit'. Set to disabled.
    * note: You may need to add a ```UINavigationItem```. 
3. Add a modal presentation segue from the 'Edit' button to the Login/Signup View with ```toEditProfile``` identifier
4. Implement the ```prepareForSegue``` by checking the segue identifier, capturing the destination view controller, and updating with the user.
5. Override the ```viewDidAppear``` to update the user from Firebase and reload the view with that data.
    * note: Since our view for UserController.userForIdentifier always returns our first mock user, you may get some funky results when going to this view by clicking on a different user.
6. In the ```viewDidLoad```, where you check if user is nil, after setting the user property to currentUser, enable the bar button item.

Consider how you could modify these steps to be more efficient in relying on network requests.

##### Logging Out

Add functionality for the current user to log out.

1. In the ```ProfileHeaderCollectionReusableView```, use the follow button as a logout button if the user is equal to the currentUser. Set the title appropriately.
2. In the implementation of the ```userTappedFollowActionButton()``` delegate method, check if the user is equal to the currentUser. If so, log out the current user and send the user to the first view controller in the tab bar. If not, it should do the appropriate follow/unfollow action.

## Part Three - Wire Up Views (contd)

* implement a complex UITableView with multiple cell types and sections
* implement multiple custom table view cells with delegate pattern
* use an image picker to access and work with photos
* use an accessory editing view as a text field and send button

### Timeline View

The Timeline view is the most important view of the application. This is where people will see and like the photos. Each cell will represent one post and will display the photo, user, number of comments, and number of likes. Be creative but follow sound design principles in how you display each post in the cell.

##### Custom Post Cell

1. Design the cell in ```Main.storyboard``` to display the image prominently, include labels for the number of likes and number of comments.
    * note: Consider displaying the photo as the full background of the cell, use a Stack View to place the labels.
    * note: Consider the Content Mode and choose one that will work for most images, you can address this later in the polish portion.
2. Add a ```PostTableViewCell.swift``` subclass of ```UITableViewCell``` and assign it as the class for the cell on our Timeline scene.
3. Add outlets for the ```postImageView```, ```likesLabel``` and ```commentsLabel```.
4. Add a ```updateWithPost(post: Post)``` function.
5. Implement the function by assigning values to the labels and using the ImageController to fetch the image, assign the result to the image view in the completion closure.

##### Timeline DataSource

1. Open the ```TimelineTableViewController.swift``` subclass of ```UITableViewController``` and check that it is assigned to the associated scene in ```Main.storyboard``` 
2. Add a variable ```posts``` that will hold the posts for the Timeline.
3. Add a function ```loadTimelineForUser``` that takes a ```User``` as a parameter.
4. Implement the function by using the ```PostController``` to fetch timeline for the user, setting the results to ```self.posts```, and reloading the view when completed.
5. Update the ```viewDidLoad()``` function to call ```loadTimelineForUser``` if there is a current user.
    * note: Keep the previously written code, we still need to present the Login view if there is no current user.
6. Implement the ```numberOfRowsInSection``` by returning the count of posts.
7. Implement the ```cellForRowAtIndexPath``` by dequeing a ```PostTableViewCell```, capturing the ```Post```, and calling the ```updateWithPost(post: Post)``` function on the cell.

##### Pull to Refresh

Implement 'Pull to Refresh' functionality on your ```TimelineTableViewController```

1. Select the scene in the Document Outline in ```Main.storyboard```.
2. Enable refreshing in the Attributes Inspector under Table View Controller.
3. Add an IBAction ```userRefreshedTable``` for the Refresh Control now visible in your Document Outline.
4. Implement the action by fetching an updated timeline from the ```PostController```.
    * note: You must tell the refresh control to ```endRefreshing``` when the view is done loading.

### Post Detail View

Build a Post Detail View that displays the post. It should display the photo and the comments. The view should also allow the user to post comments or add likes to the post. 

1. Open the ```PostDetailTableViewController.swift``` subclass of ```UITableViewController``` and check that it is assigned to the associated scene in ```Main.storyboard```. 
2. Add a Header view to the ```UITableView``` with a similar layout to the ```PostTableViewCell```.
    * note: Some photos may expand beyond this header view, choose the 'Clip Subviews' option in the Attribute Inspector.
3. Add a subtitle prototype cell with a Username label and Comment label that will display the details of each comment.
4. Add a button as a footer view titled 'Add Comment'.
5. Add a ```UINavigationItem``` with a Bar Button Item titled 'Like'.
6. Add IBOutlets for the ```headerImageView```, ```likesLabel```, and ```commentsLabel```.
7. Add a property of ```Post?``` to the view controller.
8. Add a function ```updateBasedOnPost()```.
9. Implement the function by updating the ```likesLabel```, ```commentsLabel```, using the ```ImageController``` to set the ```headerImageView``` and reloading the table view.
10. Call ```updateBasedOnPost()``` in ```viewDidLoad()```.
11. Add an IBAction ```likeTapped``` from the 'Like' button.
12. Implement the ```likeTapped``` function by using the ```PostController``` to add a ```Like``` to the post, update the view with the updated post in the completion closure.
13. Add an IBAction ```addCommentTapped``` from the 'Add Comment' button.
14. Implement the ```addCommentTapped``` function to present a ```UIAlertController``` with a textfield, an 'Add Comment' action, and a 'Cancel' action.
15. Implement the 'Add Comment' action to use the ```PostController``` to add a comment, update the view with the updated post in the completion closure.
16. Implement the ```numberOfRowsInSection``` by returning the count of comments on ```self.post```.
17. Implement the ```cellForRowAtIndexPath``` by dequeing a ```PostCommentTableViewCell```, capturing the ```Comment```, and calling the ```updateWithComment(comment: Comment)``` function on the cell.

##### Segues to Post Detail View

1. Add a ```prepareForSegue``` function to the ```TimelineTableViewController.swift``` file
2. Implement the function by capturing the ```indexPath```, selected ```Post```, ```destinationViewController```, and updating the ```destinationViewController``` with the selected post.
3. Add a ```prepareForSegue``` function to the ```ProfileViewController.swift``` file.
4. Implement he function by capturing the ```indexPath```, selected ```Post```, ```destinationViewController```, and updating the ```destinationViewController``` with the selected post.

### Add Post View

Build a view for creating and submitting a post. The view should have a way to select a photo using the ```UIImagePickerController```, adding a caption, and submitting. You will use a static table view with a header and footer to create this form. This is not the only way to build this view, but is an appropriate use for a static ```UITableView```.

You will use a button as the header view to allow the user to select a photo. When the user has chosen a photo, display it using the button's background image property and set the title to an empty string.

You will use a static cell with a text field for capturing the caption for the post, and a 'Submit' button as the footer for the table view.

1. Update the table view to use static cells.
2. Add a button as the header for the table view titled 'Add Photo'.
    * note: Update the title and font size, make the view larger so that the user can see the photo.
3. Remove any additional table view cells, add a text field that fills the cell, provide context to the user with placeholder text.
4. Add a 'Submit' button as the footer to the table view.
5. Add a 'Cancel' button as the left bar button item.
6. Add IBOutlets for the 'Add Photo' button and caption text field.

##### Add Photo

Add a property for storing the image for the post, present a ```UIImagePickerController```, and update the 'Add Photo' button to display the image.

7. Add an optional ```self.image``` property to capture the selected image for the post.
8. Add an IBAction ```addPhotoButtonTapped``` to the ```AddPhotoTableViewController.swift``` file.
9. Implement the function by instantiating a ```UIImagePickerController```, setting it's delegate, presenting an alert to the user to choose 'Photo Library' or 'Camera', setting the ```sourceType``` of the picker controller, and presenting it.
9. Adopt the ```UINavigationControllerDelegate``` and ```UIImagePickerControllerDelegate``` protocols.
10. Implement the ```UIImagePickerControllerDelegate``` function ```didFinishPickingMediaWithInfo``` to dismiss the picker view controller, capture the selected image into the ```self.image``` property, and updating the background image of the photo button.

##### Capture the Caption

Follow the same pattern you used for the ```self.image``` property by capturing the value when the user stops editing the caption text field.

11. Add an optional ```caption``` property to capture the text when the user finishes updating the cell.
12. Adopt the ```UITextFieldDelegate``` protocol, set the delegate of the text field, and implement the ```textFieldShouldReturn``` function to set the ```caption``` property and ```resignFirstResponder```.

##### Submitting the Post

13. Add an IBAction ```submitButtonTapped``` from the 'Submit' button.
14. Implement the function by checking for a value in ```self.image```, if there is an image, use the ```PostController``` to add a post with the image and caption, if there isn't an image, present an alert to the user asking them to check and try again.
15. Handle the ```PostController``` unsuccessfully uploading the image by presenting an alert to the user asking them to try again.

##### Cancel Button

16. Add an IBAction ```cancelButtonTapped``` from the 'Cancel' button.
17. Implement the function by dismissing the view controller.


### Black Diamonds

* fix the content mode of the 'Add Photo' button to use .ScaleAspectFill
* add 'double tap to like' functionality to the cell
* make the post view a live view by observing the post

### Tests


## Part Four - Implement Controllers

* use Firebase as a backend for storing and pulling model objects
* implement the Firebase controller and model object controllers to work with live data
* implement a custom protocol for Firebase model objects, controllers, and live updating views

It is time to implement actual funtionality for our controller objects. You will import the Firebase library into the application, create a reusable ```FirebaseController``` helper class that will perform basic Firebase interactions for authentication and fetching and pushing data, and get the model objects ready to save to Firebase by writing and implementing a ```FirebaseType``` protocol.

### Add Firebase to the Project

Install the Firebase iOS SDK by manually including the ```Firebase.framework``` and its dependencies in the project.

1. Open the [iOS Alternative Setup](https://www.firebase.com/docs/ios/alternate-setup.html) documentation.
2. Follow the steps to download the framework and add dependencies to the project.
    * note: As of Xcode 7.1, .dylib is now .tbd when referencing dependencies and linked frameworks.
3. Create a new App in Firebase with a unique subdomain of your choice to use for the project.

### FirebaseController

Create a reusable ```FirebaseController``` class that will provide basic fetching features. If written correctly, the only reference to your current project will be the ```base``` property that references the URL on Firebase for your application. Everything else will be migratable and reusable in other projects you build. Add to your ```FirebaseController``` over time with the most reused features.

1. Create a new ```FirebaseController.swift``` class and define a new ```FirebaseController``` class.
2. Import Firebase.
3. Add a new class property ```base``` that returns a ```Firebase``` from your URL.
4. Add a static function ```dataAtEndpoint(endpoint: String, completion: (data:AnyObject?) -> Void)``` that will fetch data from an endpoint and return it via completion closure.
5. Implement the function to create a new Firebase reference with the endpoint string, observe a single event, and run the completion closure when the data has returned.
    * note: Check to see if the data is NSNull before running the completion. This will determine what you pass to the closure's parameter.
6. Add a static ```observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void)``` that will observe data from and endpoint and run the completion closure each time the data at that endpoint changes.
7. Implement the function to create a new Firebase reference with the endpoint string, observe an event, and run the completion closure when the data has returned.
    * note: Check to see if the data is NSNull before running the completion.

Note that these functions are not necessary, but will save you two lines of code each time you want to fetch or observe data in Firebase. You can build your ```FirebaseController``` over time to be more useful to you as you recognize patterns of what you do repeatedly in Firebase that can be abstracted to this helper class.

##### Define the Protocol

The ```FirebaseController.swift``` file is the perfect place to add more Firebase specific code that will help you write the rest of the application. Write a ```FirebaseType``` protocol that will normalize and enforce the way model objects are built to save and pull from Firebase. Before writing the protocol, consider everything that you would require a model object to have to work seamlessly with Firebase.

There are 4 or 5 required properties or functions, depending on your specific implementation, that you will want to include:

* ```identifier```
* ```endpoint```
* ```secondaryEndpoints``` (depends on implementation and architecture)
* ```jsonValue```
* ```init?(json: [String: AnyObject])``` (because of the way we've structured our data in this specific app, we will use ```init?(json: [String: AnyObject], identifier: String)```)

With these 5 required properties/functions, we can implement a couple of great features with default protocol implementations. You will implement two:

* ```save()```
* ```delete()```

1. Add a protocol definition for ```FirebaseType``` at the bottom of the ```FirebaseController.swift``` file.
2. Add an optional gettable and settable ```identifier:[String]?``` property.
    * note: The identifier will be used to identify the object on Firebase, and when nil, tells us that the object has not yet been saved to Firebase.
3. Add a gettable ```endpoint: String``` property.
    * note: The endpoint will determine where the object will be saved on Firebase.
4. Add a gettable ```jsonValue: [String, AnyObject]``` property.
    * note: A JSON representation of the object that will be saved to Firebase.
5. Add a faillable ```init?(json: [String: AnyObject] identifier: String)``` function.
    * note: Any instance initialized with json will come from Firebase, and will require an identifier so we know it already exists on Firebase.
6. Add a ```mutating func save()``` function.
7. Add a ```func delete()``` function .

##### Extend the Protocol

Using protocol extensions in Swift, we can require functions and provide default implementations for those functions for any type that conforms to the protocol.

1. Define an extension to FirebaseType at the bottom of the ```FirebaseController.swift``` file.
2. Add a mutating ```save()``` function.
3. Implement the function by checking for an identifier, if there is an identifier, instantiate a Firebase reference to the endpoint with that identifier, otherwise instantiate a Firebase reference to the endpoint with a ```.childByAutoID()```, and assign the identifier to the key of that base, once you have a reference to where the object should be saved, use the ```updateChildValues()``` function with the ```jsonValue``` of the object.
4. Add a ```delete()``` function.
5. Implement the function by instantiating a Firebase reference to the object, use the ```removeValue()``` function to delete it from Firebase.


### Adopt the FirebaseType Protocol

Adopt the ```FirebaseType``` protocol in each of your model objects. Use the included sample JSON to build your ```jsonValue``` calculated properties and ```init?(json: [String: AnyObject], identifier: String)``` initializers.

##### Comment

Example:

```
"-K28xPOXBBXdCrFx-EAY" : {
    "post" : "-K25Fj8qrMAtxXG3QCSn",
    "text" : "I'd love to cliff dive off that.",
    "username" : "calebhicks"
}
```

1. Add private String keys for "post", "username", and "text".
2. Assign a value for a computed ```endpoint``` property. Look at the example:

```
var endpoint: String {
    
    return "/posts/\(self.postIdentifier)/comments/"
}
```

Saving the ```jsonValue``` to this endpoint will put it under the post that it belongs to on Firebase.

3. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```postIdentifier```, ```user```, and ```text```.
4. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.

##### Like

Example:

```
"-K28OeV3MmD0l9DbNufW" : {
    "post" : "-K25Fj8qrMAtxXG3QCSn",
    "username" : "calebhicks"
}
```
.
1. Add private String keys for "post" and "username".
2. Assign a value for a computed ```endpoint``` property that saves the ```Like``` to the post, similar to the ```endpoint``` for ```Comment```.
3. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```postIdentifier``` and ```username```.
4. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.


##### Post

Example: 

```
"-K25Fj8qrMAtxXG3QCSn" : {
  "username" : "hansolo",
  "imageEndpoint" : "-K25Fj8p2ArUMz3awt3T",
  "comments" : {
    "-K28xPOXBBXdCrFx-EAY" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "text" : "I'd love to cliff dive off that.",
      "username" : "calebhicks"
    },
    "-K28xzlhs8ArmgB6bcCB" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "text" : "Who wants in?",
      "username" : "calebhicks"
    }
  },
  "likes" : {
    "-K28OeV3MmD0l9DbNufW" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "username" : "calebhicks"
    },
    "-K28xx1BC5pnQNXDxym6" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "username" : "calebhicks"
    }
  }
}
```

1. Add private String keys for "username", "imageEndpoint", "caption", "comments", and "likes".
2. Conform to the ```FirebaseType``` protocol.
3. Assign a value 'posts' for ```endpoint```.
    * note: ```Post``` objects are not saved under any other object, so it has it's own independent endpoint.
4. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```username```, ```imageEndpoint```, ```comments```, ```likes```, and optionally add the ```caption``` if it exists.
    * note: Map the Comments and Likes to dictionaries (ex. ```CommentsKey: self.comments.map({$0.jsonValue})```).
5. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.
    * note: Map the Comment and Like dictionaries to initialized model objects, use flatMap() to filter out any nil optional initialized objects.
    * note: Consider the included sample solution below, break each line down, look in the documentation to understand what each part is doing.

```
if let commentDictionaries = json[CommentsKey] as? [String: AnyObject] {
    self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
} else {
    self.comments = []
}
```

##### User

Example:

```
"17c014cb-5cc1-4884-977b-471482d9e484" : {
    "bio" : "I wear fancy pants. ",
    "follows" : {
        "c6c2fbe1-c86c-4b47-a78b-5d991c8f19fb" : true,
        "f8270303-6656-453a-a2e6-8c5eeece73b7" : true
    },
    "url" : "http://calebhicks.com/",
    "user" : "calebhicks"
}
```

1. Add private String keys for "username", "bio", and "url".
2. Assign a value 'users' for ```endpoint```.
3. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```username```, optionally include the ```bio``` and ```url```, if they exist.
4. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.


### PostController Implementation

The ```PostController``` is a crucial piece to the application. Do your best to write the implementation for each function with only the description here. Sample solution code is available, but should only be used after trying your best to implement each function. Each function takes parameters and returns others, do your best to translate the inputs into the outputs. 

1. Implement the ```addPost``` function to use the ```ImageController``` to upload an image, use the closure identifier to initialize a post, save it, and call the completion closure.
2. Implement the ```postFromIdentifer``` function to use the ```FirebaseController``` to fetch data for the post (ex. ```"posts/\(identifier)"```), unwrap the data, initialize the post, and call the completion closure.
3. Implement the ```postsForUser``` function to create a ```Firebase``` reference query to all posts where "username" is equal to the username passed into the function, unwrap the optional data, flatMap the dictionaries into ```Post``` objects, order the posts, and call the completion closure.
    * note: Watch out for the auto closure completion Xcode creates for Firebase observe functions, it oftentimes will choose a different syntax than works.
    * note: The master dictionary will contain child dictionaries that map to Posts. Use tuple accessors to correctly grab the identifier and child dictionary to map, ask for help if you do not understand the syntax.
4. Implement the ```deletePost``` function by deleting the post.
5. Implement the ```addCommentWithTextToPost``` to check for a postIdentifier (if none, save the post, thereby getting a postIdentifier), initialize a ```Comment```, save the comment, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
6. Implement the ```deleteComment``` function to delete the comment, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
7. Implement the ```addLikeToPost``` to check for a postIdentifier, initialize a ```Like```, save the like, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
8. Implement the ```deleteLike``` function to delete the like, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
9. Implement the ```orderPosts``` function to return a sorted array using the identifier of the ```Post``` object.
    * note: Firebase creates the unique identifiers by using a timestamp, so sorting by the identifier sorts by timestamp.
    * note: This function is particularly useful in the ```fetchTimeline``` function that appends ```Post``` objects from different users, this function sorts them back into order by time.

* note: You should not expect to see a great difference in your app functionallity today.

## Part Five - Implement Controllers

* upload photos to Firebase as base64 strings
* asynchronously download photos to display
* authenticate users anonymously or via e-mail

### PostController

The ```PostController``` has one more function we need to implement, ```fetchTimelineForUser```.  First, you will need to get all of the user the current user is following. Second, for each of those users, you'll need to fetch their posts. Third, you should fetch all of the current users posts. (If the user uploads an image, they should see it on their own timeline.) Use [dispatch groups](http://commandshift.co.uk/blog/2014/03/19/using-dispatch-groups-to-wait-for-multiple-web-services/) to be notfied when all of your asyncronous calls are complete.

1. Implement the ```fetchTimelineForUser()``` by first calling ```followedByUser```. In the completion closure, create an array the will hold all the posts and a dispatch group.
2. Enter the dispatch group. Call ```postForUser``` to fetch the current users posts. Once the post have been fetched leave the dispatch group.
3. For each user that is being followed, enter the dispatch group, fetch their posts, then once the posts have been returned, leave the dispatch group.
4. When the dispatch group notifies it has completed, order the posts and call the completion closure. 

### UserController Implementation

The ```UserController``` is a crucial piece to the application. Do your best to write the implementation for each function with only the description here. Sample solution code is available, but should only be used after trying your best to implement each function. Each function takes parameters and returns others, do your best to translate the inputs into the outputs. 

1. Add a private ```kUser``` for use with ```NSUserDefaults``` and the ```currentUser``` calculated property.
2. Implement the ```currentUser``` computed property to use a ```get``` and ```set``` to push and pull from ```NSUserDefaults```. ```get``` should guard against the ```uid``` on the ```FirebaseController.base.authData``` property and a userDictionary from ```NSUserDefaults```, and return a User created from the results. ```set``` should unwrap the ```newValue```, if it exists, save it to ```NSUserDefaults```, if it does not, remove it from ```NSUserDefaults```.

```
var currentUser: User! {
    get {
        
        guard let uid = FirebaseController.base.authData?.uid,
            let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(UserKey) as? [String: AnyObject] else {
                
                return nil
        }
        
        return User(json: userDictionary, identifier: uid)
    }
    
    set {
        
        if let newValue = newValue {
            NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: UserKey)
        } else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(UserKey)
        }
    }
}

```

3. Implement the ```userForIdentifier``` function to fetch data at the endpoint for the user, unwrap the data, initialize the ```User```, and call the completion.
4. Implement the ```fetchAllUsers``` function to fetch all data at the "users" endpoint, unwrap the optional data, flatMap the dictionaries into ```User``` objects, and call the completion closure.
5. Implement the ```followUser``` function to create a Firebase reference to the endpoint for followed users ("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)"), set ```true``` to that endpoint, and call the completion closure.
6. Implement the ```unfollowUser``` function to do remove the value at the followed user endpoint.
7. Implement the ```userFollowsUser``` function to check if there is a value at the followed user endpoint and call the appropriate completion closure.
8. Implement the ```followedByUser``` function to fetch identifiers for all followed users, unwrap the optional data, create a holding array for users, loop through the identifiers to call the ```userForIdentifier``` function, append each user, and call a completion closure.
    * note: This implementation may be inefficient and potentially cause issues. Consider how you could better approach this problem. Experiment with potential solutions.
9. Implement the ```authenticateUser``` function to ```authUser``` on the ```FirebaseController.base``` reference, if you successfully authenticate, fetch the user using the identifier, and set the ```currentUser``` property on ```sharedController``` to the result.
    * note: You will need to enable E-mail Authentication on your Firebase Dashboard for this to work.
10. Implement the ```createUser``` function to ```createUser``` on the ```FirebaseController.base``` reference, if you succeed, initialize a ```User``` object using the ```uid``` and other parameters, save the user, then authenticate the user to log the user in.
11. Implement the ```updateUser``` function to initialize a new ```User``` object with the same identifier and new parameters, save the user (which will overwrite the updated values on the server), fetch a new copy of the user using the identifier, set the ```currentUser``` property on ```sharedController```, and call the completion closure.
12. Implement the ```logoutCurrentUser``` function to ```unAuth``` on the ```FirebaseController.base``` reference, set the ```currentUser``` property on the ```sharedController``` to nil.

### ImageController Implementation

In an ideal world, we would host our images to Amazon S3 for fast, cheap asset hosting. However, in the spirit of building a Minimum Viable Product and using the tools we already have, we're going to host images on Firebase. Firebase does not natively support images, but it does support strings. Images can be converted to and from string values using Base64 encoding and decoding. You will build the ```ImageController``` and an extension on ```UIImage``` that provides the encoding and decoding for you.

##### Base 64 Encode / Decode

1. Define a new extension for ```UIImage``` at the bottom of the ```ImageController.swift``` file.
2. Create a calculated property ```base64String``` that returns an optional string.
3. Implement the calculated property by guarding a compressed ```UIImageJPEGRepresentation``` copy of the image represented as ```NSData```.
    * note: Play with various compression rates, the higher the compression, the faster loading images will go.
4. Return the data as a string with ```.base64EncodedStringWithOptions```.
5. Define a failable convenience initializer that takes a base64 encoded string as a parameter.
6. Implement the initializer by converting the string into ```NSData``` (```NSData(base64EncodedString: String)```) and calling ```self.init(data: NSData)``` with the result.

##### Upload and Download

1. Implement the ```uploadImage``` function by converting the image into a base64 encoded string, creating a Firebase child reference under the "images" endpoint, setting the encoded string as the value, and calling the completion closure with the identifier of the new child.
    * note: Firebase references return the last segment path of the endpoint with a ```.key``` parameter.
2. Implement the ```imageForIdentifier``` function by fetching the data at the "images" endpoint for the image identifier, unwrapping the Base 64 string, initializing the ```UIImage```, and calling the completion closure with the initialized image.

### Black Diamonds

* add 'double tap to like' functionality to the cell

### Tests

## Contributions

Please refer to CONTRIBUTING.md.

## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.
