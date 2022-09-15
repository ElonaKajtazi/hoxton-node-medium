-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Blog" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "blogTitle" TEXT NOT NULL,
    "blogText" TEXT NOT NULL,
    "imageUrl" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Blog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Blog" ("blogText", "blogTitle", "id", "imageUrl", "userId") SELECT "blogText", "blogTitle", "id", "imageUrl", "userId" FROM "Blog";
DROP TABLE "Blog";
ALTER TABLE "new_Blog" RENAME TO "Blog";
CREATE TABLE "new_Clap" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "blogId" INTEGER NOT NULL,
    CONSTRAINT "Clap_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Clap_blogId_fkey" FOREIGN KEY ("blogId") REFERENCES "Blog" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Clap" ("blogId", "id", "userId") SELECT "blogId", "id", "userId" FROM "Clap";
DROP TABLE "Clap";
ALTER TABLE "new_Clap" RENAME TO "Clap";
CREATE TABLE "new_Comment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "commentText" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "blogId" INTEGER NOT NULL,
    CONSTRAINT "Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Comment_blogId_fkey" FOREIGN KEY ("blogId") REFERENCES "Blog" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Comment" ("blogId", "commentText", "id", "userId") SELECT "blogId", "commentText", "id", "userId" FROM "Comment";
DROP TABLE "Comment";
ALTER TABLE "new_Comment" RENAME TO "Comment";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
