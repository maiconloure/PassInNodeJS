-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_check_in" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attendee_id" INTEGER NOT NULL,
    CONSTRAINT "check_in_attendee_id_fkey" FOREIGN KEY ("attendee_id") REFERENCES "attendees" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_check_in" ("attendee_id", "created_at", "id") SELECT "attendee_id", "created_at", "id" FROM "check_in";
DROP TABLE "check_in";
ALTER TABLE "new_check_in" RENAME TO "check_in";
CREATE UNIQUE INDEX "check_in_attendee_id_key" ON "check_in"("attendee_id");
CREATE TABLE "new_attendees" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "event_id" TEXT NOT NULL,
    CONSTRAINT "attendees_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "events" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_attendees" ("created_at", "email", "event_id", "id", "name") SELECT "created_at", "email", "event_id", "id", "name" FROM "attendees";
DROP TABLE "attendees";
ALTER TABLE "new_attendees" RENAME TO "attendees";
CREATE UNIQUE INDEX "attendees_event_id_email_key" ON "attendees"("event_id", "email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
