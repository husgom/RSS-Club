CREATE TABLE `base_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `companies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_turkish_ci default NULL,
  `status_id` int(11) default NULL,
  `name_in_demand` varchar(255) collate utf8_turkish_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `demand_offers` (
  `id` int(11) NOT NULL auto_increment,
  `demand_id` int(11) default NULL,
  `offer_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `demand_section_infos` (
  `id` int(11) NOT NULL auto_increment,
  `demand_section_id` int(11) default NULL,
  `name` varchar(256) default NULL,
  `info_type_id` int(11) default NULL,
  `value` varchar(256) default NULL,
  `numeric_value` int(11) default NULL,
  `sequence` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `demand_sections` (
  `id` int(11) NOT NULL auto_increment,
  `demand_id` int(11) default NULL,
  `section_type_id` int(11) default NULL,
  `name` varchar(256) default NULL,
  `sequence` int(11) default NULL,
  `onleft` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `demand_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(256) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `offer_type_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `demand_types_section_types` (
  `demand_type_id` int(11) NOT NULL,
  `section_type_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `demands` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(256) default NULL,
  `notes` text NOT NULL,
  `max_price_in_cents` int(11) NOT NULL default '0',
  `min_price_in_cents` int(11) NOT NULL default '0',
  `max_offer_id` bigint(20) default NULL,
  `min_offer_id` bigint(20) default NULL,
  `demand_type_id` int(11) default '1',
  `user_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `info_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(256) default NULL,
  `desc` varchar(256) default NULL,
  `base_type_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `offer_infos` (
  `id` int(11) NOT NULL auto_increment,
  `offer_id` int(11) default NULL,
  `info_type_id` int(11) default NULL,
  `value` varchar(255) collate utf8_turkish_ci default NULL,
  `numeric_value` int(11) default NULL,
  `sequence` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `offers` (
  `id` int(11) NOT NULL auto_increment,
  `demand_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL default '5',
  `price_in_cents` int(11) default NULL,
  `notes` text collate utf8_turkish_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(256) collate utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `section_type_infos` (
  `id` int(11) NOT NULL auto_increment,
  `sequence` int(11) NOT NULL default '0',
  `info_type_id` int(11) default NULL,
  `section_type_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `section_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(256) default NULL,
  `desc` varchar(255) NOT NULL,
  `sequence` int(11) default NULL,
  `onleft` tinyint(1) default '0',
  `owner` varchar(256) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_turkish_ci default NULL,
  `category` varchar(255) collate utf8_turkish_ci default NULL,
  `sequence` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `user_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_turkish_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_turkish_ci default NULL,
  `company_name` varchar(255) collate utf8_turkish_ci NOT NULL,
  `email` varchar(255) collate utf8_turkish_ci NOT NULL,
  `company_id` bigint(20) NOT NULL,
  `hashed_password` varchar(255) collate utf8_turkish_ci default NULL,
  `salt` varchar(255) collate utf8_turkish_ci default NULL,
  `user_type_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

INSERT INTO schema_migrations (version) VALUES ('20090503114152');

INSERT INTO schema_migrations (version) VALUES ('20090503114206');

INSERT INTO schema_migrations (version) VALUES ('20090503114346');

INSERT INTO schema_migrations (version) VALUES ('20090503114450');

INSERT INTO schema_migrations (version) VALUES ('20090503114805');

INSERT INTO schema_migrations (version) VALUES ('20090503123126');

INSERT INTO schema_migrations (version) VALUES ('20090503141908');

INSERT INTO schema_migrations (version) VALUES ('20090503142012');

INSERT INTO schema_migrations (version) VALUES ('20090503142152');

INSERT INTO schema_migrations (version) VALUES ('20090803114152');

INSERT INTO schema_migrations (version) VALUES ('20090908211132');

INSERT INTO schema_migrations (version) VALUES ('20090909221925');

INSERT INTO schema_migrations (version) VALUES ('20090909222111');

INSERT INTO schema_migrations (version) VALUES ('20090909222651');

INSERT INTO schema_migrations (version) VALUES ('20090910233531');

INSERT INTO schema_migrations (version) VALUES ('20090919181859');