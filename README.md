Rove is a travel planning app that allows you to access destination information and record items in a personal travel planning list. 

Although you can access location times, time zones, current news articles, and exchange rates from your phone’s various apps and internet search browsers, you likely prefer to not change your phone settings or check all of these different things individually. 

With Rove, you can access all of this information in the Snapshot view long before you’ve even booked your flight. This will allow you to decide where you want to rove, and you can familiarize yourself with upcoming travel destinations. 

In the Trip Planner, you can add in destination-specific tasks like seeing the pyramids in Giza or walking along the Great Wall, but it is also useful for administrative tasks like ‘Book Flight’ and ‘Pack suitcase’.

Once you’ve arrived, you will find the exchange rate tool extremely useful in your daily travels. You can utilize the trip planner to add notes describing each experience in that destination. 

When you complete a trip planning item, a checkmark appears but the item does not archive. You can continue to access all of the details in each item to always remember your trip and relive those experiences, much like a travel diary.

The app has at least one screen with a list using a view of your choice (List, Grid, ScrollView etc). This list should appear in a tab view with at least two tabs.
News articles present in a list on the first tab
Trip planning items present in a list on the second tab
Each item in the list should contain (at minimum) a name, a subtitle or description, and an image of the item, and any text should be styled appropriately. 
News articles provide an image thumbnail next to the article name
Trip planning items display the item name (up to 2 lines) along with a button that is a dotted square when incomplete and a checkmark when complete. This will toggle the task completed variable.
Tapping an item in this list should navigate (NavigationStack)  to a detail view: This should show the same data in the list item with some further details:
News article detail views include their larger image, article name, author(s), published date, and summary.
Trip planning items edit view let the user edit the name, notes, and/or completion toggle.
Include enough items to ensure that the user has to scroll the list to see all the items in it. 
News articles are displayed 10 at a time. Only 100 article results are allowed by the API per day. If you go over the amount and need another api key, let me know (I have two extra accounts/api keys).
Trip planning items are scrollable where there are enough added.
The app has one or more network calls using URLSession to download/upload data related to the core tasks of the app. 
CurrencyManager, TimeManager, and NewsManager all use URLSession network calls to download data.
The app’s repo does not contain API keys or other authentication information. Don’t store API keys or other authentication information in your app’s repo. See this article to store them in a plist, add the plist to your .gitignore file, then attach the plist to your Google doc.
TimeManager: does not require an API
CurrencyManager: Currency-Info.plist
API_KEY : String : 131d85c66887598b362ecb22
NewsManager: News-Info.plist
API_KEY : String : 56fad0c282a549fc87e75a4f589239b0
If your API has a low request limit that your mentor might hit, highlight this in the README and explain how to use your freeze-dried data.
News articles are displayed 10 at a time. Only 100 article results are allowed by the API per day. If you go over the amount and need another api key, let me know (I have two extra accounts/api keys).
The app uses at least one way to save data: user defaults, plist, file, or keychain. Specify your method in the README.
Trip planning items are saved in JSON in the File Manager’s documents directory.
If you disable any rule for a line of code, explain why in a comment near the disable comment or, if it’s a general situation, explain in the README.  
I have disabled a few of the allowed warnings: multiple_closures_with_trailing_closure
The project has a test plan including both UI and unit tests, with a minimum of 50% code coverage, and all tests succeed. Make sure your test plan is in your repo.

The app includes at least one SwiftUI animation.
Trip planning items have dotted squares for incomplete items that animate to checkmarks when completed.


