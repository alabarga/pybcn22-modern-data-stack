//// CHANGE name=change0
CREATE TABLE IF NOT EXISTS vocabularies.concept
(
    concept_id integer,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    concept_name text COLLATE pg_catalog."default" NOT NULL,
    domain_id text COLLATE pg_catalog."default" NOT NULL,
    vocabulary_id text COLLATE pg_catalog."default" NOT NULL,
    concept_class_id text COLLATE pg_catalog."default" NOT NULL,
    concept_code text COLLATE pg_catalog."default" NOT NULL,
    standard_concept text COLLATE pg_catalog."default",
    invalid_reason text COLLATE pg_catalog."default",
    CONSTRAINT xpk_concept_id PRIMARY KEY (concept_id),
    CONSTRAINT chk_concept_concept_code CHECK (concept_code::text <> ''::text),
    CONSTRAINT chk_concept_concept_name CHECK (concept_name::text <> ''::text),
    CONSTRAINT chk_concept_invalid_reason CHECK (COALESCE(invalid_reason, 'D'::character varying)::text = ANY (ARRAY['D'::character varying::text, 'U'::character varying::text])),
    CONSTRAINT chk_concept_standard_concept CHECK (COALESCE(standard_concept, 'C'::character varying)::text = ANY (ARRAY['C'::character varying::text, 'S'::character varying::text]))
)
TABLESPACE pg_default;

GO

//// CHANGE name=load_data dependencies=change0
copy vocabularies.concept (concept_id,concept_name,domain_id,vocabulary_id,concept_class_id,standard_concept,concept_code,valid_start_date,valid_end_date,invalid_reason) from program 'curl https://storage.googleapis.com/iomed-public-data/OMOP-CDM/28-JAN-22/CONCEPT.csv.gz -k -s | zcat' with csv header delimiter E'\t' QUOTE E'\r';

//// CHANGE name=change2 dependencies=load_data
COMMENT ON TABLE vocabularies.concept
    IS 'The Standardized Vocabularies contains records, or Concepts, that uniquely identify each fundamental unit of meaning used to express clinical information in all domain tables of the CDM. Concepts are derived from vocabularies, which represent clinical information across a domain (e.g. conditions, drugs, procedures) through the use of codes and associated descriptions. Some Concepts are designated Standard Concepts, meaning these Concepts can be used as normative expressions of a clinical entity within the OMOP Common Data Model and within standardized analytics. Each Standard Concept belongs to one domain, which defines the location where the Concept would be expected to occur within data tables of the CDM.  Concepts can represent broad categories (like ''Cardiovascular disease''), detailed clinical elements (''Myocardial infarction of the anterolateral wall'') or modifying characteristics and attributes that define Concepts at various levels of detail (severity of a disease, associated morphology, etc.).  Records in the Standardized Vocabularies tables are derived from national or international vocabularies such as SNOMED-CT, RxNorm, and LOINC, or custom Concepts defined to cover various aspects of observational data analysis. For a detailed description of these vocabularies, their use in the OMOP CDM and their relationships to each other please refer to the [specifications](http://www.ohdsi.org/web/wiki/doku.php?id=documentation:vocabulary).';

COMMENT ON COLUMN vocabularies.concept.concept_id
    IS 'A unique identifier for each Concept across all domains.';

COMMENT ON COLUMN vocabularies.concept.concept_name
    IS 'An unambiguous, meaningful and descriptive name for the Concept.';

COMMENT ON COLUMN vocabularies.concept.domain_id
    IS 'A foreign key to the [DOMAIN](https://github.com/OHDSI/CommonDataModel/wiki/DOMAIN) table the Concept belongs to.';

COMMENT ON COLUMN vocabularies.concept.vocabulary_id
    IS 'A foreign key to the [VOCABULARY](https://github.com/OHDSI/CommonDataModel/wiki/VOCABULARY) table indicating from which source the Concept has been adapted.';

COMMENT ON COLUMN vocabularies.concept.concept_class_id
    IS 'The attribute or concept class of the Concept. Examples are ''Clinical Drug'', ''Ingredient'', ''Clinical Finding'' etc.';

COMMENT ON COLUMN vocabularies.concept.standard_concept
    IS 'This flag determines where a Concept is a Standard Concept, i.e. is used in the data, a Classification Concept, or a non-standard Source Concept. The allowables values are ''S'' (Standard Concept) and ''C'' (Classification Concept), otherwise the content is NULL.';

COMMENT ON COLUMN vocabularies.concept.concept_code
    IS 'The concept code represents the identifier of the Concept in the source vocabulary, such as SNOMED-CT concept IDs, RxNorm RXCUIs etc. Note that concept codes are not unique across vocabularies.';

COMMENT ON COLUMN vocabularies.concept.valid_start_date
    IS 'The date when the Concept was first recorded. The default value is 1-Jan-1970, meaning, the Concept has no (known) date of inception.';

COMMENT ON COLUMN vocabularies.concept.valid_end_date
    IS 'The date when the Concept became invalid because it was deleted or superseded (updated) by a new concept. The default value is 31-Dec-2099, meaning, the Concept is valid until it becomes deprecated.';

COMMENT ON COLUMN vocabularies.concept.invalid_reason
    IS 'Reason the Concept was invalidated. Possible values are D (deleted), U (replaced with an update) or NULL when valid_end_date has the default value.';

GO

//// CHANGE name=change3
CREATE INDEX IF NOT EXISTS idx_concept_concept_name
    ON vocabularies.concept USING btree
    (concept_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
GO

//// CHANGE name=change4
CREATE INDEX IF NOT EXISTS trgm_concept_concept_name
    ON vocabularies.concept USING btree
    (concept_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
GO

//// CHANGE name=change5
CREATE INDEX IF NOT EXISTS idx_concept_concept_code
    ON vocabularies.concept USING btree
    (concept_code COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change6 dependencies=concept_class.load_data
ALTER TABLE vocabularies.concept
ADD CONSTRAINT fpk_concept_concept_class_id FOREIGN KEY (concept_class_id)
    REFERENCES vocabularies.concept_class (concept_class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    DEFERRABLE;
GO

//// CHANGE name=change7 dependencies=domain.load_data
ALTER TABLE vocabularies.concept
ADD CONSTRAINT fpk_concept_domain_id FOREIGN KEY (domain_id)
    REFERENCES vocabularies.domain (domain_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    DEFERRABLE;
GO

//// CHANGE name=change8 dependencies=vocabulary.load_data
ALTER TABLE vocabularies.concept
ADD CONSTRAINT fpk_concept_vocabulary_id FOREIGN KEY (vocabulary_id)
    REFERENCES vocabularies.vocabulary (vocabulary_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    DEFERRABLE;
GO
