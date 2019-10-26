## Search and Rescue API
### Introduction
This API servers as the backend for Beacon, a search and rescue app.  Built with Ruby on Rails and GraphQL.

### Setup
To setup locally, run the following commands:
 - `git clone https://github.com/Search-and-Rescue/search_and_rescue_api.git`
 - `cd search_and_rescupe_api`
 - `bundle install`
 - `bundle exec rake import`
 - `rails s`
 - Navigate to `localhost:300/graphiql` to view the GraphiQL, an in-browser IDE for exploring the API

### Endpoint
All requests should be made with a `POST` request to `/graphql?query=[request]`.

### User Requests

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

### Trip Requests

**All Trips for a User:**
```
query {
  user(id: 1) {
    trips{
      id
      name
      travelingCompanions
      }
    } 
  }
}  

```

**Single Trip:**
```
query {
  trip(id: 1){
    name
    startDate
    startTime
    endDate
    endTime
    }
  }
}

```

**Create Trip:**
```
mutation {
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
} 
```

**Update Trip**
```
mutation {
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
} 
```

### Vehicle Requests

**All Vehicles for a User:**
```
query {
  user(id: 1) {
    veicles{
      id
      make
      model
      year
      color
      licensePlate
      }
    } 
  }
}
```
**Single Vehicle:**
```
{
  vehicle(id: 1){
    make
    model
    year
    color
    licensePlate
  }
}
```

**Create Vehicle**
```
mutation {
  createVehicle(input: {
    make: "Ford"
    model: "F150"
    year: 2010
    color: "silver"
    licensePlate: "CYE 909"
    userId: 1
  }) {
    vehicle {
      id
      make
      model
      year
      color
      licensePlate
    }
  } 
}
```

**Update Vehicle**
```
mutation {
  updateVehicle(input: {
    make: "Ford"
    model: "F150"
    year: 2015
    color: "silver"
    licensePlate: "CYE 909"
    userId: 1
  }) {
    vehicle {
      id
      make
      model
      year
      color
      licensePlate
    }
  } 
}
```

**Remove Vehicle**
```
mutation {
  removeVehicle( input: {
    id: 2 }){
    vehicle {
      id
      make
      model
      year
      color
      licensePlate
    }
  }
}
```

### Gear Requests

**All Gear for a User:**
```
query {
  user(id: 1) {
    gear{
      id
      itemName
      }
    } 
  }
}
```
**Single Piece of Gear:**
```
{
  gear(id: 1){
    itemName
  }
}
```

**Create Gear**
```
mutation {
  createGear(input: {
    itemName: "sleeping bag"
    userId: 1
  }) {
    gear {
      id
      itemName
    }
  } 
}
```

**Update Gear**
```
mutation {
  updateGear(input: {
    itemName: "0 degree sleeping bag"
    userId: 1
  }) {
    gear {
      id
      itemName
    }
  } 
}
```

**Remove Gear**
```
mutation {
  removeGear( input: {
    id: 2 }){
    gear {
      itemName
    }
  }
}
```





