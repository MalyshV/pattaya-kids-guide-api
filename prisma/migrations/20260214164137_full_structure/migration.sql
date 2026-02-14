/*
  Warnings:

  - You are about to drop the column `icon` on the `Amenity` table. All the data in the column will be lost.
  - You are about to drop the column `order` on the `AmenityGroup` table. All the data in the column will be lost.
  - Made the column `address` on table `Place` required. This step will fail if there are existing NULL values in that column.
  - Made the column `latitude` on table `Place` required. This step will fail if there are existing NULL values in that column.
  - Made the column `longitude` on table `Place` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "PriceType" AS ENUM ('FREE', 'PAID', 'MIXED');

-- CreateEnum
CREATE TYPE "PricingAudience" AS ENUM ('GENERAL', 'THAI_ID', 'THAI_DL', 'EXPAT');

-- CreateEnum
CREATE TYPE "DayOfWeek" AS ENUM ('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN');

-- AlterTable
ALTER TABLE "Amenity" DROP COLUMN "icon";

-- AlterTable
ALTER TABLE "AmenityGroup" DROP COLUMN "order";

-- AlterTable
ALTER TABLE "Place" ADD COLUMN     "animalContact" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "canLeaveChild" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "hasFood" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "hasWifi" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "indoor" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "address" SET NOT NULL,
ALTER COLUMN "latitude" SET NOT NULL,
ALTER COLUMN "longitude" SET NOT NULL;

-- CreateTable
CREATE TABLE "AgeGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "minAge" INTEGER NOT NULL,
    "maxAge" INTEGER NOT NULL,

    CONSTRAINT "AgeGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlaceAgeGroup" (
    "placeId" TEXT NOT NULL,
    "ageGroupId" TEXT NOT NULL,

    CONSTRAINT "PlaceAgeGroup_pkey" PRIMARY KEY ("placeId","ageGroupId")
);

-- CreateTable
CREATE TABLE "PlaceSchedule" (
    "id" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,
    "day" "DayOfWeek" NOT NULL,
    "openTime" TEXT NOT NULL,
    "closeTime" TEXT NOT NULL,
    "isClosed" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "PlaceSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlacePricing" (
    "id" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,
    "priceType" "PriceType" NOT NULL,
    "audience" "PricingAudience" NOT NULL,
    "minPrice" DOUBLE PRECISION,
    "maxPrice" DOUBLE PRECISION,
    "currency" TEXT NOT NULL,

    CONSTRAINT "PlacePricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlaceBirthdayInfo" (
    "id" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,
    "hasPackages" BOOLEAN NOT NULL,
    "minGuests" INTEGER,
    "maxGuests" INTEGER,
    "depositRequired" BOOLEAN NOT NULL,
    "preBookingDays" INTEGER,
    "notes" TEXT,
    "lastUpdatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlaceBirthdayInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PlaceBirthdayInfo_placeId_key" ON "PlaceBirthdayInfo"("placeId");

-- AddForeignKey
ALTER TABLE "PlaceAgeGroup" ADD CONSTRAINT "PlaceAgeGroup_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlaceAgeGroup" ADD CONSTRAINT "PlaceAgeGroup_ageGroupId_fkey" FOREIGN KEY ("ageGroupId") REFERENCES "AgeGroup"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlaceSchedule" ADD CONSTRAINT "PlaceSchedule_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlacePricing" ADD CONSTRAINT "PlacePricing_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlaceBirthdayInfo" ADD CONSTRAINT "PlaceBirthdayInfo_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
