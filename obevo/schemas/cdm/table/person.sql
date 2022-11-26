//// CHANGE name=change0 dependencies="vocabularies.concept.change0,care_site.change0,provider.change0"
CREATE TABLE IF NOT EXISTS cdm.person
(
    person_id bigint,
    location_id bigint,
    provider_id bigint,
    care_site_id bigint,
    birth_datetime timestamp without time zone,
    death_datetime timestamp without time zone,
    year_of_birth integer NOT NULL,
    gender_source_concept_id integer NOT NULL,
    gender_concept_id integer NOT NULL,
    ethnicity_concept_id integer NOT NULL,
    ethnicity_source_concept_id integer NOT NULL,
    race_concept_id integer NOT NULL,
    race_source_concept_id integer NOT NULL,
    month_of_birth integer,
    day_of_birth integer,
    person_source_value text COLLATE pg_catalog."default",
    gender_source_value text COLLATE pg_catalog."default",
    race_source_value text COLLATE pg_catalog."default",
    ethnicity_source_value text COLLATE pg_catalog."default",
    CONSTRAINT xpk_person_id PRIMARY KEY (person_id),
    CONSTRAINT fpk_person_care_site_id FOREIGN KEY (care_site_id)
        REFERENCES cdm.care_site (care_site_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_ethnicity_concept_id FOREIGN KEY (ethnicity_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_ethnicity_source_concept_id FOREIGN KEY (ethnicity_source_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_gender_concept_id FOREIGN KEY (gender_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_gender_source_concept_id FOREIGN KEY (gender_source_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_provider_id FOREIGN KEY (provider_id)
        REFERENCES cdm.provider (provider_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_race_concept_id FOREIGN KEY (race_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_person_race_source_concept_id FOREIGN KEY (race_source_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO


//// CHANGE name=change1 dependencies=change0
COMMENT ON TABLE cdm.person
    IS 'The Person Domain contains records that uniquely identify each patient in the source data who is time at-risk to have clinical observations recorded within the source systems.';

//// CHANGE name=change2 dependencies=change1
COMMENT ON TABLE cdm.person
    IS 'The Person Domain contains records that uniquely identify each patient in the source data who is time at-risk to have clinical observations recorded within the source systems.';

COMMENT ON COLUMN cdm.person.person_id
    IS 'A unique identifier for each person.';

COMMENT ON COLUMN cdm.person.gender_concept_id
    IS 'A foreign key that refers to an identifier in the CONCEPT table for the unique gender of the person.';

COMMENT ON COLUMN cdm.person.year_of_birth
    IS 'The year of birth of the person. For data sources with date of birth, the year is extracted. For data sources where the year of birth is not available, the approximate year of birth is derived based on any age group categorization available.';

COMMENT ON COLUMN cdm.person.month_of_birth
    IS 'The month of birth of the person. For data sources that provide the precise date of birth, the month is extracted and stored in this field.';

COMMENT ON COLUMN cdm.person.day_of_birth
    IS 'The day of the month of birth of the person. For data sources that provide the precise date of birth, the day is extracted and stored in this field.';

COMMENT ON COLUMN cdm.person.birth_datetime
    IS 'The date and time of birth of the person.';

COMMENT ON COLUMN cdm.person.death_datetime
    IS 'The date and time of death of the person.';

COMMENT ON COLUMN cdm.person.race_concept_id
    IS 'A foreign key that refers to an identifier in the CONCEPT table for the unique race of the person, belonging to the ''Race'' vocabulary.';

COMMENT ON COLUMN cdm.person.ethnicity_concept_id
    IS 'A foreign key that refers to the standard concept identifier in the Standardized Vocabularies for the ethnicity of the person, belonging to the ''Ethnicity'' vocabulary.';

COMMENT ON COLUMN cdm.person.location_id
    IS 'A foreign key to the place of residency for the person in the location table, where the detailed address information is stored.';

COMMENT ON COLUMN cdm.person.provider_id
    IS 'A foreign key to the primary care provider the person is seeing in the provider table.';

COMMENT ON COLUMN cdm.person.care_site_id
    IS 'A foreign key to the site of primary care in the care_site table, where the details of the care site are stored.';

COMMENT ON COLUMN cdm.person.person_source_value
    IS 'An (encrypted) key derived from the person identifier in the source data. This is necessary when a use case requires a link back to the person data at the source dataset.';

COMMENT ON COLUMN cdm.person.gender_source_value
    IS 'The source code for the gender of the person as it appears in the source data. The person’s gender is mapped to a standard gender concept in the Standardized Vocabularies; the original value is stored here for reference.';

COMMENT ON COLUMN cdm.person.gender_source_concept_id
    IS 'A foreign key to the gender concept that refers to the code used in the source.';

COMMENT ON COLUMN cdm.person.race_source_value
    IS 'The source code for the race of the person as it appears in the source data. The person race is mapped to a standard race concept in the Standardized Vocabularies and the original value is stored here for reference.';

COMMENT ON COLUMN cdm.person.race_source_concept_id
    IS 'A foreign key to the race concept that refers to the code used in the source.';

COMMENT ON COLUMN cdm.person.ethnicity_source_value
    IS 'The source code for the ethnicity of the person as it appears in the source data. The person ethnicity is mapped to a standard ethnicity concept in the Standardized Vocabularies and the original code is, stored here for reference.';

COMMENT ON COLUMN cdm.person.ethnicity_source_concept_id
    IS 'A foreign key to the ethnicity concept that refers to the code used in the source.';

GO

//// CHANGE name=change3
CREATE INDEX IF NOT EXISTS idx_person_ethnicity_concept_id
    ON cdm.person USING btree
    (ethnicity_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change4
CREATE INDEX IF NOT EXISTS idx_person_ethnicity_source_concept_id
    ON cdm.person USING btree
    (ethnicity_source_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change5
CREATE INDEX IF NOT EXISTS idx_person_gender_concept_id
    ON cdm.person USING btree
    (gender_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change6
CREATE INDEX IF NOT EXISTS idx_person_gender_source_concept_id
    ON cdm.person USING btree
    (gender_source_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change7
CREATE INDEX IF NOT EXISTS idx_person_race_concept_id
    ON cdm.person USING btree
    (race_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change8
CREATE INDEX IF NOT EXISTS idx_person_race_source_concept_id
    ON cdm.person USING btree
    (race_source_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change9
DROP VIEW IF EXISTS datamed.person;
ALTER TABLE cdm.person
  DROP COLUMN IF EXISTS death_datetime
;

GO

//// CHANGE name=change10
DROP INDEX IF EXISTS cdm.idx_person_ethnicity_concept_id;
DROP INDEX IF EXISTS cdm.idx_person_ethnicity_source_concept_id;
DROP INDEX IF EXISTS cdm.idx_person_gender_concept_id;
DROP INDEX IF EXISTS cdm.idx_person_gender_source_concept_id;
DROP INDEX IF EXISTS cdm.idx_person_race_concept_id;
DROP INDEX IF EXISTS cdm.idx_person_race_source_concept_id;

GO

//// CHANGE name=change11
create index if not exists idx_person_birth_datetime on cdm.person(birth_datetime);
GO
