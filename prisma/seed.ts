import "dotenv/config";
import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import pg from "pg";

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is not defined");
}

const pool = new pg.Pool({
  connectionString: process.env.DATABASE_URL,
});

const adapter = new PrismaPg(pool);

const prisma = new PrismaClient({
  adapter,
});

async function main() {
  console.log("🌱 Start seeding...");

  // 1. Place Categories
  await prisma.category.createMany({
    data: [
      { name: "Indoor Playground", slug: "indoor-playground", order: 1 },
      { name: "Waterpark", slug: "waterpark", order: 2 },
      { name: "Cafe with Kids Zone", slug: "cafe-kids-zone", order: 3 },
    ],
    skipDuplicates: true,
  });

  // 2. Event Categories
  await prisma.eventCategory.createMany({
    data: [
      { name: "Workshop", slug: "workshop" },
      { name: "Festival", slug: "festival" },
      { name: "Holiday Event", slug: "holiday-event" },
      { name: "Kids Activity", slug: "kids-activity" },
      { name: "Seasonal Event", slug: "seasonal-event" },
    ],
    skipDuplicates: true,
  });

  console.log("✅ Seed completed");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
