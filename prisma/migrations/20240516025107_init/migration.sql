-- CreateTable
CREATE TABLE "events" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "details" TEXT,
    "slug" TEXT NOT NULL,
    "maximum_attendees" INTEGER,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "attendees" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "event_id" TEXT NOT NULL,

    CONSTRAINT "attendees_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "check_in" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attendee_id" INTEGER NOT NULL,

    CONSTRAINT "check_in_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "events_slug_key" ON "events"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "attendees_event_id_email_key" ON "attendees"("event_id", "email");

-- CreateIndex
CREATE UNIQUE INDEX "check_in_attendee_id_key" ON "check_in"("attendee_id");

-- AddForeignKey
ALTER TABLE "attendees" ADD CONSTRAINT "attendees_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "events"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "check_in" ADD CONSTRAINT "check_in_attendee_id_fkey" FOREIGN KEY ("attendee_id") REFERENCES "attendees"("id") ON DELETE CASCADE ON UPDATE CASCADE;
