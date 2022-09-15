import express from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
const app = express();
app.use(cors());
app.use(express.json());

const port = 4567;
app.get("/blogs", async (req, res) => {
  try {
    const blogs = await prisma.blog.findMany({
      include: { author: true, comments: true, claps: true },
    });
    res.send(blogs);
  } catch (error) {
    res.status(400).send({ error });
  }
});



app.listen(port, () => {
  console.log(`App running http://localhost:${port}`);
});
