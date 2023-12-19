# Hacker News Scraper

Hacker News Scraper is a simple Ruby program that scrapes news entries from Hacker News and provides functionality for
filtering the results.

## Requirements

- Ruby 3.2.2 or higher

## Installation

Clone this repository and run the following command to install dependencies:

```sh
git clone https://github.com/stefanomarch/hacker-news-scraper.git
```

Move into the project directory:

```sh
cd hacker-news-scraper
```
Install dependencies:
```sh
bundle install
```
Make the script executable:
```sh
chmod +x bin/hacker_news_scraper
```

## Usage 
To run the program simply execute the following command:
```sh
./bin/hacker_news_scraper
```
This will display the following menu:
```sh
HackerNews Scraper
1. Scrape without filters
2. Apply filters
3. Exit
```

### Scrape without filters
This option will scrape the first 30 news entries from the Hacker News homepage and display them in the terminal.

### Apply filters
This option will display the following menu:

```sh
Filter Options:
1. Filter entries with more than five words in the title ordered by the number of comments first.
2. Filter entries with less than or equal to five words in the title ordered by points
3. Exit
```
## Video Example

[hacker_news_scaper.mov](..%2F..%2FDesktop%2FVideo%20OBS%2Fhacker_news_scaper.mov)