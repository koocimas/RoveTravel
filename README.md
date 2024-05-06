<img width="830" alt="Screenshot 2024-05-06 at 4 12 58 PM" src="https://github.com/koocimas/RoveTravel/assets/129230960/2a6a68c1-a490-40a6-a4d4-c57148755ef8">
<img width="859" alt="Screenshot 2024-05-06 at 4 13 06 PM" src="https://github.com/koocimas/RoveTravel/assets/129230960/1935078e-48a0-4586-a892-291549ef562d">

Rove is a travel planning app that allows you to access destination information and record items in a personal travel planning list. 

Although you can access location times, time zones, current news articles, and exchange rates from your phone’s various apps and internet search browsers, you likely prefer to not change your phone settings or check all of these different things individually. 

With Rove, you can access all of this information in the Snapshot view long before you’ve even booked your flight. This will allow you to decide where you want to rove, and you can familiarize yourself with upcoming travel destinations. 

In the Trip Planner, you can add in destination-specific tasks like seeing the pyramids in Giza or walking along the Great Wall, but it is also useful for administrative tasks like ‘Book Flight’ and ‘Pack suitcase’.

Once you’ve arrived, you will find the exchange rate tool extremely useful in your daily travels. You can utilize the trip planner to add notes describing each experience in that destination. 

When you complete a trip planning item, a checkmark appears but the item does not archive. You can continue to access all of the details in each item to always remember your trip and relive those experiences, much like a travel diary.

The app’s repo does not contain API keys or other authentication information. 
  - TimeManager: does not require an API
  - CurrencyManager: add a Currency-Info.plist file using an api key from https://www.exchangerate-api.com, formatted API_KEY type String.
  - NewsManager: News-Info.plist file using an api key from https://newsapi.org, formatted API_KEY type String.
  - News articles are displayed 10 at a time. Only 100 article results are allowed by the API per day.

The project has a test plan including both UI and unit tests, with 59% code coverage.

