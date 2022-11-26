//// CHANGE name=change0
CREATE TABLE IF NOT EXISTS cdm.care_site
(
    care_site_id bigint,
    location_id bigint,
    place_of_service_concept_id integer,
    care_site_name text
      CONSTRAINT chk_care_site_care_site_name CHECK(length(care_site_name) <= 255),
    care_site_source_value text COLLATE pg_catalog."default",
    place_of_service_source_value text COLLATE pg_catalog."default",
    CONSTRAINT xpk_care_site_id PRIMARY KEY (care_site_id)
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0

COMMENT ON TABLE cdm.care_site
    IS 'The CARE_SITE table contains a list of uniquely identified institutional (physical or organizational) units where healthcare delivery is practiced (offices, wards, hospitals, clinics, etc.).';
COMMENT ON COLUMN cdm.care_site.care_site_id
    IS 'A unique identifier for each Care Site.';
COMMENT ON COLUMN cdm.care_site.care_site_name
    IS 'The verbatim description or name of the Care Site as in data source';
COMMENT ON COLUMN cdm.care_site.place_of_service_concept_id
    IS 'A foreign key that refers to a Place of Service Concept ID in the Standardized Vocabularies.';
COMMENT ON COLUMN cdm.care_site.location_id
    IS 'A foreign key to the geographic Location in the LOCATION table, where the detailed address information is stored.';
COMMENT ON COLUMN cdm.care_site.care_site_source_value
    IS 'The identifier for the Care Site in the source data, stored here for reference.';
COMMENT ON COLUMN cdm.care_site.place_of_service_source_value
    IS 'The source code for the Place of Service as it appears in the source data, stored here for reference.';

GO
