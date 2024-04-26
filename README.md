# Context
given a JSON formatted file containing primary election results by state, county,
party, and candidate. An example record is provided below:

```json
{
  "Pennsylvania": {
    "Chester": {
      "Democrats": {
        "Humphrey ": 100,
        "McGovern": 50
      },
      "Republicans": {
        "Nixon": 200,
        "Ashbrook": 2,
        "McCloskey": 1
      }
    }
  }
}
```


Without using a database, create an API that has endpoints to do to the following:
1. Return the winning primary candidates in each state and overall
2. Implement a UX that allows a user to choose the state to see the winner for each,
   as well as the overall winner


# Run server

```rails server -p 8000```

# APIs
 
Get all the winners by state and overall

```http request
GET /winners
```

# Future Improvements
1. Authenticated API
2. RSpec unit tests
3. Organize controller code using service objects
4. Cache the winners. If cache is unavailable then store the winners in a json file
5. Store election result file on a blob storage system such as S3 (AWS)
   Approximate JSON file size = 2.3MB
   228B (size for 1 state and 2 counties) * 50 (states) * 200 (# of counties per state on average)


# Product Assumptions
Requirement # 1 “Return the winning primary candidates in each state and overall”
ASSUMPTION: overall winners for each parties 