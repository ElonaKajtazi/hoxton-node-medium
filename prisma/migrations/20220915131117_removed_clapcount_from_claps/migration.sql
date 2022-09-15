/*
  Warnings:

  - You are about to drop the column `clapCount` on the `Clap` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Clap" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "blogId" INTEGER NOT NULL,
    CONSTRAINT "Clap_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Clap_blogId_fkey" FOREIGN KEY ("blogId") REFERENCES "Blog" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Clap" ("blogId", "id", "userId") SELECT "blogId", "id", "userId" FROM "Clap";
DROP TABLE "Clap";
ALTER TABLE "new_Clap" RENAME TO "Clap";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
