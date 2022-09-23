# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Schema design
<img width="622" alt="Screen Shot 2022-09-21 at 9 39 47 AM" src="https://user-images.githubusercontent.com/60715457/191549065-3077183e-911f-4746-bedd-7b74c8baea9c.png">

### Subscription Creation endpoint
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


### Customer Subscription retrieval endpoint
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
### Cancel Subscription Endpoint
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


