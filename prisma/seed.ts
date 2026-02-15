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

  await prisma.category.createMany({
    data: [
      { name: "Indoor Playground", slug: "indoor-playground", order: 1 },
      { name: "Waterpark", slug: "waterpark", order: 2 },
      { name: "Cafe with Kids Zone", slug: "cafe-kids-zone", order: 3 },
    ],
    skipDuplicates: true,
  });

  console.log("✅ Done");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
