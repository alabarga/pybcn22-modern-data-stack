//// CHANGE name=change0 dependencies="vocabularies.concept.change0,care_site.change0"
CREATE TABLE IF NOT EXISTS cdm.provider
(
    provider_id bigint NOT NULL,
    care_site_id bigint,
    specialty_concept_id integer NOT NULL,
    gender_concept_id integer NOT NULL,
    specialty_source_concept_id integer NOT NULL DEFAULT 0,
    gender_source_concept_id integer NOT NULL,
    year_of_birth integer,
    gender_source_value text COLLATE pg_catalog."default",
    provider_source_value text COLLATE pg_catalog."default",
    specialty_source_value text COLLATE pg_catalog."default",
    provider_name text
      CONSTRAINT chk_provider_provider_name CHECK( coalesce(length(provider_name), 0) <= 255),
    npi text
      CONSTRAINT chk_provider_npi CHECK ( coalesce(length(npi), 0) <= 20),
    dea text
      CONSTRAINT chk_provider_dea CHECK ( coalesce(length(dea), 0) <= 20),
    CONSTRAINT xpk_provider_id PRIMARY KEY (provider_id),
    CONSTRAINT fpk_provider_care_site_id FOREIGN KEY (care_site_id)
        REFERENCES cdm.care_site (care_site_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_provider_gender_concept_id FOREIGN KEY (gender_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_provider_gender_source_concept_id FOREIGN KEY (gender_source_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_provider_specialty_concept_id FOREIGN KEY (specialty_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_provider_specialty_source_concept_id FOREIGN KEY (specialty_source_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE cdm.provider
    IS 'The PROVIDER table contains a list of uniquely identified healthcare providers. These are individuals providing hands-on healthcare to patients, such as physicians, nurses, midwives, physical therapists etc.';

COMMENT ON COLUMN cdm.provider.provider_id
    IS 'A unique identifier for each Provider.';

COMMENT ON COLUMN cdm.provider.provider_name
    IS 'A description of the Provider.';

COMMENT ON COLUMN cdm.provider.npi
    IS 'The National Provider Identifier (NPI) of the provider.';

COMMENT ON COLUMN cdm.provider.dea
    IS 'The Drug Enforcement Administration (DEA) number of the provider.';

COMMENT ON COLUMN cdm.provider.specialty_concept_id
    IS 'A foreign key to a Standard Specialty Concept ID in the Standardized Vocabularies.';

COMMENT ON COLUMN cdm.provider.care_site_id
    IS 'A foreign key to the main Care Site where the provider is practicing.';

COMMENT ON COLUMN cdm.provider.year_of_birth
    IS 'The year of birth of the Provider.';

COMMENT ON COLUMN cdm.provider.gender_concept_id
    IS 'The gender of the Provider.';

COMMENT ON COLUMN cdm.provider.provider_source_value
    IS 'The identifier used for the Provider in the source data, stored here for reference.';

COMMENT ON COLUMN cdm.provider.specialty_source_value
    IS 'The source code for the Provider specialty as it appears in the source data, stored here for reference.';

COMMENT ON COLUMN cdm.provider.specialty_source_concept_id
    IS 'A foreign key to a Concept that refers to the code used in the source.';

COMMENT ON COLUMN cdm.provider.gender_source_value
    IS 'The gender code for the Provider as it appears in the source data, stored here for reference.';

COMMENT ON COLUMN cdm.provider.gender_source_concept_id
    IS 'A foreign key to a Concept that refers to the code used in the source.';

GO
