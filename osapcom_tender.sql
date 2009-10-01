-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net
--
-- Anamakine: localhost
-- Üretim Zamanı: 03 Mayıs 2009 saat 10:04:47
-- Sunucu sürümü: 5.0.67
-- PHP Sürümü: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Veritabanı: `osapcom_tender`
--

-- --------------------------------------------------------

--
-- Tablo yapısı: `base_types`
--

CREATE TABLE IF NOT EXISTS `base_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) character set latin1 default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci AUTO_INCREMENT=7 ;

--
-- Tablo döküm verisi `base_types`
--

INSERT INTO `base_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'String', NULL, NULL),
(2, 'Number', NULL, NULL),
(3, 'Money', NULL, NULL),
(4, 'Enum', NULL, NULL),
(5, 'Date', NULL, NULL),
(6, 'Date Time', NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo yapısı: `demand_types`
--

CREATE TABLE IF NOT EXISTS `demand_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) character set utf8 collate utf8_turkish_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Tablo döküm verisi `demand_types`
--

INSERT INTO `demand_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Kargo Anlaşmaları', NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo yapısı: `demand_types_section_types`
--

CREATE TABLE IF NOT EXISTS `demand_types_section_types` (
  `demand_type_id` int(11) NOT NULL default '0',
  `section_type_id` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`demand_type_id`,`section_type_id`),
  KEY `section_type_id` (`section_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `demand_types_section_types`
--

INSERT INTO `demand_types_section_types` (`demand_type_id`, `section_type_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(1, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo yapısı: `info_types`
--

CREATE TABLE IF NOT EXISTS `info_types` (
  `id` int(11) NOT NULL auto_increment,
  `base_type_id` bigint(20) NOT NULL,
  `name` varchar(255) collate utf8_turkish_ci default NULL,
  `description` varchar(256) collate utf8_turkish_ci NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `base_type_id` (`base_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci AUTO_INCREMENT=3 ;

--
-- Tablo döküm verisi `info_types`
--

INSERT INTO `info_types` (`id`, `base_type_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Adres', 'İletişim bilgileri - adres', NULL, NULL),
(2, 2, 'Adet', 'Ürün bilgileri - adet', NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo yapısı: `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20090503114152'),
('20090503114206'),
('20090503114346'),
('20090503114450'),
('20090503114805'),
('20090503123126');

-- --------------------------------------------------------

--
-- Tablo yapısı: `section_types`
--

CREATE TABLE IF NOT EXISTS `section_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `sequence` int(11) default NULL,
  `onleft` tinyint(1) default NULL,
  `owner` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Tablo döküm verisi `section_types`
--

INSERT INTO `section_types` (`id`, `name`, `sequence`, `onleft`, `owner`, `created_at`, `updated_at`) VALUES
(1, 'Ürün Bilgileri', 110, 1, 'tender', NULL, NULL),
(2, 'Adres Bilgileri', 210, 0, 'tender', NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo yapısı: `section_type_infos`
--

CREATE TABLE IF NOT EXISTS `section_type_infos` (
  `id` int(11) NOT NULL auto_increment,
  `sequence` int(11) default NULL,
  `info_type_id` int(11) default NULL,
  `section_type_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Tablo döküm verisi `section_type_infos`
--

INSERT INTO `section_type_infos` (`id`, `sequence`, `info_type_id`, `section_type_id`, `created_at`, `updated_at`) VALUES
(1, 10, 2, 1, NULL, NULL),
(2, 10, 1, 2, NULL, NULL);

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `demand_types_section_types`
--
ALTER TABLE `demand_types_section_types`
  ADD CONSTRAINT `demand_types_section_types_ibfk_2` FOREIGN KEY (`section_type_id`) REFERENCES `section_types` (`id`),
  ADD CONSTRAINT `demand_types_section_types_ibfk_1` FOREIGN KEY (`demand_type_id`) REFERENCES `demand_types` (`id`);
