# README

## About this project

This is an API that exposes three endpoints, one for creating a tea subscription for a customer, one for cancelling a tea subscription, and one for retrieiving a customers subscriptions both active and cancelled.

## Installation Instructions

- clone this repository
- run `bundle install`
- run `rails db:{create,migrate,seed}`
- To run the test suite `bundle exec rspec`
## Schema design
<img width="622" alt="Screen Shot 2022-09-21 at 9 39 47 AM" src="https://user-images.githubusercontent.com/60715457/191549065-3077183e-911f-4746-bedd-7b74c8baea9c.png">

## Subscription Creation endpoint
Request

POST /api/v1/customers/:customer_id/subscriptions

body
```JSON
{
    "title": "Green Tea",
    "price": 3.50,
    "status": "active",
    "frequency": "monthly",
    "tea_id": 2
}
```
Response - status: 201
```JSON
{
    "data": {
        "id": "3",
        "type": "subscription",
        "attributes": {
            "title": "Green Tea",
            "price": 3.5,
            "status": "active",
            "frequency": "monthly"
        }
    }
}
```

Bad Request

POST /api/v1/customers/:customer_id/subscriptions

body
```JSON
{
    "title": "Green Tea",
    "status": "active",
    "frequency": "monthly",
    "tea_id": 1
}
```
Response status: 400
```JSON
{
    "errors": [
        "Price can't be blank"
    ]
}
```
Bad Request

POST /api/v1/customers/:customer_id/subscriptions

body
```JSON
{
    "title": "Green Tea",
    "price": 3.50,
    "status": "active",
    "frequency": "monthly",
    "tea_id": 8
}
```
Response status: 400
```JSON
{
    "errors": [
        "Tea must exist"
    ]
}
```


## Customer Subscription retrieval endpoint
Request

get '/api/v1/customers/:customer_id/subscriptions'

Response - status: 200
```JSON
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Green Tea",
                "price": 3.5,
                "status": "active",
                "frequency": "monthly"
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "Green Tea",
                "price": 3.5,
                "status": "active",
                "frequency": "monthly"
            }
        }
    ]
}
```
## Cancel Subscription Endpoint
Request

patch '/api/v1/customers/:customer_id/subscriptions/:id'

Response - status: 202
```JSON
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "Green Tea",
            "price": 3.5,
            "status": "Cancelled",
            "frequency": "monthly"
        }
    }
}
```

Bad Request

patch '/api/v1/customers/:customer_id/subscriptions/:id'

Response - status: 400
```JSON
{
    "errors": "Invalid Subscription ID"
}
```


