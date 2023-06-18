import express from "express";
import jsonGraphqlExpress from "json-graphql-server";

const PORT = 3000;
const app = express();
const data = {
  events: [
    {
      id: 1,
      title: "Tech Conference 2022",
      description: "Join us for the largest tech conference of the year",
      address: "123 Main Street",
      date: new Date("2022-07-01"),
    },
    {
      id: 2,
      title: "Startup Meetup",
      description: "Connect with fellow entrepreneurs and innovators",
      address: "456 Elm Avenue",
      date: new Date("2022-07-15"),
    },
    {
      id: 3,
      title: "Design Workshop",
      description: "Learn the latest design techniques from industry experts",
      address: "789 Oak Lane",
      date: new Date("2022-07-30"),
    },
    {
      id: 4,
      title: "Networking Event",
      description: "Expand your professional network in a casual setting",
      address: "987 Pine Road",
      date: new Date("2022-08-05"),
    },
  ],
  users: [
    {
      id: 1,
      name: "John Doe",
    },
    {
      id: 2,
      name: "Jane Smith",
    },
    {
      id: 3,
      name: "Michael Johnson",
    },
    {
      id: 4,
      name: "Emily Brown",
    },
  ],
  messages: [
    {
      id: 1,
      member_id: 1,
      event_id: 1,
      message: "Hi, everyone!",
      date: new Date("2022-07-01T10:00:00"),
    },
    {
      id: 2,
      member_id: 2,
      event_id: 1,
      message: "Excited for the conference!",
      date: new Date("2022-07-01T11:30:00"),
    },
    {
      id: 3,
      member_id: 3,
      event_id: 1,
      message: "Any specific agenda for the event?",
      date: new Date("2022-07-01T13:45:00"),
    },
    {
      id: 4,
      member_id: 4,
      event_id: 2,
      message: "Looking forward to meeting everyone!",
      date: new Date("2022-07-15T09:20:00"),
    },
    {
      id: 5,
      member_id: 2,
      event_id: 2,
      message: "Is there a dress code for the meetup?",
      date: new Date("2022-07-15T11:10:00"),
    },
    {
      id: 6,
      member_id: 3,
      event_id: 3,
      message: "Are there any prerequisites for the workshop?",
      date: new Date("2022-07-30T14:30:00"),
    },
    {
      id: 7,
      member_id: 4,
      event_id: 3,
      message: "Looking forward to expanding my design skills!",
      date: new Date("2022-07-30T16:15:00"),
    },
    {
      id: 8,
      member_id: 1,
      event_id: 4,
      message: "Is there a guest speaker at the event?",
      date: new Date("2022-08-05T10:45:00"),
    },
  ],
  members: [
    {
      id: 1,
      user_id: 2,
      event_id: 2,
      role: "admin",
    },
    {
      id: 2,
      user_id: 2,
      event_id: 1,
      role: "member",
    },
    {
      id: 3,
      user_id: 2,
      event_id: 3,
      role: "member",
    },
    {
      id: 4,
      user_id: 1,
      event_id: 1,
      role: "member",
    },
  ],
};

app.use("/graphql", jsonGraphqlExpress.default(data));
app.listen(PORT);
console.log(`GraphQL server running http://localhost:${PORT}/graphql .`);
