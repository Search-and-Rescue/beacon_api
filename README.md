## Search and Rescue API
### Introduction
This API servers as the backend for Beacon, a search and rescue app.  Built with Ruby on Rails and GraphQL.

### Setup
To setup locally, run the following commands:
 - `git clone https://github.com/Search-and-Rescue/search_and_rescue_api.git`
 - `cd search_and_rescupe_api`
 - `bundle install`
 - `rails s`
 - Navigate to `localhost:300/graphiql` to view the GraphiQL, an in-browser IDE for exploring the API

### Endpoint
All requests should be made with a `POST` request to `/graphql?query=[request]`.

### User Request

**All Users:**
```
{
  users{
    id
    name
    email
  }
}
```

**Single User:**
```
{
  user(id: 1){
    id
    name
    email
  }
}
```

**Single User + Emergency Contacts:**
```
{
  user(id: 1){
    id
    name
    email
    emergencyContacts{
      id
      name
      phone
      email
    }
  }
}
```

### Trip Request

**All Trips for a User:**
```
 user(id: 1) {
    trips{
       id
       name
       travelingCompanions
     }
  }
}  

```

**Single Trip:**
```
{
  trip(id: 1){
    name
    startDate
    startTime
    endDate
    endTime
  }
}

```

**Create Trip:**
```
 createTrip(input: {
   name: "Spanish Peaks Backpacking Trip"
   startingPoint: "Coyote Trail Head"
   endingPoint: "Coyote Trail Head"
   startDate: "May 1, 2020"
   startTime: "08:00"
   endDate: "May 3, 2020"
   endTime: "22:00"
   notificationDate: "May 4, 2020"
   notificationTime: "15:00"
   travelingCompanions: 0
   userId: 1
 }) {
   trip {
      id
      name
      startingPoint
      endingPoint
      startDate
      startTime
      endDate
      endTime
      notificationDate
      notificationTime
      travelingCompanions
    }
  } 
```

**Update Trip**
```
 upateTrip(input: {
   name: "Spanish Peaks Backpacking Trip"
   startingPoint: "Coyote Trail Head"
   endingPoint: "Coyote Trail Head"
   startDate: "May 1, 2020"
   startTime: "08:00"
   endDate: "May 3, 2020"
   endTime: "22:00"
   notificationDate: "May 4, 2020"
   notificationTime: "15:00"
   travelingCompanions: 2
   userId: 1
 }) {
   trip {
      id
      name
      startingPoint
      endingPoint
      startDate
      startTime
      endDate
      endTime
      notificationDate
      notificationTime
      travelingCompanions
    }
  } 
```


