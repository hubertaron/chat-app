-- DropForeignKey
ALTER TABLE `chat` DROP FOREIGN KEY `chat_sender_id_fkey`;

-- DropForeignKey
ALTER TABLE `chat` DROP FOREIGN KEY `chat_to_id_fkey`;

-- AlterTable
ALTER TABLE `chat` ALTER COLUMN `created_at` DROP DEFAULT;

-- AlterTable
ALTER TABLE `user` ALTER COLUMN `created_at` DROP DEFAULT;

-- AddForeignKey
ALTER TABLE `chat` ADD CONSTRAINT `chat_sender_id_fkey` FOREIGN KEY (`sender_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `chat` ADD CONSTRAINT `chat_to_id_fkey` FOREIGN KEY (`to_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
