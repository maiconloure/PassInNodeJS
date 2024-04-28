import { prisma } from "../src/lib/prisma"

async function seed() {
  await prisma.event.create({
    data: {
      id: "eca27cfc-3046-41c6-a93d-f98e3fe4fa9f",
      title: "Unite Summit",
      slug: "unite-summit",
      details: "And event for developers",
      maximumAttendees: 120
    }
  })
}

seed().then(() => {
    console.log('Seeding finished')
    prisma.$disconnect()
    process.exit(0)
})