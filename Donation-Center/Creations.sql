-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema donation
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `donation` ;

-- -----------------------------------------------------
-- Schema donation
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `donation` DEFAULT CHARACTER SET utf8 ;
USE `donation` ;

-- -----------------------------------------------------
-- Table `donation`.`Donors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Donors` (
  `Ssn` INT NOT NULL,
  `Dname` VARCHAR(45) NOT NULL,
  `Dphone` INT NOT NULL,
  PRIMARY KEY (`Ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donation`.` donations committee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.` donations committee` (
  `cphone` INT NOT NULL,
  `address` VARCHAR(40) NOT NULL,
  `cname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cphone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donation`.`Donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Donations` (
  `dno` INT NOT NULL,
  `dtype` VARCHAR(45) NOT NULL,
  `cphone` INT NOT NULL,
  PRIMARY KEY (`dno`),
  CONSTRAINT `fk_donations_ donations committee1`
    FOREIGN KEY (`cphone`)
    REFERENCES `donation`.` donations committee` (`cphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_donations_ donations committee1_idx` ON `donation`.`Donations` (`cphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Items` (
  `ino` INT NOT NULL,
  `quantity` VARCHAR(45) NULL,
  `itype` VARCHAR(45) NULL,
  `cphone` INT NOT NULL,
  PRIMARY KEY (`ino`),
  CONSTRAINT `fk_items_ donations committee`
    FOREIGN KEY (`cphone`)
    REFERENCES `donation`.` donations committee` (`cphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_items_ donations committee_idx` ON `donation`.`Items` (`cphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Receptionists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Receptionists` (
  `gender` VARCHAR(20) NOT NULL,
  `rnames` VARCHAR(45) NOT NULL,
  `rid` INT NOT NULL,
  `Cphone` INT NOT NULL,
  `Hours` INT NOT NULL,
  PRIMARY KEY (`rid`),
  CONSTRAINT `fk_receptionists_ donations committee1`
    FOREIGN KEY (`Cphone`)
    REFERENCES `donation`.` donations committee` (`cphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_receptionists_ donations committee1_idx` ON `donation`.`Receptionists` (`Cphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`project` (
  `pro_name` VARCHAR(20) NOT NULL,
  `pro_no` INT NOT NULL,
  `cphone` INT NOT NULL,
  `cost` INT NOT NULL,
  PRIMARY KEY (`pro_no`),
  CONSTRAINT `fk_mangers_ donations committee1`
    FOREIGN KEY (`cphone`)
    REFERENCES `donation`.` donations committee` (`cphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mangers_ donations committee1_idx` ON `donation`.`project` (`cphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`needy_people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`needy_people` (
  `nname` VARCHAR(20) NOT NULL,
  `age` INT NOT NULL,
  `nphone` INT NOT NULL,
  `ntype` VARCHAR(45) NULL,
  `rid` INT NOT NULL,
  PRIMARY KEY (`nphone`),
  CONSTRAINT `fk_needy_people_Receptionists1`
    FOREIGN KEY (`rid`)
    REFERENCES `donation`.`Receptionists` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_needy_people_Receptionists1_idx` ON `donation`.`needy_people` (`rid` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Orphans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Orphans` (
  `nphone` INT NOT NULL,
  `ono` INT NOT NULL,
  `Des_oname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nphone`),
  CONSTRAINT `fk_Orphans_ needy people1`
    FOREIGN KEY (`nphone`)
    REFERENCES `donation`.`needy_people` (`nphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Orphans_ needy people1_idx` ON `donation`.`Orphans` (`nphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`poor_people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`poor_people` (
  `nphone` INT NOT NULL,
  `pno` INT NOT NULL,
  `des_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nphone`),
  CONSTRAINT `fk_poor_people_ needy people1`
    FOREIGN KEY (`nphone`)
    REFERENCES `donation`.`needy_people` (`nphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_poor_people_ needy people1_idx` ON `donation`.`poor_people` (`nphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`patients` (
  `nphone` INT NOT NULL,
  `patient_no` INT NOT NULL,
  `Des_pname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nphone`),
  CONSTRAINT `fk_patients_ needy people1`
    FOREIGN KEY (`nphone`)
    REFERENCES `donation`.`needy_people` (`nphone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_patients_ needy people1_idx` ON `donation`.`patients` (`nphone` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Family_Sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Family_Sector` (
  `DSsn` INT NOT NULL,
  `no` INT NOT NULL,
  `f_amount` INT NOT NULL,
  PRIMARY KEY (`DSsn`),
  CONSTRAINT `fk_Family_Sector_Donors1`
    FOREIGN KEY (`DSsn`)
    REFERENCES `donation`.`Donors` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Family_Sector_Donors1_idx` ON `donation`.`Family_Sector` (`DSsn` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Private_Sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Private_Sector` (
  `Dssn` INT NOT NULL,
  `pname` VARCHAR(20) NOT NULL,
  `p_amount` INT NOT NULL,
  PRIMARY KEY (`Dssn`),
  CONSTRAINT `fk_Private_Sector_Donors1`
    FOREIGN KEY (`Dssn`)
    REFERENCES `donation`.`Donors` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Private_Sector_Donors1_idx` ON `donation`.`Private_Sector` (`Dssn` ASC);


-- -----------------------------------------------------
-- Table `donation`.`non-profit_sectror`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`non-profit_sectror` (
  `Dssn` INT NOT NULL,
  `sname` VARCHAR(20) NOT NULL,
  `n_amount` INT NOT NULL,
  PRIMARY KEY (`Dssn`),
  CONSTRAINT `fk_non-profit_sectror_Donors1`
    FOREIGN KEY (`Dssn`)
    REFERENCES `donation`.`Donors` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_non-profit_sectror_Donors1_idx` ON `donation`.`non-profit_sectror` (`Dssn` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Department` (
  `Dname` VARCHAR(15) NOT NULL,
  `Dno` INT NOT NULL,
  `Employee_Ssn` CHAR(9) NOT NULL,
  PRIMARY KEY (`Dno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donation`.`Dept_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Dept_locations` (
  `Dno` INT NOT NULL,
  `Dlocation` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Dno`, `Dlocation`),
  CONSTRAINT `fk_Dept_locations_Department1`
    FOREIGN KEY (`Dno`)
    REFERENCES `donation`.`Department` (`Dno`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_Dept_locations_Department1_idx` ON `donation`.`Dept_locations` (`Dno` ASC);


-- -----------------------------------------------------
-- Table `donation`.`Dependent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Dependent` (
  `Essn` CHAR(9) NOT NULL,
  `Dependent_name` VARCHAR(15) NOT NULL,
  `Sex` CHAR NULL,
  `Bdate` DATE NULL,
  `Relationship` VARCHAR(8) NULL,
  PRIMARY KEY (`Essn`, `Dependent_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donation`.`Donate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`Donate` (
  `dSsn` INT NOT NULL,
  `dno` INT NOT NULL,
  PRIMARY KEY (`dSsn`, `dno`),
  CONSTRAINT `fk_Donors_has_donations_Donors1`
    FOREIGN KEY (`dSsn`)
    REFERENCES `donation`.`Donors` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Donors_has_donations_donations1`
    FOREIGN KEY (`dno`)
    REFERENCES `donation`.`Donations` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Donors_has_donations_donations1_idx` ON `donation`.`Donate` (`dno` ASC);

CREATE INDEX `fk_Donors_has_donations_Donors1_idx` ON `donation`.`Donate` (`dSsn` ASC);


-- -----------------------------------------------------
-- Table `donation`.`D_loaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`D_loaction` (
  `Donors_Ssn` INT NOT NULL,
  `dlocaltion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Donors_Ssn`, `dlocaltion`),
  CONSTRAINT `fk_Donars_loaction_Donors1`
    FOREIGN KEY (`Donors_Ssn`)
    REFERENCES `donation`.`Donors` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Donars_loaction_Donors1_idx` ON `donation`.`D_loaction` (`Donors_Ssn` ASC);


-- -----------------------------------------------------
-- Table `donation`.`i_names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `donation`.`i_names` (
  `iname` VARCHAR(45) NULL,
  `ino` INT NOT NULL,
  PRIMARY KEY (`iname`),
  CONSTRAINT `fk_i_names_Items1`
    FOREIGN KEY (`ino`)
    REFERENCES `donation`.`Items` (`ino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_i_names_Items1_idx` ON `donation`.`i_names` (`ino` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `donation`.`Donors`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (123454567, 'Mostafa', 25465478);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (333456478, 'Mohamed', 24654657);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (998754654, 'Nader', 01148965745);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (111147897, 'Walid', 01254674546);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (336546547, 'Ahmed', 01056456478);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (354658795, 'John', 0995463254);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (777775464, 'Bassem', 01156457845);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (222254645, 'Hossam', 01256458789);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (888897546, 'Mazen', 01565478954);
INSERT INTO `donation`.`Donors` (`Ssn`, `Dname`, `Dphone`) VALUES (111123457, 'khaled', 01254545454);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.` donations committee`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.` donations committee` (`cphone`, `address`, `cname`) VALUES (01153716828, '50.Main Street,KA', 'Phael_Khier');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Donations`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (1, 'Clothes', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (2, 'Old_things', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (3, 'Food', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (4, 'Clothes', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (5, 'Medicine', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (6, 'Money', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (7, 'Food', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (8, 'Money', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (9, 'Blood', 01153716828);
INSERT INTO `donation`.`Donations` (`dno`, `dtype`, `cphone`) VALUES (10, 'Food', 01153716828);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Items`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Items` (`ino`, `quantity`, `itype`, `cphone`) VALUES (1, '10', 'Clothes', 01153716828);
INSERT INTO `donation`.`Items` (`ino`, `quantity`, `itype`, `cphone`) VALUES (2, '2', 'Old_things', 01153716828);
INSERT INTO `donation`.`Items` (`ino`, `quantity`, `itype`, `cphone`) VALUES (3, '13', 'food', 01153716828);
INSERT INTO `donation`.`Items` (`ino`, `quantity`, `itype`, `cphone`) VALUES (4, '6', 'medicine', 01153716828);
INSERT INTO `donation`.`Items` (`ino`, `quantity`, `itype`, `cphone`) VALUES (5, '8', 'money', 01153716828);
INSERT INTO `donation`.`Items` (`ino`, `quantity`, `itype`, `cphone`) VALUES (6, '6', 'blood', 01153716828);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Receptionists`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Receptionists` (`gender`, `rnames`, `rid`, `Cphone`, `Hours`) VALUES ('Male', 'Mohamed', 512, 01153716828, 12);
INSERT INTO `donation`.`Receptionists` (`gender`, `rnames`, `rid`, `Cphone`, `Hours`) VALUES ('Female', 'Mena', 310, 01153716828, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`project`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`project` (`pro_name`, `pro_no`, `cphone`, `cost`) VALUES ('schools', 1, 01153716828, 2000);
INSERT INTO `donation`.`project` (`pro_name`, `pro_no`, `cphone`, `cost`) VALUES ('The Life', 2, 01153716828, 3000);
INSERT INTO `donation`.`project` (`pro_name`, `pro_no`, `cphone`, `cost`) VALUES ('El Kheir', 3, 01153716828, 5000);
INSERT INTO `donation`.`project` (`pro_name`, `pro_no`, `cphone`, `cost`) VALUES ('The light', 4, 01153716828, 1000);
INSERT INTO `donation`.`project` (`pro_name`, `pro_no`, `cphone`, `cost`) VALUES ('hospitals', 5, 01153716828, 2050);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`needy_people`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('Maged', 51, 01152222222, 'clothes', 512);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('Hassan', 49, 01200005465, 'old_things', 310);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('Naser', 56, 01054212111, 'money', 310);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('Ashrf', 12, 01154652527, 'medicine', 512);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('Mai', 22, 01250608091, 'blood', 512);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('youssef', 10, 01132323232, 'clothes', 310);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('fahmy', 9, 01233222222, 'money', 310);
INSERT INTO `donation`.`needy_people` (`nname`, `age`, `nphone`, `ntype`, `rid`) VALUES ('nermin', 6, 01123124121, 'food', 512);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Orphans`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Orphans` (`nphone`, `ono`, `Des_oname`) VALUES (01132323232, 10, 'orman');
INSERT INTO `donation`.`Orphans` (`nphone`, `ono`, `Des_oname`) VALUES (01233222222, 20, 'orman');
INSERT INTO `donation`.`Orphans` (`nphone`, `ono`, `Des_oname`) VALUES (01123124121, 30, 'orman');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`poor_people`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`poor_people` (`nphone`, `pno`, `des_name`) VALUES (01054212111, 50, 'menofia');
INSERT INTO `donation`.`poor_people` (`nphone`, `pno`, `des_name`) VALUES (01152222222, 60, 'elmnia');
INSERT INTO `donation`.`poor_people` (`nphone`, `pno`, `des_name`) VALUES (01200005465, 70, 'giza');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`patients`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`patients` (`nphone`, `patient_no`, `Des_pname`) VALUES (01154652527, 80, 'Elsafa');
INSERT INTO `donation`.`patients` (`nphone`, `patient_no`, `Des_pname`) VALUES (01250608091, 107, 'elglaa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Family_Sector`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Family_Sector` (`DSsn`, `no`, `f_amount`) VALUES (123454567, 3, 5);
INSERT INTO `donation`.`Family_Sector` (`DSsn`, `no`, `f_amount`) VALUES (333456478, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Private_Sector`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Private_Sector` (`Dssn`, `pname`, `p_amount`) VALUES (354658795, 'Foreign_investor', 5);
INSERT INTO `donation`.`Private_Sector` (`Dssn`, `pname`, `p_amount`) VALUES (998754654, 'food_company', 4);
INSERT INTO `donation`.`Private_Sector` (`Dssn`, `pname`, `p_amount`) VALUES (111147897, 'Clothes_company', 5);
INSERT INTO `donation`.`Private_Sector` (`Dssn`, `pname`, `p_amount`) VALUES (336546547, 'pharmacy', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`non-profit_sectror`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`non-profit_sectror` (`Dssn`, `sname`, `n_amount`) VALUES (777775464, 'Masr_elkhir', 5);
INSERT INTO `donation`.`non-profit_sectror` (`Dssn`, `sname`, `n_amount`) VALUES (111123457, 'Resala', 4);
INSERT INTO `donation`.`non-profit_sectror` (`Dssn`, `sname`, `n_amount`) VALUES (222254645, 'Magdy_yacoub', 3);
INSERT INTO `donation`.`non-profit_sectror` (`Dssn`, `sname`, `n_amount`) VALUES (888897546, 'Shoryan_Eldam', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Department` (`Dname`, `Dno`, `Employee_Ssn`) VALUES ('Headq', 1, '453453453');
INSERT INTO `donation`.`Department` (`Dname`, `Dno`, `Employee_Ssn`) VALUES ('Administration', 4, '987987987');
INSERT INTO `donation`.`Department` (`Dname`, `Dno`, `Employee_Ssn`) VALUES ('Research', 5, '333445555');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Dept_locations`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Dept_locations` (`Dno`, `Dlocation`) VALUES (1, 'Houston');
INSERT INTO `donation`.`Dept_locations` (`Dno`, `Dlocation`) VALUES (4, 'Stafford');
INSERT INTO `donation`.`Dept_locations` (`Dno`, `Dlocation`) VALUES (5, 'Bellaire');
INSERT INTO `donation`.`Dept_locations` (`Dno`, `Dlocation`) VALUES (5, 'Sugarland');
INSERT INTO `donation`.`Dept_locations` (`Dno`, `Dlocation`) VALUES (5, 'Houston');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Dependent`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('333445555', 'Alice', 'F', '1986-04-05', 'Daughter');
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('333445555', 'Theodore', 'M', '1983-10-25', 'Son');
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('333445555', 'Joy', 'M', '1958-05-03', 'Spouse');
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('987654321', 'Abner', 'M', '1942-02-28', 'Spouse');
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('123456789', 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('123456789', 'Alice', 'F', '1988-12-30', 'Daughter');
INSERT INTO `donation`.`Dependent` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES ('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`Donate`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (123454567, 1);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (333456478, 2);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (998754654, 3);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (111147897, 4);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (336546547, 5);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (354658795, 6);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (777775464, 7);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (222254645, 8);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (888897546, 9);
INSERT INTO `donation`.`Donate` (`dSsn`, `dno`) VALUES (111123457, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`D_loaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (123454567, '12  Main Street,AS');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (333456478, '13  Main Street,NY');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (998754654, '14  Main Street,Mr');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (111147897, '15  Main Street,FS');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (336546547, '16  Main Street,ZC');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (354658795, '731 Fondren,Houston,TX');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (777775464, '22  Nasercity');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (222254645, '7 AzizAbaza st');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (888897546, '33 shehab st');
INSERT INTO `donation`.`D_loaction` (`Donors_Ssn`, `dlocaltion`) VALUES (111123457, '5 giza,doqy');

COMMIT;


-- -----------------------------------------------------
-- Data for table `donation`.`i_names`
-- -----------------------------------------------------
START TRANSACTION;
USE `donation`;
INSERT INTO `donation`.`i_names` (`iname`, `ino`) VALUES ('shoes,tshirts,pants', 1);
INSERT INTO `donation`.`i_names` (`iname`, `ino`) VALUES ('books,furnitures,Devices', 2);
INSERT INTO `donation`.`i_names` (`iname`, `ino`) VALUES ('meats,Vegetables,fruits', 3);
INSERT INTO `donation`.`i_names` (`iname`, `ino`) VALUES ('Microva,anaflex,Aproxal', 4);
INSERT INTO `donation`.`i_names` (`iname`, `ino`) VALUES ('pounds,dollors', 5);
INSERT INTO `donation`.`i_names` (`iname`, `ino`) VALUES ('a+,b+,o', 6);

COMMIT;

