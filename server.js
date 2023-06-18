import express from "express";
import jsonGraphqlExpress from "json-graphql-server";

const PORT = 3000;
const app = express();
const data = {
  events: [
    {
      id: 1,
      title: "event test 1",
      description: "event test 1 description",
      adress: "event test 1 adress",
    },
    {
      id: 2,
      title: "event test 2",
      description: "event test 2 description",
      adress: "event test 2 adress",
    },
    {
      id: 3,
      title: "event test 3",
      description: "event test 3 description",
      adress: "event test 3 adress",
      date: new Date("2020-01-03"),
    },
  ],
  users: [
    {
      id: 1,
      name: "user test 1",
    },
    {
      id: 2,
      name: "user test 2",
    },
    {
      id: 3,
      name: "user test 3",
    },
  ],
  messages: [
    {
      id: 1,
      member_id: 1,
      event_id: 1,
      message: "message test 1",
      date: new Date("2020-01-01"),
    },
    {
      id: 2,
      member_id: 2,
      event_id: 1,
      message: "message test 2",
      date: new Date("2020-01-02"),
    },
    {
      id: 3,
      member_id: 3,
      event_id: 1,
      message: "message test 3",
      date: new Date("2020-01-03"),
    },
    {
      id: 4,
      member_id: 1,
      event_id: 1,
      message: "message test 4",
      date: new Date("2020-01-04"),
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
