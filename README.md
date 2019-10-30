## Search and Rescue API
### Introduction
This API servers as the backend for Beacon, a search and rescue app.  Built with Ruby on Rails and GraphQL.

### Setup
To setup locally, run the following commands:
 - `git clone https://github.com/Search-and-Rescue/search_and_rescue_api.git`
 - `cd search_and_rescue_api`
 - `bundle install`
 - `bundle exec rake import`
 - `rails s`
 - Navigate to `localhost:3000/graphiql` to view the GraphiQL, an in-browser IDE for exploring the API

### Endpoint
All requests should be made with a `POST` request to `/graphql?query=[request]`.

### User Requests

**All Users:**
```
query {
  users{
    id
    name
    email
  }
}
```

**Get Single User:**
```
query {
  user(id: 1){
    id
    name
    email
    city
    state
    email
  }
}
```

**Create User:**
```
mutation {
  createUser( input: {
    id: 1
    name: "name"
    address: "address"
    city: "city"
    state: "state"
    zip: zip
    email: "email@example.com"
  }) {
    user {
      id
      name
      address
      city
      state
      zip
      email
    }
  }
}
```

**Update User:**
```
mutation {
  updateUser( input: {
    id: 1
    name: "name"
    address: "address"
    city: "city"
    state: "state"
    zip: zip
    email: "email@example.com"
  }) {
    user {
      id
      name
      address
      city
      state
      zip
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

**Remove a Trip**
```
mutation {
  removeTrip(input: {
    id: 1
  }) {
    trip{
      id
      name
    }
  }
}
```

### Add To Trip Requests

**Add Gear to a Trip**
```
mutation {
  addGearToTrip(input: {
    tripId: 1
    gearId: 1
    comments: "Comment here"
  }) {
    tripGear{
      comments
      gear{
        itemName
      }
      trip{
        name
      }
    }
  }
}
```

**Add Vehicle to a Trip**
```
mutation {
  addVehicleToTrip(input: {
    tripId: 1
    vehicleId: 1
  }) {
    trip{
      name
    }
    vehicle{
      make
    }
  }
}
```

**Add Contact to a Trip**
```
mutation {
  addContactToTrip(input: {
    emergencyContactId: 5
    tripId: 2
  }) {
    trip{
      name
    }
    emergencyContact{
      name
      phone
    }
  }
}
```
### Emergency Contact Requests

**All Emergency Contacts for a User:**
```
query {
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

**Get Single Emergency Contact:**
```
query {
  contact(id: 1){
    name
    phone
    email
    }
  }
}
```

**Add Emergency Contact**
```
mutation {
  createContact(input: {
    name: "name"
    phone: "phone"
    email: "email@example.com"
    userId: 1
  }) {
    emergencyContact {
      id
      name
      phone
      email
    }
  }
}
```

**Update Emergency Contact**
```
mutation {
   updateContact(input: {
       id: 1
       userId: 1
       name: "name"
       phone: "phone"
       email: "email@example.com"
  }) {
    emergencyContact {
       name
       phone
       email
    }
  }
}
```

**Remove Emergency Contact**
```
mutation {
  removeContact( input: {
    id: 1 }){
    contact {
      id
      name
      phone
      email
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
query {
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

### Search and Rescue Teams

**Get All Teams:
```
query {
  teams {
    teamName
    county
    contact
    contactNumber
    city
    state
  }
}
```

**Get Single Team:**
```
query {
  team(id: 1) {
    teamName
    county
    contact
    contactNumber
    city
    state
  }
}
```

### Schema Diagram
(For additional information in your queries and mutations)

![Beacon Schema](/schema_diagram.png?raw=true "Beacon Schema")


### Project Board

[Click here to see the Beacon Project Board](https://github.com/orgs/Search-and-Rescue/projects/1)

### Built Using

* Rails 5.2.3
* Ruby 2.4.9
* PostgreSQL database
* Sinatra to host a micro-service API that manages a SendGrid emailing service

[View the Sinatra microservice's repo here](https://github.com/Search-and-Rescue/beacon_email_service)

### Contributors

- [Tyler Bierwirth](https://github.com/tbierwirth)
- [Jori Peterson](https://github.com/JoriPeterson)
