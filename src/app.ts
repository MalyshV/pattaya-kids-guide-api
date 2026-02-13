import express from "express";
import cors from "cors";
import routes from "./routes/index.js";
import type { Express } from "express";
import { errorHandler } from "./middlewares/errorHandler.js";
import { AppError } from "./utils/AppError.js";

export const app: Express = express();

app.use(cors());
app.use(express.json());

app.use("/", routes);
app.use((req, res, next) => {
  next(new AppError(`Route ${req.originalUrl} not found`, 404));
});
app.use(errorHandler);
