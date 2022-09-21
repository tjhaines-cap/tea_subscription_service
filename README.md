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

### Subscription endpoint
Request
```
POST /api/v1/subscriptions
parameters = {
          title: 'Green Tea',
          price: 3.25,
          status: 'active',
          frequency: 'weekly',
          customer_email: 'customer@email.com'
        }
```
Response
```
status: 201
```

