# Design Decisions

Here are some of the design decisions I made while building this application. The classes used are:

### HackerNewsScraper Executable File:

- Utilizes a case statement for menu options handling, chosen for its simplicity and effectiveness in a straightforward program.
### General Scraper Class:

- Serves as a base class for all scrapers, handling HTTP requests and fetching responses from URLs. 
- Designed to prevent code duplication and facilitate the addition of new scrapers for different URLs in the future. 
### HackerNewsScraper Class:

- Dedicated to scraping the Hacker News homepage and returning news entries as an array of hashes.
- Includes a public scrape method. 
- Implements multithreading to enhance scraping speed. In more extensive applications, you would consider using background jobs or caching.
- Opted for array structures over hashes for better code readability, though hash implementation is possible for faster results.
### Filters Module:
- Houses various filters for news entries. 
- Currently includes a TitleLengthFilter to filter news entries based on title length, using comparison operators and word counts.
- Designed for easy expansion with additional filters in the future. 
## Testing Strategy (with RSPEC):
- Comprehensive unit testing for all classes and their behaviors. 
- Integration testing for the HackerNewsScraper class, utilizing the Open3 gem. This approach avoids the complexity of stubbing the Kernel module or using the Cucumber gem.
