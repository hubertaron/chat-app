-- AlterTable
ALTER TABLE `chat` ALTER COLUMN `created_at` DROP DEFAULT;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `isAdmin` BOOLEAN NOT NULL DEFAULT false,
    ALTER COLUMN `created_at` DROP DEFAULT;
