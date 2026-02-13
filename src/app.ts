import express from "express";
import cors from "cors";
import routes from "./routes/index.js";
import type { Express } from "express";
import { errorHandler } from "./middlewares/errorHandler.js";

export const app: Express = express();

app.use(cors());
app.use(express.json());

app.use("/", routes);
app.use(errorHandler);
