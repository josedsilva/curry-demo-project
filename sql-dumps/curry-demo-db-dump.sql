-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: curry_demo
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE KEY `city_slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Stockholm','stockholm'),(2,'Solna','solna'),(3,'Ekerö','ekero');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_rt`
--

DROP TABLE IF EXISTS `co_rt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `co_rt` (
  `company_id` int(11) NOT NULL,
  `recycling_type_id` int(11) NOT NULL,
  PRIMARY KEY (`company_id`,`recycling_type_id`),
  KEY `co_rt_FI_2` (`recycling_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_rt`
--

LOCK TABLES `co_rt` WRITE;
/*!40000 ALTER TABLE `co_rt` DISABLE KEYS */;
INSERT INTO `co_rt` VALUES (1,4),(1,7),(1,8),(1,9),(2,2),(2,3);
/*!40000 ALTER TABLE `co_rt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `org_number` varchar(25) NOT NULL,
  `city_id` int(11) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `contact_person` varchar(255) NOT NULL,
  `telephone` varchar(25) NOT NULL,
  `email` varchar(64) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_slug` (`slug`),
  KEY `company_FI_1` (`city_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Recycling United Scandinavia','12345678',1,'12345678','Jose D\'Silva','12345678','jose.dsilva@bombayworks.se','recycling-united-scandinavia'),(2,'Bombayworks Recycling','78654389',1,'123567','Test','12346789','test@test.com','bombayworks-recycling');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filebrowser_access`
--

DROP TABLE IF EXISTS `filebrowser_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filebrowser_access` (
  `filebrowser_access_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `write` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`filebrowser_access_id`),
  KEY `filebrowser_access_FI_1` (`user_id`),
  KEY `filebrowser_access_FI_2` (`user_role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filebrowser_access`
--

LOCK TABLES `filebrowser_access` WRITE;
/*!40000 ALTER TABLE `filebrowser_access` DISABLE KEYS */;
INSERT INTO `filebrowser_access` VALUES (1,NULL,1,'Root','',1),(2,2,NULL,'Home','user-content/2/',1);
/*!40000 ALTER TABLE `filebrowser_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `langcode` varchar(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`langcode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_string`
--

DROP TABLE IF EXISTS `language_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_string` (
  `id` varchar(255) NOT NULL,
  `element_type` varchar(255) DEFAULT NULL,
  `last_used` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_string`
--

LOCK TABLES `language_string` WRITE;
/*!40000 ALTER TABLE `language_string` DISABLE KEYS */;
INSERT INTO `language_string` VALUES ('LogoImage',NULL,'2016-03-27 17:18:51'),('Email',NULL,'2016-03-27 17:18:51'),('ContactEmail',NULL,'2016-03-27 17:18:51'),('Phone',NULL,'2016-03-27 17:18:51'),('ContactPhoneNumber',NULL,'2016-03-27 17:18:51');
/*!40000 ALTER TABLE `language_string` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_string_translation`
--

DROP TABLE IF EXISTS `language_string_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_string_translation` (
  `langcode` varchar(8) NOT NULL,
  `string_id` varchar(255) NOT NULL,
  `translation` text NOT NULL,
  PRIMARY KEY (`langcode`,`string_id`),
  KEY `language_string_translation_FI_2` (`string_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_string_translation`
--

LOCK TABLES `language_string_translation` WRITE;
/*!40000 ALTER TABLE `language_string_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `language_string_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadata`
--

DROP TABLE IF EXISTS `metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadata` (
  `name` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `default_value` varchar(255) NOT NULL DEFAULT '',
  `sortable_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadata`
--

LOCK TABLES `metadata` WRITE;
/*!40000 ALTER TABLE `metadata` DISABLE KEYS */;
INSERT INTO `metadata` VALUES ('Title','text','Title','',1),('Keywords','textarea','Keywords','',2),('Description','textarea','Description','',3),('Image','previewImage','Image','',4);
/*!40000 ALTER TABLE `metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `module_class` varchar(255) NOT NULL,
  `content_visibility` int(11) NOT NULL DEFAULT '1',
  `search_visibility` tinyint(1) NOT NULL DEFAULT '1',
  `targets_exclude` tinyint(1) NOT NULL DEFAULT '1',
  `targets` text NOT NULL,
  `template` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_data`
--

DROP TABLE IF EXISTS `module_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_data` (
  `module_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `page_module_id` int(11) NOT NULL,
  `page_revision_id` int(11) NOT NULL,
  `langcode` varchar(8) NOT NULL DEFAULT '',
  `template` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`module_data_id`),
  UNIQUE KEY `module_data_U_1` (`page_module_id`,`page_revision_id`,`langcode`),
  KEY `module_data_FI_2` (`page_revision_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_data`
--

LOCK TABLES `module_data` WRITE;
/*!40000 ALTER TABLE `module_data` DISABLE KEYS */;
INSERT INTO `module_data` VALUES (1,1,2,'',NULL,1,'O:21:\"Curry_Module_Includes\":4:{s:9:\"\0*\0minify\";b:0;s:9:\"\0*\0script\";a:2:{i:1;a:5:{s:6:\"source\";s:15:\"js/modernizr.js\";s:4:\"type\";s:15:\"text/javascript\";s:9:\"condition\";s:8:\"lte IE 8\";s:5:\"async\";N;s:5:\"defer\";N;}i:2;a:5:{s:6:\"source\";s:22:\"js/jquery-1-9-1.min.js\";s:4:\"type\";s:15:\"text/javascript\";s:9:\"condition\";s:0:\"\";s:5:\"async\";N;s:5:\"defer\";a:1:{i:0;s:1:\"1\";}}}s:13:\"\0*\0stylesheet\";a:5:{i:1;a:3:{s:6:\"source\";s:13:\"css/reset.css\";s:5:\"media\";s:3:\"all\";s:9:\"condition\";s:0:\"\";}i:2;a:3:{s:6:\"source\";s:15:\"css/vanilla.css\";s:5:\"media\";s:3:\"all\";s:9:\"condition\";s:0:\"\";}i:3;a:3:{s:6:\"source\";s:14:\"css/styles.css\";s:5:\"media\";s:3:\"all\";s:9:\"condition\";s:0:\"\";}i:4;a:3:{s:6:\"source\";s:18:\"css/styles-ie8.css\";s:5:\"media\";s:3:\"all\";s:9:\"condition\";s:8:\"lte IE 8\";}i:5;a:3:{s:6:\"source\";s:18:\"css/styles-ie7.css\";s:5:\"media\";s:3:\"all\";s:9:\"condition\";s:8:\"lte IE 7\";}}s:15:\"\0*\0inlineScript\";s:0:\"\";}','2016-03-18 20:03:00','2016-03-18 20:24:21'),(2,2,2,'','Modules/Navigation.html.twig',1,'O:23:\"Curry_Module_Navigation\":5:{s:9:\"\0*\0pageId\";s:1:\"1\";s:14:\"\0*\0depthOffset\";s:1:\"0\";s:16:\"\0*\0useParentPage\";s:1:\"0\";s:13:\"\0*\0showHidden\";s:1:\"0\";s:12:\"\0*\0sortOrder\";s:1:\"0\";}','2016-03-18 21:05:18','2016-03-18 21:15:57'),(4,3,2,'',NULL,1,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:13:\"<p><br /></p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-03-18 21:38:50','2016-03-18 21:38:50'),(5,3,4,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:38:\"<p>Some text for the Article page.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-03-18 21:39:22','2016-03-18 21:39:43'),(6,3,3,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:35:\"<p>Some text for the Demo page.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-03-18 21:39:47','2016-03-18 21:40:01'),(7,4,6,'','Modules/QuoteRequest.html.twig',1,'O:27:\"Project_Module_QuoteRequest\":0:{}','2016-03-26 14:18:44','2016-03-26 14:18:44'),(8,5,3,'','Modules/SecondaryNavigation.html.twig',1,'O:23:\"Curry_Module_Navigation\":5:{s:9:\"\0*\0pageId\";s:1:\"5\";s:14:\"\0*\0depthOffset\";s:1:\"0\";s:16:\"\0*\0useParentPage\";s:1:\"0\";s:13:\"\0*\0showHidden\";s:1:\"0\";s:12:\"\0*\0sortOrder\";s:1:\"0\";}','2016-03-27 12:26:21','2016-03-27 12:33:23'),(9,3,6,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:221:\"<p>We created a custom page module named QuoteRequest and attached it to this page. Below is the zend form that enables use to make a quote request. The form will validate input and save the data into the Quote table.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-03-27 12:41:02','2016-03-27 12:46:21'),(10,6,8,'',NULL,1,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:444:\"<p>Hello {{ company.ContactPerson }},</p>\r\n<p>We have a new quote request for you. Below is some teaser information:</p>\r\n<pre>Heading: {{ quote.Heading }}\r\nService period required: {{ quote.ServicePeriod }}\r\nRecycling type: {{ quote.RecyclingType.Name }}\r\n</pre>\r\n<p>If you find this interesting please click the link below to make an agreement and see the client\'s contact information.</p>\r\n<p><a href=\"{{ buy_quote_link }}\">Buy Quote</a></p>\";s:22:\"\0*\0allowTemplateSyntax\";b:1;}','2016-03-27 17:36:29','2016-03-27 17:46:33'),(11,7,9,'','Modules/BuyQuote.html.twig',1,'O:23:\"Project_Module_BuyQuote\":0:{}','2016-04-03 20:22:45','2016-04-03 20:41:35'),(12,3,9,'',NULL,0,NULL,'2016-04-03 20:48:11','2016-04-03 20:48:11'),(13,3,10,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:355:\"<p>Here we demonstrate the sandbox capability of Curry CMS. The module that queries companies will pass the query object (ModelCriteria) to the template. In the template we iterate over the result of execution of ModelCriteria. However, there is no PropelObjectCollection available in the template, just an array representation for each Propel object.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-04-16 14:30:24','2016-04-16 17:06:26'),(14,8,10,'','Modules/CompanyList.twig',1,'O:26:\"Project_Module_CompanyList\":0:{}','2016-04-16 14:43:02','2016-04-16 14:43:02'),(15,3,11,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:55:\"<p>Here we demonstrate Curry\'s search capabilities.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-04-17 21:00:36','2016-04-17 21:00:56'),(16,9,11,'','Modules/Search.html.twig',1,'O:19:\"Curry_Module_Search\":3:{s:16:\"\0*\0snippetLength\";i:255;s:19:\"\0*\0onlyThisLanguage\";b:1;s:17:\"\0*\0alwaysWildcard\";b:0;}','2016-04-17 21:04:09','2016-04-17 21:08:11'),(17,3,12,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:35:\"<p>Here we show search results.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-04-17 21:09:48','2016-04-17 21:10:05'),(18,10,12,'','Modules/Search.html.twig',1,'O:19:\"Curry_Module_Search\":3:{s:16:\"\0*\0snippetLength\";i:255;s:19:\"\0*\0onlyThisLanguage\";b:1;s:17:\"\0*\0alwaysWildcard\";b:0;}','2016-04-17 21:10:51','2016-04-17 21:10:51'),(19,11,11,'','Modules/SearchForm.html.twig',1,'O:21:\"Curry_Module_Template\":0:{}','2016-04-17 21:27:25','2016-04-17 21:27:25'),(20,12,13,'','Modules/CompanyDetail.html.twig',1,'O:28:\"Project_Module_CompanyDetail\":0:{}','2016-04-19 14:36:40','2016-04-19 14:36:40'),(21,3,13,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:127:\"<p>Here we demonstrate how dynamic pages are constructed. This page is a placeholder page that shows details for a company.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-04-19 14:43:42','2016-04-19 14:44:31'),(22,13,14,'','Modules/CompanyByCity.html.twig',1,'O:28:\"Project_Module_CompanyByCity\":0:{}','2016-04-19 16:09:35','2016-04-19 16:09:35'),(23,3,14,'',NULL,NULL,'O:20:\"Curry_Module_Article\":3:{s:9:\"\0*\0editor\";s:0:\"\";s:10:\"\0*\0content\";s:72:\"<p>Demonstrate dynamic page construction by defining a custom route.</p>\";s:22:\"\0*\0allowTemplateSyntax\";b:0;}','2016-04-19 16:13:15','2016-04-19 16:13:52');
/*!40000 ALTER TABLE `module_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_sortorder`
--

DROP TABLE IF EXISTS `module_sortorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_sortorder` (
  `page_module_id` int(11) NOT NULL,
  `page_revision_id` int(11) NOT NULL,
  `sortable_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`page_module_id`,`page_revision_id`),
  KEY `module_sortorder_FI_2` (`page_revision_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_sortorder`
--

LOCK TABLES `module_sortorder` WRITE;
/*!40000 ALTER TABLE `module_sortorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `module_sortorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package` (
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_file`
--

DROP TABLE IF EXISTS `package_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_file` (
  `package_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `package_name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `checksum` varchar(40) NOT NULL,
  PRIMARY KEY (`package_file_id`),
  KEY `package_file_FI_1` (`package_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_file`
--

LOCK TABLES `package_file` WRITE;
/*!40000 ALTER TABLE `package_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `include_in_index` tinyint(1) NOT NULL DEFAULT '1',
  `active_page_revision_id` int(11) DEFAULT NULL,
  `working_page_revision_id` int(11) DEFAULT NULL,
  `redirect_method` tinyint(4) DEFAULT NULL,
  `redirect_page_id` int(11) DEFAULT NULL,
  `redirect_url` varchar(255) DEFAULT NULL,
  `model_route` varchar(255) DEFAULT NULL,
  `cache_lifetime` int(11) NOT NULL DEFAULT '0',
  `image` varchar(255) DEFAULT '',
  `langcode` varchar(8) DEFAULT NULL,
  `generator` varchar(255) DEFAULT NULL,
  `encoding` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tree_left` int(11) DEFAULT NULL,
  `tree_right` int(11) DEFAULT NULL,
  `tree_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `page_U_1` (`uid`),
  KEY `page_FI_1` (`active_page_revision_id`),
  KEY `page_FI_2` (`working_page_revision_id`),
  KEY `page_FI_3` (`redirect_page_id`),
  KEY `page_FI_4` (`langcode`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,'OtjAHQUzVj0RW688','Home','/',1,1,1,1,1,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-16 17:39:13','2016-03-16 17:39:13',1,28,0),(2,'4S34qcD7hddqWw2d','Templates','templates/',0,0,0,2,2,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-17 11:12:08','2016-03-17 20:41:29',2,11,1),(3,'v7E1C1osoE3QELxG','Demo','templates/demo/',0,0,0,3,3,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-17 20:05:21','2016-03-17 20:05:22',9,10,2),(4,'3LXqFWNdmDJOsTeh','Article','templates/article/',0,0,0,4,4,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-17 20:41:29','2016-03-17 20:41:32',7,8,2),(5,'eRW1eMTRxqgyBaF0','Demo','demo/',1,1,1,5,5,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-18 21:12:11','2016-04-19 14:59:54',12,27,1),(6,'TWFxu5njgnnH9unK','QuoteRequest','demo/quoterequest/',1,1,0,6,6,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-26 14:18:18','2016-03-27 12:33:32',13,14,2),(7,'o9FUA3yArYB2viBF','EmailRoot','emailroot/',0,0,0,7,7,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-27 17:14:26','2016-03-27 17:27:19',3,6,2),(8,'F3qQVQ5JDnlPMDmK','QuoteEmail','emailroot/quoteemail/',0,0,0,8,8,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-27 17:25:53','2016-03-27 17:30:38',4,5,3),(9,'dCYQNaY0pNTtFPrc','Buy Quote','demo/buy-quote/',0,1,0,9,9,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-03-27 18:06:28','2016-03-27 18:06:28',15,16,2),(10,'CnOej8af5nCQAJCp','Companies','demo/companies/',1,1,1,10,10,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-04-16 14:29:59','2016-04-16 14:29:59',17,18,2),(11,'x7TLA0vwi2m9xVVQ','Search','demo/search/',1,1,0,11,11,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-04-17 20:59:31','2016-04-17 21:09:28',19,22,2),(12,'3JiYPtbA8jQ5vVnu','Results','demo/search/results/',0,1,0,12,12,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-04-17 21:09:28','2016-04-17 21:09:28',20,21,3),(13,'lCJmn8C88EN3zJmn','Company','demo/company/',0,1,1,13,13,NULL,NULL,NULL,'Company',0,'',NULL,NULL,NULL,'2016-04-19 13:48:26','2016-04-19 13:56:54',23,24,2),(14,'mGpYR9xfCVWdSZVt','CustomRoute','demo/customroute/',0,1,0,14,14,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,'2016-04-19 14:59:54','2016-04-19 14:59:54',25,26,2);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_access`
--

DROP TABLE IF EXISTS `page_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_access` (
  `page_access_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `page_id` int(11) NOT NULL,
  `perm_subpages` tinyint(1) NOT NULL,
  `perm_visible` tinyint(1) DEFAULT NULL,
  `perm_create_page` tinyint(1) DEFAULT NULL,
  `perm_create_module` tinyint(1) DEFAULT NULL,
  `perm_publish` tinyint(1) DEFAULT NULL,
  `perm_properties` tinyint(1) DEFAULT NULL,
  `perm_content` tinyint(1) DEFAULT NULL,
  `perm_meta` tinyint(1) DEFAULT NULL,
  `perm_modules` tinyint(1) DEFAULT NULL,
  `perm_revisions` tinyint(1) DEFAULT NULL,
  `perm_permissions` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`page_access_id`),
  KEY `page_access_FI_1` (`user_id`),
  KEY `page_access_FI_2` (`user_role_id`),
  KEY `page_access_FI_3` (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_access`
--

LOCK TABLES `page_access` WRITE;
/*!40000 ALTER TABLE `page_access` DISABLE KEYS */;
INSERT INTO `page_access` VALUES (1,NULL,NULL,1,1,1,1,1,1,1,1,1,1,1,1);
/*!40000 ALTER TABLE `page_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_metadata`
--

DROP TABLE IF EXISTS `page_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_metadata` (
  `page_revision_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`page_revision_id`,`name`),
  KEY `page_metadata_FI_2` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_metadata`
--

LOCK TABLES `page_metadata` WRITE;
/*!40000 ALTER TABLE `page_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_module`
--

DROP TABLE IF EXISTS `page_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_module` (
  `page_module_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(16) NOT NULL,
  `page_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `module_class` varchar(255) NOT NULL,
  `content_visibility` int(11) NOT NULL DEFAULT '1',
  `search_visibility` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`page_module_id`),
  UNIQUE KEY `page_module_U_1` (`uid`),
  KEY `page_module_FI_1` (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_module`
--

LOCK TABLES `page_module` WRITE;
/*!40000 ALTER TABLE `page_module` DISABLE KEYS */;
INSERT INTO `page_module` VALUES (1,'Mk8p64ZIFEqaREKj',2,'Includes','void','Curry_Module_Includes',0,1,'2016-03-18 20:03:00','2016-03-18 20:03:00'),(2,'TuUffHmXHzoRTYc5',2,'Navigation','primary-navigation','Curry_Module_Navigation',0,0,'2016-03-18 21:05:18','2016-04-30 18:55:07'),(3,'6FRD4p0iqmerUjVC',2,'Article','article','Curry_Module_Article',1,1,'2016-03-18 21:38:50','2016-03-18 21:38:50'),(4,'xDToUCKJqxreLgJx',6,'QuoteRequest','content','Project_Module_QuoteRequest',1,1,'2016-03-26 14:18:44','2016-03-26 14:18:44'),(5,'lmxLsoXZfn6apBMr',3,'SecondaryNavigation','demo-pages','Curry_Module_Navigation',0,0,'2016-03-27 12:26:21','2016-03-27 12:26:21'),(6,'1LSlTiQLIKYvRBaR',8,'Article','content','Curry_Module_Article',1,0,'2016-03-27 17:36:29','2016-03-27 17:36:29'),(7,'zEl9shwTSDsrDlM0',9,'BuyQuote','content','Project_Module_BuyQuote',0,0,'2016-04-03 20:22:45','2016-04-03 20:22:45'),(8,'q7zrtToXalKo2IP9',10,'CompanyList','content','Project_Module_CompanyList',2,0,'2016-04-16 14:43:02','2016-04-30 19:05:31'),(9,'dJWDXTsvJCpj1GMz',11,'Search','content','Curry_Module_Search',1,0,'2016-04-17 21:04:09','2016-04-17 21:04:09'),(10,'o8NpiHhIr0KVWLqi',12,'Search','content','Curry_Module_Search',1,0,'2016-04-17 21:10:51','2016-04-17 21:10:51'),(11,'A2nTUjAEStaST5Mn',11,'Template','content','Curry_Module_Template',0,0,'2016-04-17 21:27:25','2016-04-17 21:27:25'),(12,'nHyFo0r19dtoYcEB',13,'CompanyDetail','content','Project_Module_CompanyDetail',0,0,'2016-04-19 14:36:40','2016-04-19 14:36:40'),(13,'FiNlttJaFKfOWeIJ',14,'CompanyByCity','content','Project_Module_CompanyByCity',0,0,'2016-04-19 16:09:35','2016-04-19 16:09:35');
/*!40000 ALTER TABLE `page_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_revision`
--

DROP TABLE IF EXISTS `page_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_revision` (
  `page_revision_id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `template` varchar(255) DEFAULT NULL,
  `base_page_id` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `publish_date` datetime DEFAULT NULL,
  `published_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`page_revision_id`),
  KEY `page_revision_FI_1` (`page_id`),
  KEY `page_revision_FI_2` (`base_page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_revision`
--

LOCK TABLES `page_revision` WRITE;
/*!40000 ALTER TABLE `page_revision` DISABLE KEYS */;
INSERT INTO `page_revision` VALUES (1,1,NULL,4,'Base (auto-created)',NULL,'2016-03-16 17:39:13','2016-03-16 17:39:13','2016-03-18 21:15:48'),(2,2,'GenericPage.html.twig',NULL,'Base (auto-created)',NULL,'2016-03-17 11:12:09','2016-03-17 11:12:09','2016-04-30 18:55:07'),(3,3,'Demo.html.twig',2,'Base (auto-created)',NULL,'2016-03-17 20:05:22','2016-03-17 20:05:22','2016-03-27 12:33:23'),(4,4,'Article.html.twig',2,'Base (auto-created)',NULL,'2016-03-17 20:41:29','2016-03-17 20:41:29','2016-03-18 21:39:43'),(5,5,NULL,3,'Base (auto-created)',NULL,'2016-03-18 21:12:11','2016-03-18 21:12:11','2016-03-18 21:12:11'),(6,6,NULL,5,'Base (auto-created)',NULL,'2016-03-26 14:18:19','2016-03-26 14:18:19','2016-03-27 12:46:21'),(7,7,'Emails/EmailRoot.twig',NULL,'Base (auto-created)',NULL,'2016-03-27 17:14:26','2016-03-27 17:14:26','2016-03-27 17:18:45'),(8,8,NULL,7,'Base (auto-created)',NULL,'2016-03-27 17:25:53','2016-03-27 17:25:53','2016-03-27 17:46:33'),(9,9,NULL,5,'Base (auto-created)',NULL,'2016-03-27 18:06:28','2016-03-27 18:06:28','2016-04-03 20:48:11'),(10,10,NULL,5,'Base (auto-created)',NULL,'2016-04-16 14:29:59','2016-04-16 14:29:59','2016-04-30 19:05:31'),(11,11,NULL,5,'Base (auto-created)',NULL,'2016-04-17 20:59:31','2016-04-17 20:59:31','2016-04-17 21:08:11'),(12,12,NULL,11,'Base (auto-created)',NULL,'2016-04-17 21:09:28','2016-04-17 21:09:28','2016-04-17 21:10:05'),(13,13,NULL,5,'Base (auto-created)',NULL,'2016-04-19 13:48:26','2016-04-19 13:48:26','2016-04-19 14:44:31'),(14,14,NULL,5,'Base (auto-created)',NULL,'2016-04-19 14:59:54','2016-04-19 14:59:54','2016-04-19 16:13:52');
/*!40000 ALTER TABLE `page_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propel_migration`
--

DROP TABLE IF EXISTS `propel_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propel_migration` (
  `version` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propel_migration`
--

LOCK TABLES `propel_migration` WRITE;
/*!40000 ALTER TABLE `propel_migration` DISABLE KEYS */;
INSERT INTO `propel_migration` VALUES (1461057889);
/*!40000 ALTER TABLE `propel_migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quote`
--

DROP TABLE IF EXISTS `quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quote` (
  `quote_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL,
  `heading` varchar(255) DEFAULT NULL,
  `service_period` tinyint(4) NOT NULL,
  `recycling_type_id` int(11) NOT NULL,
  `client_name` varchar(64) NOT NULL,
  `client_email` varchar(128) NOT NULL,
  `client_telephone` varchar(255) NOT NULL,
  `client_city_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`quote_id`),
  KEY `quote_FI_1` (`recycling_type_id`),
  KEY `quote_FI_2` (`client_city_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quote`
--

LOCK TABLES `quote` WRITE;
/*!40000 ALTER TABLE `quote` DISABLE KEYS */;
INSERT INTO `quote` VALUES (1,1,'Test quote 1',0,3,'Jose Dsilva','jose.dsilva@bombayworks.se','123456',1,'2016-03-27 12:17:04','2016-03-29 19:16:04'),(2,0,'Another quote',0,1,'Peter Andrews','peter@gmail.com','125678945',1,'2016-04-08 22:07:09','2016-04-08 22:09:13');
/*!40000 ALTER TABLE `quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quote_company`
--

DROP TABLE IF EXISTS `quote_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quote_company` (
  `quote_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`quote_id`,`company_id`),
  KEY `quote_company_FI_2` (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quote_company`
--

LOCK TABLES `quote_company` WRITE;
/*!40000 ALTER TABLE `quote_company` DISABLE KEYS */;
INSERT INTO `quote_company` VALUES (1,1,NULL,NULL);
/*!40000 ALTER TABLE `quote_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recycling_type`
--

DROP TABLE IF EXISTS `recycling_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recycling_type` (
  `recycling_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`recycling_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recycling_type`
--

LOCK TABLES `recycling_type` WRITE;
/*!40000 ALTER TABLE `recycling_type` DISABLE KEYS */;
INSERT INTO `recycling_type` VALUES (1,'Cardboard & Paper Recycling Services'),(2,'Electronic Recycling & E-Waste Solutions'),(3,'Plastic Recycling Services'),(4,'Car Scrap Recycling Services'),(5,'Solid Waste Services'),(6,'Compactors, Balers & Other Equipment'),(7,'Recycling Equipment (Heavy Duty)'),(8,'Secure Destruction & Shredding Services'),(9,'Metal & Scrap Recycling Services');
/*!40000 ALTER TABLE `recycling_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repository`
--

DROP TABLE IF EXISTS `repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository` (
  `repository_id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repository`
--

LOCK TABLES `repository` WRITE;
/*!40000 ALTER TABLE `repository` DISABLE KEYS */;
/*!40000 ALTER TABLE `repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision_module`
--

DROP TABLE IF EXISTS `revision_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision_module` (
  `page_module_id` int(11) NOT NULL,
  `page_revision_id` int(11) NOT NULL,
  PRIMARY KEY (`page_module_id`,`page_revision_id`),
  KEY `revision_module_FI_2` (`page_revision_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision_module`
--

LOCK TABLES `revision_module` WRITE;
/*!40000 ALTER TABLE `revision_module` DISABLE KEYS */;
INSERT INTO `revision_module` VALUES (1,2),(2,2),(3,2),(4,6),(5,3),(6,8),(7,9),(8,10),(10,12),(11,11),(12,13),(13,14);
/*!40000 ALTER TABLE `revision_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_U_1` (`name`),
  KEY `user_FI_1` (`user_role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2y$10$kS4u3lInHMvd.CamZYugzuTWs3s7IpX3IY/evBQbcnGa6kDUL..HS',1),(2,'user','$2y$10$sbml0WwUwkc4l434dX73rOdIA57vPjd84j5QhYnOCt2XW2S.h2D1O',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_language`
--

DROP TABLE IF EXISTS `user_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_language` (
  `user_id` int(11) NOT NULL,
  `langcode` varchar(8) NOT NULL,
  PRIMARY KEY (`user_id`,`langcode`),
  KEY `user_language_FI_2` (`langcode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_language`
--

LOCK TABLES `user_language` WRITE;
/*!40000 ALTER TABLE `user_language` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'Super'),(2,'User');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role_access`
--

DROP TABLE IF EXISTS `user_role_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role_access` (
  `user_role_access_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_role_id` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  PRIMARY KEY (`user_role_access_id`),
  UNIQUE KEY `user_role_access_U_1` (`user_role_id`,`module`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role_access`
--

LOCK TABLES `user_role_access` WRITE;
/*!40000 ALTER TABLE `user_role_access` DISABLE KEYS */;
INSERT INTO `user_role_access` VALUES (1,1,'*'),(2,1,'Curry_Backend_Content/*'),(3,2,'Curry_Backend_FileBrowser'),(4,2,'Curry_Backend_Page'),(5,2,'Curry_Backend_Profile'),(6,2,'Curry_Backend_Translations'),(7,2,'Curry_Backend_Content/*');
/*!40000 ALTER TABLE `user_role_access` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-07 18:43:16
