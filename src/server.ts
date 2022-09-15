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
    //@ts-ignore
    res.status(400).send({ error: error.message });
  }
});
app.get("/blogs/:id", async (req, res) => {
  try {
    const id = Number(req.params.id);
    const blog = await prisma.blog.findUnique({
      where: { id },
      include: { author: true, comments: true, claps: true },
    });
    if (blog) {
      res.send(blog);
    } else {
      res.status(404).send({ error: "Blog not found" });
    }
  } catch (error) {
    //@ts-ignore
    res.status(400).send({ error: error.message });
  }
});
app.post("/blogs", async (req, res) => {
  try {
    const blog = await prisma.blog.create({ data: req.body });
    res.send(blog);
  } catch (error) {
    //@ts-ignore
    res.status(400).send({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`App running http://localhost:${port}`);
});
