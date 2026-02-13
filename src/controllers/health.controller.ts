import { Request, Response } from "express";
import { AppError } from "../utils/AppError.js";

export const healthCheck = (req: Request, res: Response): void => {
  // res.json({ status: "ok" });
  throw new AppError("Health check failed", 400);
};
