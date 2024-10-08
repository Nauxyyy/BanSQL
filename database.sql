DROP TABLE IF EXISTS banlist;
CREATE TABLE `banlist` (
  `license` varchar(50) NOT NULL,
  `identifier` varchar(25) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` int(11) DEFAULT 0,
  `expiration` datetime DEFAULT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  `debutban` datetime DEFAULT current_timestamp(),
  `added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS banlisthistory;
CREATE TABLE IF NOT EXISTS banlisthistory (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  license varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  identifier varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  targetplayername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  sourceplayername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  reason varchar(255) NOT NULL,
  timeat int(11) NOT NULL,
  added varchar(40) NOT NULL,
  expiration int(11) NOT NULL,
  permanent int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS baninfo;
CREATE TABLE IF NOT EXISTS baninfo (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  license varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  identifier varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  playername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
