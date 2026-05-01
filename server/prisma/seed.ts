import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Seeding database...');

  // Create resource types
  const resourceTypes = await Promise.all([
    prisma.resourceType.upsert({
      where: { name: 'code_library' },
      update: {},
      create: {
        name: 'code_library',
        description: 'Reusable code libraries and components'
      }
    }),
    prisma.resourceType.upsert({
      where: { name: 'design_asset' },
      update: {},
      create: {
        name: 'design_asset',
        description: 'Design files, templates, and visual assets'
      }
    }),
    prisma.resourceType.upsert({
      where: { name: 'documentation' },
      update: {},
      create: {
        name: 'documentation',
        description: 'Documentation, guides, and knowledge base articles'
      }
    }),
    prisma.resourceType.upsert({
      where: { name: 'tool' },
      update: {},
      create: {
        name: 'tool',
        description: 'Development tools and utilities'
      }
    }),
    prisma.resourceType.upsert({
      where: { name: 'template' },
      update: {},
      create: {
        name: 'template',
        description: 'Project templates and boilerplates'
      }
    }),
    prisma.resourceType.upsert({
      where: { name: 'hardware' },
      update: {},
      create: {
        name: 'hardware',
        description: 'Physical hardware and equipment'
      }
    })
  ]);

  console.log('✅ Resource types created');

  // Create admin user (password: admin123)
  const adminPassword = await bcrypt.hash('admin123', 12);
  const admin = await prisma.user.upsert({
    where: { email: 'admin@financialsystemscorp.com' },
    update: {},
    create: {
      email: 'admin@financialsystemscorp.com',
      passwordHash: adminPassword,
      name: 'Admin User',
      role: 'ADMIN'
    }
  });

  console.log('✅ Admin user created:', admin.email);

  // Create system settings
  await prisma.systemSetting.upsert({
    where: { key: 'portal_name' },
    update: {},
    create: {
      key: 'portal_name',
      value: 'Financial Systems Corp Portal',
      type: 'string',
      description: 'Portal display name'
    }
  });

  console.log('✅ System settings created');

  console.log('🎉 Seeding completed!');
}

main()
  .catch((e) => {
    console.error('❌ Seeding error:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
